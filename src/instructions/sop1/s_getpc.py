from src.base_instruction import BaseInstruction


class SGetpc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]

    def to_print_unresolved(self):
        if self.suffix == "b64":
            self.decompiler_data.write(f"{self.sdst} = pc + 4 // {self.name}\n")
            return self.node
        return super().to_print_unresolved()
