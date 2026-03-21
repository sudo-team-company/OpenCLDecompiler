from src.ir.instructions.special.generic import GenericInstruction
from src.ir.registers.reg import Reg_ty, Val

class InitReg(GenericInstruction):
    def __init__(self, destination: Reg_ty, value: Val, is_scalar: bool):
        super().__init__("init", destination, value, is_scalar=is_scalar)

    def _get_normalize_opcode(self) -> str:
        return "s_init"