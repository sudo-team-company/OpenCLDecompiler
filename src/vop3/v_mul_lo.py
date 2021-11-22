from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg


class VMulLo(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            self.decompiler_data.write(self.vdst + " = " + self.src0 + " * " + self.src1 + " // v_mul_lo_u32\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            reg_entire = self.node.state.registers[self.src0].integrity
            new_value, src0_reg, src1_reg = make_op(self.node, self.src0, self.src1, " * ")
            return make_new_value_for_reg(self.node, new_value, self.vdst, [self.src0, self.src1],
                                          self.suffix, reg_entire=reg_entire)
        else:
            return super().to_fill_node()
