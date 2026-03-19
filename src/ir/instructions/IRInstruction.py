class IRInstruction:
    def to_text(self) -> str:
        raise NotImplementedError
    
    def get_parts(self) -> list[str]:
        raise NotImplementedError
    
    def get_operands(self):
        raise NotImplementedError