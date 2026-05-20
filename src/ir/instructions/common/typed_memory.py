from dataclasses import dataclass

from src.instructions.flat.flat_load import FlatLoad
from src.instructions.flat.flat_store import FlatStore
from src.instructions.smem.s_load import SLoad
from src.instructions.sop1.s_mov import SMov
from src.instructions.sop2.s_and import SAnd
from src.instructions.sop2.s_bfe import SBfe
from src.instructions.vop3.v_perm import VPerm
from src.ir.instructions.common.load import GenericLoad
from src.ir.instructions.common.store import GenericStore
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import MEMORY_VALUE_TYPES, IRType
from src.ir.registers.reg import CompositeReg, Reg32, Reg64, Reg_ty, RegOrVal_ty, Val
from src.ir.temporary_variable_allocator import TemporaryVariableAllocator

DWORD_BITS = 32
PAIR_VECTOR_WIDTH = 2
DWORD_VECTOR_TOTAL_BITS = {64, 128}

_IR_TYPE_BY_MEMORY_BASE_TYPE = {
    "b8": IRType.B8,
    "b16": IRType.B16,
    "b32": IRType.B32,
    "b64": IRType.B64,
    "u8": IRType.U8,
    "u16": IRType.U16,
    "u32": IRType.U32,
    "u64": IRType.U64,
    "s8": IRType.I8,
    "s16": IRType.I16,
    "s32": IRType.I32,
    "s64": IRType.I64,
    "f16": IRType.F16,
    "f32": IRType.F32,
    "f64": IRType.F64,
}


class TypedMemoryStoreRegisterCountError(ValueError):
    def __init__(self, access_type: "MemoryAccessType") -> None:
        super().__init__(f"{access_type.to_value_type()} store expects {access_type.vector_width} source registers")


@dataclass(frozen=True)
class MemoryAccessType:
    address_space: str
    base_type: str
    vector_width: int = 1

    @property
    def element_bits(self) -> int:
        return int(self.base_type[1:])

    @property
    def total_bits(self) -> int:
        return self.element_bits * self.vector_width

    def to_ir_type(self) -> IRType:
        return _IR_TYPE_BY_MEMORY_BASE_TYPE[self.base_type]

    def to_opencl_type(self) -> str:
        return f"__{self.address_space} {self.to_value_type()}"

    def to_value_type(self) -> str:
        base = {
            "b8": "char",
            "u8": "char",
            "s8": "char",
            "b16": "short",
            "u16": "short",
            "s16": "short",
            "b32": "uint",
            "u32": "uint",
            "s32": "int",
            "b64": "ulong",
            "u64": "ulong",
            "s64": "long",
            "f16": "half",
            "f32": "float",
            "f64": "double",
        }.get(self.base_type, self.base_type)

        if self.vector_width > 1:
            base = f"{base}{self.vector_width}"

        return base

    def to_element_type(self) -> str:
        return MemoryAccessType(self.address_space, self.base_type, 1).to_value_type()


class TypedMemoryLoadBase(GenericLoad):
    allowed_types = MEMORY_VALUE_TYPES

    def __init__(
        self,
        destination: Reg_ty,
        address: Reg64,
        offset: Val,
        access_type: MemoryAccessType,
    ):
        super().__init__(
            destination,
            address,
            offset,
            op_type=access_type.to_ir_type(),
            memory_bits=max(32, access_type.total_bits),
        )
        self.access_type = access_type
        self.packed_value = self._make_internal_reg("typed_ld")

    def to_fill_node(self, state, parents):
        if self.packed_value is None:
            if self._needs_dword_vector_load():
                return NodeLoweringContext(state, parents).emit_backend(
                    self._get_opcode(),
                    self._get_normalize_opcode(),
                    [self.destination, self.address, self.offset],
                    self.get_suffix(),
                )
            return super().to_fill_node(state, parents)

        ctx = NodeLoweringContext(state, parents)
        ctx.emit_backend(
            self._get_opcode(),
            self._get_normalize_opcode(),
            [self.packed_value, self.address, self.offset],
            self.get_suffix(),
        )

        assert isinstance(self.destination, CompositeReg)
        for index, destination in enumerate(self.destination.regs):
            if index == 0:
                result = ctx.emit_backend(SAnd, "s_and_b32", [destination, self.packed_value, self._low_mask()], "b32")
                continue

            selector = self._bfe_selector(index)
            result = ctx.emit_backend(SBfe, "s_bfe_u32", [destination, self.packed_value, selector], "u32")

        return result

    def _make_internal_reg(self, prefix: str) -> Reg32 | None:
        if self._needs_small_vector_unpack():
            return Reg32(TemporaryVariableAllocator.generate(prefix))
        return None

    def _needs_small_vector_unpack(self) -> bool:
        return (
            isinstance(self.destination, CompositeReg)
            and self.access_type.vector_width > 1
            and self.access_type.element_bits < DWORD_BITS
            and self.access_type.total_bits <= DWORD_BITS
        )

    def _low_mask(self) -> Val:
        return Val(hex((1 << self.access_type.element_bits) - 1))

    def _bfe_selector(self, index: int) -> Val:
        offset = index * self.access_type.element_bits
        width = self.access_type.element_bits
        return Val(hex((width << 16) | offset))

    def _needs_dword_vector_load(self) -> bool:
        return (
            isinstance(self.destination, CompositeReg)
            and self.access_type.vector_width > 1
            and self.access_type.element_bits == DWORD_BITS
            and self.access_type.total_bits in DWORD_VECTOR_TOTAL_BITS
        )


class TypedMemoryLoad(TypedMemoryLoadBase):
    operation: str = "s_load"
    backend_instruction: type = SLoad


class TypedMemoryFLoad(TypedMemoryLoadBase):
    operation: str = "flat_load"
    backend_instruction: type = FlatLoad


class TypedMemoryStoreBase(GenericStore):
    allowed_types = MEMORY_VALUE_TYPES

    PACK_SELECTOR = Val("0x2010004")

    def __init__(
        self,
        address: Reg64,
        value: RegOrVal_ty,
        access_type: MemoryAccessType,
    ):
        super().__init__(
            address,
            value,
            op_type=access_type.to_ir_type(),
            memory_bits=max(8, access_type.total_bits),
        )
        self.access_type = access_type
        self.selector = self._make_internal_reg("perm_selector")
        self.packed_value = self._make_internal_reg("typed_st")
        self.store_value = self._make_dword_vector_store_value()

    def to_fill_node(self, state, parents):
        if not isinstance(self.value, CompositeReg):
            return super().to_fill_node(state, parents)

        if self._needs_small_vector_pack():
            return self._to_fill_small_vector_store_parts(state, parents)

        if self.store_value is not None:
            return self._to_fill_dword_vector_store_parts(state, parents)

        return super().to_fill_node(state, parents)

    def _to_fill_small_vector_store_parts(self, state, parents):
        assert isinstance(self.value, CompositeReg)
        ctx = NodeLoweringContext(state, parents)
        opcode = self._get_opcode()
        first_value = self.value.get_element(0)
        second_value = self.value.get_element(1)
        ctx.emit_backend(SMov, "s_mov_b32", [self.selector, self.PACK_SELECTOR], "b32")
        if self.access_type.vector_width == PAIR_VECTOR_WIDTH:
            ctx.emit_backend(
                VPerm,
                "v_perm_b32",
                [self.packed_value, first_value, second_value, self.selector],
                "b32",
            )
            return ctx.emit_backend(
                opcode,
                self._get_normalize_opcode(),
                [self.address, self.packed_value],
                self.get_suffix(),
            )

        return super().to_fill_node(ctx.state, ctx.parents)

    def _needs_small_vector_pack(self) -> bool:
        return (
            isinstance(self.value, CompositeReg)
            and self.access_type.vector_width in {2, 4}
            and self.access_type.element_bits < DWORD_BITS
            and self.access_type.total_bits <= DWORD_BITS
        )

    def _make_internal_reg(self, prefix: str) -> Reg32 | None:
        if self._needs_small_vector_pack():
            return Reg32(TemporaryVariableAllocator.generate(prefix))
        return None

    def _needs_dword_vector_store(self) -> bool:
        return (
            isinstance(self.value, CompositeReg)
            and self.access_type.vector_width > 1
            and self.access_type.element_bits == DWORD_BITS
            and self.access_type.total_bits in DWORD_VECTOR_TOTAL_BITS
        )

    def _to_fill_dword_vector_store_parts(self, state, parents):
        assert isinstance(self.value, CompositeReg)
        assert self.store_value is not None

        ctx = NodeLoweringContext(state, parents)
        for index, source in enumerate(self.value.regs):
            ctx.emit_backend(SMov, "s_mov_b32", [self.store_value.get_element(index), source], "b32")

        return ctx.emit_backend(
            self._get_opcode(),
            self._get_normalize_opcode(),
            [self.address, self.store_value],
            self.get_suffix(),
        )

    def _make_dword_vector_store_value(self) -> CompositeReg | None:
        if not self._needs_dword_vector_store():
            return None

        assert isinstance(self.value, CompositeReg)
        if len(self.value) != self.access_type.vector_width:
            raise TypedMemoryStoreRegisterCountError(self.access_type)

        name = TemporaryVariableAllocator.generate("typed_st_vec")
        regs = [
            Reg32(TemporaryVariableAllocator.generate("typed_st_vec_part"))
            for _ in range(self.access_type.vector_width)
        ]
        return CompositeReg(name, regs)


class TypedMemoryStore(TypedMemoryStoreBase):
    operation: str = "flat_store"
    backend_instruction: type = FlatStore


class TypedMemoryFStore(TypedMemoryStoreBase):
    operation: str = "flat_store"
    backend_instruction: type = FlatStore
