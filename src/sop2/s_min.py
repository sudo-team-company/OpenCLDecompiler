from src.base_instruction import BaseInstruction
from src.decompiler_data import make_new_value_for_reg


class SMin(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            self.decompiler_data.write(self.sdst + " = min((int)" + self.ssrc0 +
                                       ", (int)" + self.ssrc1 + ") // s_min_i32\n")
            self.decompiler_data.write("scc = (int)" + self.ssrc0 + " < (int)" + self.ssrc1 + "\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'i32':
            new_value = "min((int)" + self.node.state.registers[self.ssrc0].val + ", (int)" \
                        + self.node.state.registers[self.ssrc1].val + ")"
            return make_new_value_for_reg(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix)
        else:
            return super().to_fill_node()
