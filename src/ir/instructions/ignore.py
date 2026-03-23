from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER

class Ignore(GenericInstruction):
    def __init__(self, *operands, is_scalar):
        super().__init__("", is_scalar)

    def to_text(self) -> str:
        return ""
    
    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        return []
    
    def get_operands(self):
        return []
    
