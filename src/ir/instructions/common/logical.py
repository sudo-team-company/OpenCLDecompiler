from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Val
from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER
from src.register import split_range

class And(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__("and", destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        if isinstance(operand2, Val):
            self.operand1 = operand2
            self.operand2 = operand1
        else:
            self.operand1 = operand1
            self.operand2 = operand2
        

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64

    def _get_normalize_opcode(self) -> str:
        return "v_and_b32" if self.is_scalar() else "v_and_b32"
   
    def _is_numeric_val(self, val: Val) -> bool:
        if not isinstance(val, Val):
            return False
        
        value = val.value.strip()
        if not value:
            return False
        
        if value.startswith(('0x', '0X')):
            try:
                int(value, 16)
                return True
            except ValueError:
                return False
            
        try:
            int(value, 10)
            return True
        except ValueError:
            return False

    def _split_val_to_64bit(self, val: Val) -> tuple[str, str]:
        num_value = int(val.value, 0)

        lo = num_value & 0xFFFFFFFF
        hi = (num_value >> 32) & 0xFFFFFFFF
        
        return (f"0x{lo:x}", f"{hi:x}")


    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        result = []
        opcode = self._get_normalize_opcode()
        
        if not self._is_64bit():
            dest_str = manager.map(self.destination)
            op1_str = manager.map(self.operand1)
            op2_str = manager.map(self.operand2)
            if self._is_numeric_val(self.operand1):
                op1_str = f"0x{int(self.operand1.value, 0):x}"
            result.append([opcode, dest_str, op1_str, op2_str])
        else:
            dest_lo, dest_hi = split_range(manager.map(self.destination))
            op2_lo, op2_hi = split_range(manager.map(self.operand2))
            
            if self._is_numeric_val(self.operand1):
                op1_lo, op1_hi = self._split_val_to_64bit(self.operand1)
            
            result.append([opcode, dest_lo, op1_lo, op2_lo])
            result.append([opcode, dest_hi, op1_hi, op2_hi])
        
        return result