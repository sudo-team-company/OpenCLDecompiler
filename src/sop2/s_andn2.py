from src.base_instruction import BaseInstruction


class SAndn2(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b64':
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " & ~" + self.ssrc1 + " // s_andn2_b64\n")
            self.decompiler_data.write("scc" + " = " + self.sdst + " != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        return self.node
