from src.instructions.flat.flat_load import FlatLoad
from src.instructions.smem.s_load import SLoad
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType, memory_suffix_for_bits
from src.ir.registers.reg import Reg64, Reg_ty, Val

LOAD_TYPES = (IRType.B32, IRType.B64, IRType.B128)


class GenericLoad(GenericInstruction):
    allowed_types = LOAD_TYPES
    operation: str
    backend_instruction: type

    def __init__(
        self,
        destination: Reg_ty,
        address: Reg64,
        offset: Val | None = None,
        *,
        op_type: IRType,
        memory_bits: int | None = None,
    ):
        self.destination = destination
        self.address = address
        self.offset = offset if offset is not None else Val("0")
        super().__init__("load", self.destination, self.address, self.offset, op_type=op_type)
        self.size = memory_bits or self.op_type.bits

    def _get_normalize_opcode(self) -> str:
        return f"{self.operation}_{self.get_suffix()}"

    def _get_opcode(self):
        return self.backend_instruction

    def get_suffix(self):
        return memory_suffix_for_bits(self.size)

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            self._get_opcode(),
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )


class Load(GenericLoad):
    operation: str = "s_load"
    backend_instruction: type = SLoad


class Load32(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None):
        super().__init__(destination, address, offset, op_type=IRType.B32)


class Load64(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None):
        super().__init__(destination, address, offset, op_type=IRType.B64)


class Load128(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None):
        super().__init__(destination, address, offset, op_type=IRType.B128)


class FLoad(GenericLoad):
    operation: str = "flat_load"
    backend_instruction: type = FlatLoad


class FLoad32(FLoad):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None):
        super().__init__(destination, address, offset, op_type=IRType.B32)


class FLoad64(FLoad):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None):
        super().__init__(destination, address, offset, op_type=IRType.B64)


class FLoad128(FLoad):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None):
        super().__init__(destination, address, offset, op_type=IRType.B128)
