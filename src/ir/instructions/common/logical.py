from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Val
from src.ir.instructions.generic import GenericInstruction
from src.instructions.sop2.s_and import SAnd
from src.instructions.sop2.s_xor import SXor
from src.instructions.sop2.s_or import SOr
from src.ir.instructions.lowering import NodeLoweringContext


class LogicalInstruction(GenericInstruction):
    operation: str
    backend_instruction: type

    def __init__(self, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__(self.operation, destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        if isinstance(operand2, Val) and not is_scalar:
            self.operand1 = operand2
            self.operand2 = operand1
        else:
            self.operand1 = operand1
            self.operand2 = operand2
        

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64

    def _get_normalize_opcode(self) -> str:
        if self._is_64bit():
            return f's_{self.operation}_b64'
        return f's_{self.operation}_b32'
    
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