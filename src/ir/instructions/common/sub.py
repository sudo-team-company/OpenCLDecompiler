from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.reg import Reg_ty, RegOrVal_ty, get_reg_rang

from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.instructions.vop2.v_sub import VSub

class Sub(GenericInstruction):
    allowed_types = (IRType.U16, IRType.I16, IRType.U32, IRType.I32, IRType.U64, IRType.I64, IRType.F32)

    def __init__(
        self,
        destination: Reg_ty,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("sub", destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        
    def _is_64bit(self) -> bool:
        return self.op_type in (IRType.U64, IRType.I64)
    
    def _get_normalize_opcode(self) -> str:
        if self.op_type == IRType.F32:
            return "v_sub_f32"
        return "v_sub_u32"

    
    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        if self.op_type == IRType.F32:
            return ctx.emit_backend(
                VSub,
                self._get_normalize_opcode(),
                self.operands,
                "f32",
            )

        if not self._is_64bit():
            return ctx.emit_backend(
                VSub,
                self._get_normalize_opcode(),
                self.operands,
                "u32",
            )

        dest_lo, dest_hi = get_reg_rang(self.destination)
        op1_lo, op1_hi = get_reg_rang(self.operand1)
        op2_lo, op2_hi = get_reg_rang(self.operand2)

        ctx.emit_backend(
            VSub,
            "v_sub_u32",
            [dest_lo, op1_lo, op2_lo],
            "u32",
        )
        return ctx.emit_backend(
            VSub,
            "v_subb_u32",
            [dest_hi, op1_hi, op2_hi],
            "u32",
        )

class SubRev(Sub):
    def __init__(
        self,
        destination: Reg_ty,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__(destination, operand2, operand1, op_type=op_type)
