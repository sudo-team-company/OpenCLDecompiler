from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value


class SMulk(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.simm16 = self.instruction[2][self.instruction[2].find("x") + 1:]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            self.decompiler_data.write(self.sdst + " = " + self.sdst + " * " + self.simm16 + " // s_mulk_i32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'i32':
            new_value = make_op(self.node, self.sdst, self.simm16, " * ")
            return set_reg_value(self.node, new_value, self.sdst, [self.sdst], self.suffix)
        return super().to_fill_node()
