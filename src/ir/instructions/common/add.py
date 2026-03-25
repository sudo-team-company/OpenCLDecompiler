from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER
from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Reg64, Val, Reg32
from src.register import split_range
from typing import Optional
from src.ir.TemporaryVariableAllocator import tva

class Add(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar: bool = False):
        self.operand2_val: Optional[Val] = None
        self.operand2_tmp_reg: Optional[Reg_ty] = None
        
        if isinstance(operand2, Val):
            if destination.bit_width == 64:
                self.operand2_tmp_reg = Reg64(tva.generate("add"))
            else:
                self.operand2_tmp_reg = Reg32(tva.generate("add"))
            
            self.operand2_val = operand2
        
        
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

    def get_operands(self):
        if self.operand2_tmp_reg is not None:
            return super().get_operands() + (self.operand2_tmp_reg,)
        return super().get_operands()

    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        result = []
        operand2 = self.operand2
        if self.operand2_val is not None:
            tmp_reg_str = manager.map(self.operand2_tmp_reg)
            val_str = manager.map(self.operand2_val)
            if self.operand2_tmp_reg.bit_width == 32:
                result.append(["v_mov_b32", tmp_reg_str, val_str])
            else:
                tmp_lo, tmp_hi = split_range(tmp_reg_str)
                result.append(["v_mov_b32", tmp_lo, val_str])
                result.append(["s_mov_b32", tmp_hi, '0'])

            operand2 = self.operand2_tmp_reg

        if not self._is_64bit():
            opcode = self._get_normalize_opcode()
            dest_str = manager.map(self.destination)
            op1_str = manager.map(self.operand1)
            op2_str = manager.map(operand2)
            
            if self.is_scalar():
                result.append([opcode, dest_str, op1_str, op2_str])
            else:
                result.append([opcode, dest_str, "vcc", op1_str, op2_str])
        else:
            dest_lo, dest_hi = split_range(manager.map(self.destination))
            op1_lo, op1_hi = split_range(manager.map(self.operand1))
            op2_lo, op2_hi = split_range(manager.map(operand2))

            add_opcode = self._get_normalize_opcode()
            addc_opcode =  self._get_normalize_opcode(is_addc=True)

            if self.is_scalar():
                line1 = [add_opcode, dest_lo, op1_lo, op2_lo]
                line2 = [addc_opcode, dest_hi, op1_hi, op2_hi]
            else:
                line1 = [add_opcode, dest_lo, "vcc", op1_lo, op2_lo]
                line2 = [addc_opcode, dest_hi, "vcc", op1_hi, op2_hi, "vcc"]

            result.extend([line1, line2])


        return result
        


class AddC(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar: bool = False):
        super().__init__("addc", destination, operand1, operand2, is_scalar=is_scalar)
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
       