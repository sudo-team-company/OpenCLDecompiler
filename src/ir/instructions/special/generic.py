from src.ir.instructions.IRInstruction import IRInstruction

class GenericInstruction(IRInstruction):
    def __init__(self, opcode: str, *operands: str):
        self.opcode = opcode
        self.operands = list(operands)
    
    def to_text(self) -> str:
        if self.operands:
            return f"{self.opcode} {', '.join(self.operands)}"
        return self.opcode
    
    def get_parts(self) -> list[str]:
        return [self.opcode] + self.operands