from src.ir.instructions.IRInstruction import IRInstruction
from src.ir.registers.register_manager import RegisterManager

class GenericInstruction(IRInstruction):
    def __init__(self, opcode: str, *operands):
        self.opcode = opcode
        self.operands = tuple(operands)


    def to_text(self) -> str:
        if self.operands:
            operand_strings = [op.to_text() for op in self.operands]
            return f"{self.opcode} {', '.join(operand_strings)}"
        return self.opcode
    
    def get_parts(self, manager: RegisterManager = None) -> list[str]:
        if manager:
            normalized = [manager.map(op) for op in self.operands]
            return [self.opcode] + normalized
        return [self.opcode, *[op.name for op in self.operands]]
    
    def get_operands(self):
        return self.operands