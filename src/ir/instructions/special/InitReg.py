from src.ir.instructions.IRInstruction import IRInstruction

class InitReg(IRInstruction):
    def __init__(self, destination: str, value: str):
        self.destination = destination
        self.value = value
    
    def to_text(self) -> str:
        return f"s_init {self.destination}, {self.value}"
    
    def get_parts(self) -> list[str]:
        return ["s_init", self.destination, self.value]