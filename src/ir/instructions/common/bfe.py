from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Reg32, CompositeReg
from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER
from src.ir.TemporaryVariableAllocator import tva

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
        
class bfe_s(bfe):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, operand2, signed=True, is_scalar=is_scalar)