from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value


class SMovk(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.simm16 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == "i32":
            self.decompiler_data.write("scc = " + self.simm16 + " // s_movk_i32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "i32":
            return set_reg_value(self.node, self.simm16, self.sdst, [], self.suffix)
        return super().to_fill_node()
