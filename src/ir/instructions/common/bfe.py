from src.instructions.sop2.s_bfe import SBfe
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Reg32, RegOrVal_ty


class Bfe(GenericInstruction):
    allowed_types = (IRType.U32, IRType.I32)

    def __init__(
        self,
        destination: Reg32,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        name = "bfe"
        super().__init__(name, destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2

    def _is_64bit(self) -> bool:
        return False

    def _get_normalize_opcode(self) -> str:
        if self.op_type == IRType.I32:
            return "s_bfe_i32"
        return "s_bfe_u32"

    def get_suffix(self) -> str:
        if self.op_type == IRType.I32:
            return "i32"
        return "u32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SBfe,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )
