from src.base_instruction import BaseInstruction
from src.decompiler_data import make_new_value_for_reg


class SMovk(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.simm16 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            self.decompiler_data.write("scc = " + self.simm16 + " // s_movk_i32\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'i32':
            return make_new_value_for_reg(self.node, self.simm16, self.sdst, [], self.suffix)
        else:
            return super().to_fill_node()
