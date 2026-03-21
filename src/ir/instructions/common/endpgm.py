from src.ir.instructions.special.generic import GenericInstruction

class EndPgm(GenericInstruction):
    def __init__(self, is_scalar: bool):
        super().__init__("endpgm", is_scalar=is_scalar)
   
    def _get_normalize_opcode(self) -> str:
        return "s_endpgm"