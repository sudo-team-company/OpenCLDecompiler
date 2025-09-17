from src.base_instruction import BaseInstruction


class SSetpc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.ssrc0 = self.instruction[1]

    def to_print_unresolved(self):
        if self.suffix == "b64":
            self.decompiler_data.write(f"pc = {self.ssrc0} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()
