from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.reg import Reg64, Reg_ty, Val, RegOrVal_ty, Reg32
from typing import Optional
from src.ir.TemporaryVariableAllocator import tva
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER

class LocalMemory(GenericInstruction):
    def __init__(self, destination: Reg64, size, is_scalar: bool = True):
        super().__init__("local", destination, size, is_scalar=is_scalar)
    def _get_normalize_opcode(self) -> str:
        return "s_local"

class LocalStore(GenericInstruction):
    def __init__(self, destination: Reg_ty, val: Reg_ty, is_scalar: bool = True):
        super().__init__("local_store", destination, val, is_scalar=is_scalar)
    def _get_normalize_opcode(self) -> str:
        return "ds_write_b32"
    
class LocalLoad(GenericInstruction):
    def __init__(self, destination: Reg64, from_mem: Reg_ty, is_scalar: bool = True):
        super().__init__("local_load", destination, from_mem, is_scalar=is_scalar)
    def _get_normalize_opcode(self) -> str:
        return "ds_read_b32"

class LocalAdd(GenericInstruction):
    def __init__(self, destination: Reg64, val: RegOrVal_ty, is_scalar: bool = True):
        super().__init__("local_add", destination, val, is_scalar=is_scalar)
        self.operand1_val: Optional[Val] = None
        self.operand1_tmp_reg: Optional[Reg32] = None
        
        if isinstance(val, Val):
            tmp_reg_name = tva.generate("mad")
            self.operand1_tmp_reg = Reg32(tmp_reg_name)
            self.operand1_val = val

        self.destination = destination
        self.operand1 = val


    def _get_normalize_opcode(self) -> str:
        return "ds_add_u32"
    
    def get_operands(self):
        if self.operand1_tmp_reg is not None:
            return super().get_operands() + (self.operand1_tmp_reg,)
        return super().get_operands()
    
    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        result = []

        opcode = self._get_normalize_opcode()
        dest_str = manager.map(self.destination)
        op1_str = manager.map(self.operand1)

        if self.operand1_val is not None:
            tmp_reg_str = manager.map(self.operand1_tmp_reg)
            val_str = manager.map(self.operand1_val)
            result.append(["s_mov_b32", tmp_reg_str, val_str])
            result.append([opcode, dest_str, tmp_reg_str])   
            return result

        result.append([opcode, dest_str, op1_str])   
        return result