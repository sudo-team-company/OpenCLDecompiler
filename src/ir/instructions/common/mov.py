from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Val
from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER
from src.register import split_range

class Mov(GenericInstruction):

    def __init__(self, destination: Reg_ty, source: RegOrVal_ty, is_scalar):
        super().__init__("mov", destination, source, is_scalar=is_scalar)
        self.destination = destination
        self.source = source

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64

    def _get_normalize_opcode(self) -> str:
        return "s_mov_b64" if self._is_64bit() else "v_mov_b32"

    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        result = []
        
        if self._is_64bit() and isinstance(self.source, Val):
            dest_lo, dest_hi = split_range(manager.map(self.destination))
            val_str = manager.map(self.source)
            result.append(["v_mov_b32", dest_lo, val_str])
            result.append(["v_mov_b32", dest_hi, "0"])
            
            return result
        
        elif self._is_64bit():
            dest_lo, dest_hi = split_range(manager.map(self.destination))
            src_lo, src_hi = split_range(manager.map(self.source))
            result.append(["v_mov_b32", dest_lo, src_lo])
            result.append(["v_mov_b32", dest_hi, src_hi])
            
            return result
        
        
        opcode = self._get_normalize_opcode()
        dest_str = manager.map(self.destination)
        src_str = manager.map(self.source)

        result.append([opcode, dest_str, src_str])
        return result
        

class MovK(GenericInstruction):
    def __init__(self, destination: Reg_ty, source: RegOrVal_ty, is_scalar):
        super().__init__("mov", destination, source, is_scalar=is_scalar)
        self.destination = destination
        self.source = source

    def _is_64bit(self) -> bool:
        return False

    def _get_normalize_opcode(self) -> str:
        return "s_movk_i32"
