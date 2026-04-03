from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Reg32, CompositeReg
from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER
from src.register import split_range



class Mul24(GenericInstruction):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "mul_s" if signed else "mul_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.signed = signed


    def _get_normalize_opcode(self) -> str:
        return "v_mul_i32_i24"
    

    


class MulLo(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "mul_s" if signed else "mul_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        self.signed = signed

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64
    
    def _get_normalize_opcode(self) -> str:
        return "v_mul_lo_i32" if self.signed else "s_mul_i32"
    
    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        result = []

        if not self._is_64bit():
            return super().get_parts(manager)
        
        dest_lo, dest_hi = split_range(manager.map(self.destination))
        op1_lo, op1_hi = split_range(manager.map(self.operand1))
        op2_lo, op2_hi = split_range(manager.map(self.operand2))

        result.append(["v_mul_hi_u32", dest_lo, op1_lo, op2_lo])
        result.append(["v_mul_lo_u32", dest_hi, op1_lo, op2_hi])
        result.append(["v_add_u32", dest_hi, "vcc", dest_hi, dest_lo])
        result.append(["v_mul_lo_u32", dest_lo, op1_hi, op2_lo])
        result.append(["v_add_u32", dest_hi, "vcc", dest_hi, dest_lo])
        result.append(["v_mul_lo_u32", dest_lo, op1_lo, op2_lo])

        return result


class MulLo_s(MulLo):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, operand2, signed=True, is_scalar=is_scalar)




class MulHi(GenericInstruction):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "mul_hi_s" if signed else "mul_hi_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.signed = signed

    def _get_normalize_opcode(self) -> str:
        return "v_mul_hi_i32" if self.signed else "s_mul_hi_u32"
    



class MulHi_s(MulHi):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, operand2, signed=True, is_scalar=is_scalar)    




class MulWide(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "mul64_s" if signed else "mul64_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        self.signed = signed

    def _is_64bit(self) -> bool:
        return True

    def _get_normalize_opcode(self) -> str:
        return "v_mad_i64_i32"  if self.signed else "v_mad_u64_u32" 
    
    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        opcode = self._get_normalize_opcode()
        dest_str = manager.map(self.destination)
        op1_str = manager.map(self.operand1)
        op2_str = manager.map(self.operand2)

        return [[opcode, dest_str, '0', op1_str, op2_str, '0']]
    
class MulWide_s(MulWide):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, operand2, signed=True, is_scalar=is_scalar)    

