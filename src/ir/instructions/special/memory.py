from src.ir.instructions.IRInstruction import IRInstruction


class MemoryAllocation(IRInstruction):
    def __init__(self, destination: str):
        self.destination = destination
    
    def to_text(self) -> str:
        return f"s_alloc {self.destination}"

    def get_parts(self) -> list[str]:
        return ["s_alloc", self.destination]

class Store(IRInstruction):
    def __init__(self, destination: str, arg_name: str, arg_type: str, offset: int):
        self.destination = destination
        self.arg_type = arg_type
        self.arg_name = arg_name
        self.offset = offset

    def to_text(self) -> str:
        return f"s_store {self.destination}, {self.arg_type} {self.arg_name}, {self.offset:#x}"

    def get_parts(self) -> list[str]:
        return ["s_store", self.destination,  self.arg_type, self.arg_name, str(self.offset)]