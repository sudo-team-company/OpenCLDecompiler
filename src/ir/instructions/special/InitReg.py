from src.ir.instructions.special.generic import GenericInstruction
from src.ir.registers.reg import Reg_ty, Val

class InitReg(GenericInstruction):
    def __init__(self, destination: Reg_ty, value: Val):
        super().__init__("s_init", destination, value)