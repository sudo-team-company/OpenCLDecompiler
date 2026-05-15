from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.registers.reg import Reg64, RegOrVal_ty
from src.ir.instructions.types import BIT_TYPES, IRType, memory_suffix_for_bits
from src.instructions.flat.flat_store import FlatStore


class GenericStore(GenericInstruction):
    allowed_types = BIT_TYPES

    operation: str
    backend_instruction: type

    def __init__(
        self,
        address: Reg64,
        value: RegOrVal_ty,
        op_type: IRType,
        memory_bits: int | None = None,
    ):
        self.address = address
        self.value = value
        super().__init__("store", address, value, op_type=op_type)
        self.size = memory_bits or self.op_type.bits

    def _get_normalize_opcode(self) -> str:
        return f"{self.operation}_{self.get_suffix()}"

    def _get_opcode(self):
        return self.backend_instruction

    def writes_first_operand(self) -> bool:
        return False

    def get_suffix(self):
        return memory_suffix_for_bits(self.op_type.bits)

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            self._get_opcode(),
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )

class Store(GenericStore):
    operation: str = "flat_store"
    backend_instruction: type = FlatStore


class Store8(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B8)


class Store16(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B16)


class Store32(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B32)


class Store64(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B64)


class Store128(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B128)


class FStore(GenericStore):
    operation: str = "flat_store"
    backend_instruction: type = FlatStore


class FStore8(FStore):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B8)


class FStore16(FStore):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B16)


class FStore32(FStore):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B32)


class FStore64(FStore):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B64)


class FStore128(FStore):
    def __init__(self, address: Reg64, value: RegOrVal_ty):
        super().__init__(address, value, op_type=IRType.B128)
