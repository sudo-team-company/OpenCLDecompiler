from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER

class GenericInstruction:
    def __init__(self, opcode: str, *operands, is_scalar: bool = False):
        self.opcode = opcode
        self.operands = tuple(operands)
        self._is_scalar = is_scalar

    def to_text(self) -> str:
        if self.operands:
            operand_strings = [op.to_text() for op in self.operands]
            return f"{self.opcode} {', '.join(operand_strings)}"
        return self.opcode
    
    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        normalized = [manager.map(op) for op in self.operands]
        return [[self._get_normalize_opcode()] + normalized]
    
    def get_operands(self):
        return self.operands
    
    def is_scalar(self):
        return self._is_scalar
    
    def _get_normalize_opcode(self):
        return self.opcode