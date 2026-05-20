from src.instructions.sop2.s_and import SAnd
from src.instructions.sop2.s_or import SOr
from src.instructions.sop2.s_xor import SXor
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Reg_ty, RegOrVal_ty

QWORD_BITS = 64


class LogicalInstruction(GenericInstruction):
    allowed_types = (IRType.B32, IRType.B64, IRType.PRED)

    operation: str
    backend_instruction: type

    def __init__(
        self,
        destination: Reg_ty,
        operand1: Reg_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__(self.operation, destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == QWORD_BITS

    def _get_normalize_opcode(self) -> str:
        if self._is_64bit():
            return f"s_{self.operation}_b64"
        return f"s_{self.operation}_b32"

    def get_suffix(self):
        return "b64" if self._is_64bit() else "b32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            self.backend_instruction,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )


class And(LogicalInstruction):
    operation = "and"
    backend_instruction = SAnd


class Or(LogicalInstruction):
    operation = "or"
    backend_instruction = SOr


class Xor(LogicalInstruction):
    operation = "xor"
    backend_instruction = SXor
