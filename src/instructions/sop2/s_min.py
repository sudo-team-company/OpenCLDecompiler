from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value


class SMin(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "i32":
            self.decompiler_data.write(
                self.sdst + " = min((int)" + self.ssrc0 + ", (int)" + self.ssrc1 + ") // s_min_i32\n"
            )
            self.decompiler_data.write("scc = (int)" + self.ssrc0 + " < (int)" + self.ssrc1 + "\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "i32":
            new_value = "min("
            if self.node.state[self.ssrc0].data_type != self.suffix:
                new_value += "(int)"
            new_value += self.node.state[self.ssrc0].val + ", "
            if self.node.state[self.ssrc1].data_type != self.suffix:
                new_value += "(int)"
            new_value += self.node.state[self.ssrc1].val + ")"
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix)
        return super().to_fill_node()
