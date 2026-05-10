from src.ir.registers.reg import RegOrVal_ty, Reg32
from src.ir.instructions.generic import GenericInstruction

from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.sop2.s_bfe import SBfe

class bfe(GenericInstruction):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "bfe_s" if signed else "bfe_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        self.signed = signed

    def _is_64bit(self) -> bool:
        return False

    def _get_normalize_opcode(self) -> str:
        if self.signed:
            return "s_bfe_i32" if self.is_scalar() else "v_bfe_i32"
        else:
            return "s_bfe_u32" if self.is_scalar() else "v_bfe_u32"
    
    def get_suffix(self) -> str:
        if self.signed:
            return "i32"
        return "u32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SBfe,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )
    

class bfe_s(bfe):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, operand2, signed=True, is_scalar=is_scalar)