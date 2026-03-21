from src.ir.registers.reg import Reg64, Reg_ty, Val
from src.ir.instructions.special.generic import GenericInstruction

class Load(GenericInstruction):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val, is_scalar):
        super().__init__("load", destination, address, offset, is_scalar=is_scalar)
        self.destination = destination
        self.address = address
        self.offset = offset

    def _get_normalize_opcode(self) -> str:
        prefix = "s_load"

        if self.address.bit_width <= 32:
            return f"{prefix}_dword"
        elif self.address.bit_width <= 64:
            return f"{prefix}_dwordx2"
        else:
            return f"{prefix}_dwordx4"
