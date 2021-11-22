from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg


class SOr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b64':
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " | " + self.ssrc1 + "\n")
            self.decompiler_data.write("scc = " + self.sdst + "!=0\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'b64':
            new_value, src0_reg, src1_reg = make_op(self.node, self.ssrc0, self.ssrc1, " | ")
            reg_entire = self.node.state.registers[self.ssrc1].integrity
            return make_new_value_for_reg(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1],
                                          self.suffix, reg_entire=reg_entire)
        else:
            return super().to_fill_node()
