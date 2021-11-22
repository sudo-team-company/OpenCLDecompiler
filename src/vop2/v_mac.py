from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg


class VMac(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'f32':
            self.decompiler_data.write(self.vdst + " = as_float(" + self.src0 + ") * as_float("
                                       + self.src1 + ") + as_float(" + self.vdst + ") // v_mac_f32\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'f32':
            new_val, src0_reg, src1_reg = make_op(self.node, self.src0, self.src1, " * ", 'as_float(', 'as_float(')
            new_value = new_val + " + as_float(" + self.node.state.registers[self.vdst].val + ')'
            return make_new_value_for_reg(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix)
        else:
            return super().to_fill_node()
