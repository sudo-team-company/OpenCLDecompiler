from src.instructions.vop3.v_perm import VPerm
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Reg_ty, RegOrVal_ty


class Permute32(GenericInstruction):
    allowed_types = (IRType.B32,)

    def __init__(
        self,
        destination: Reg_ty,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        selector: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("permute", destination, operand1, operand2, selector, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        return "v_perm_b32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(VPerm, "v_perm_b32", self.operands, "b32")
