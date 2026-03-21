from src.ir.registers.reg import Reg_ty, RegOrVal_ty
from src.ir.instructions.special.generic import GenericInstruction

class Mov(GenericInstruction):

    def __init__(self, destination: Reg_ty, source: RegOrVal_ty, is_scalar):
        super().__init__("mov", destination, source, is_scalar=is_scalar)
        self.destination = destination
        self.source = source

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64

    def _get_normalize_opcode(self) -> str:
        return "s_mov_b64" if self._is_64bit() else "v_mov_b32"


class MovK(GenericInstruction):
    def __init__(self, destination: Reg_ty, source: RegOrVal_ty, is_scalar):
        super().__init__("mov", destination, source, is_scalar=is_scalar)
        self.destination = destination
        self.source = source

    def _is_64bit(self) -> bool:
        return False

    def _get_normalize_opcode(self) -> str:
        return "s_movk_i32"
