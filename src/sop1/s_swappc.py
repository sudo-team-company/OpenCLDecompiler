from src.base_instruction import BaseInstruction


class SSwappc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == 'b64':
            self.decompiler_data.write(self.sdst + " = pc + 4 // s_swappc_b64\n")
            self.decompiler_data.write("pc = " + self.ssrc0 + "\n")
            return self.node
        return super().to_print_unresolved()
