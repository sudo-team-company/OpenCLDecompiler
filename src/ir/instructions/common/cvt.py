from src.ir.registers.reg import Reg_ty, RegOrVal_ty
from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER
from src.register import split_range


class Cvt64_32(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty,
                 signed=False,  is_scalar=False):
        super().__init__("cvt32to64", destination, operand1, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.signed = signed
    
    def _get_normalize_opcode(self, is_ext: bool = False) -> str:
        if is_ext:
            return "s_ashr_i32" if self.signed else "s_mov_b32"
        return "s_mov_b32"

    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        result = []
        src_str = manager.map(self.operand1)
        dest_lo, dest_hi = split_range(manager.map(self.destination))
        
        mov_opcode = self._get_normalize_opcode()
        ext_opcode = self._get_normalize_opcode(is_ext=True)

        
        result.append([mov_opcode, dest_lo, src_str])
        
        if self.signed:
            result.append([ext_opcode, dest_hi, src_str, "31"])
        else:
            result.append([ext_opcode, dest_hi, "0"])
        
        return result
    
class Cvt64_32_s(Cvt64_32):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, is_scalar=is_scalar, signed=True)
    
class Cvt32_16(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, 
                 signed: bool = False, is_scalar: bool = False):
        super().__init__("cvt32to16", destination, operand1, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.signed = signed
        
    def _is_64bit(self) -> bool:
        return False
    
    def _get_normalize_opcode(self) -> str:
        return "s_and_b32" if self.is_scalar() else "v_and_b32"

    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        result = []
        opcode_str = self._get_normalize_opcode()
        dest_str = manager.map(self.destination)
        src_str = manager.map(self.operand1)
        
        result.append([opcode_str, dest_str, "0xffff", src_str])
        
        return result