from src.base_instruction import BaseInstruction


class SSetpc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.ssrc0 = self.instruction[1]

    def to_print_unresolved(self):
        if self.suffix == 'b64':
            self.decompiler_data.write("pc = " + self.ssrc0 + " // s_setpc_b64\n")
            return self.node
        else:
            return super().to_print_unresolved()
