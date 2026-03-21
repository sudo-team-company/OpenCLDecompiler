from src.ir.instructions.special.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER
from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Reg64, CompositeReg
from src.register import split_range


class Add(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar: bool = False):
        super().__init__("add", destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        
    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64
    
    def _get_normalize_opcode(self, is_addc: bool = False) -> str:
        is_scalar = self.is_scalar()
        if is_addc:
            return "s_addc_u32" if is_scalar else "v_addc_u32"
        return "s_add_u32" if is_scalar else "v_add_u32"

    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
    
        if not self._is_64bit():
            opcode = self._get_normalize_opcode()
            dest_str = manager.map(self.destination)
            op1_str = manager.map(self.operand1)
            op2_str = manager.map(self.operand2)
            
            if self.is_scalar():
                return [[opcode, dest_str, op1_str, op2_str]]
            else:
                return [[opcode, dest_str, "vcc", op1_str, op2_str]]
        else:
            dest_lo, dest_hi = split_range(manager.map(self.destination))
            op1_lo, op1_hi = split_range(manager.map(self.operand1))
            op2_lo, op2_hi = split_range(manager.map(self.operand2))

            add_opcode = self._get_normalize_opcode()
            addc_opcode =  self._get_normalize_opcode(is_addc=True)

            if self.is_scalar():
                line1 = [add_opcode, dest_lo, op1_lo, op2_lo]
                line2 = [addc_opcode, dest_hi, op1_hi, op2_hi]
            else:
                line1 = [add_opcode, dest_lo, "vcc", op1_lo, op2_lo]
                line2 = [addc_opcode, dest_hi, "vcc", op1_hi, op2_hi, "vcc"]

            return [line1, line2]
        


class AddC(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar: bool = False):
        super().__init__("addс", destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        

    def _get_normalize_opcode(self) -> str:
        return "s_addc_u32" if self.is_scalar() else "v_addc_u32"

    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        opcode = self._get_normalize_opcode()
        dest_str = manager.map(self.destination)
        op1_str = manager.map(self.operand1)
        op2_str = manager.map(self.operand2)
        
        if self.is_scalar():
            return [[opcode, dest_str, op1_str, op2_str]]
        else:
            return [[opcode, dest_str, "vcc", op1_str, op2_str, "vcc"]]
       