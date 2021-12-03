from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value


class VMulF32(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'f32':
            self.decompiler_data.write(self.vdst + " = as_float(" + self.src0 +
                                       ") * as_float(" + self.src1 + ") // v_mul_f32\n")
            return self.node
        if self.suffix == 'i32_i24':
            v0 = "V0" + str(self.decompiler_data.number_of_v0)
            v1 = "V1" + str(self.decompiler_data.number_of_v1)
            self.decompiler_data.write("int " + v0 + " (int)((" + self.src0 + "&0x7fffff) | ("
                                       + self.src0 + "&0x800000 ? 0xff800000 : 0)) // v_mul_i32_i24\n")
            self.decompiler_data.write("int " + v1 + " (int)((" + self.src1 + "&0x7fffff) | ("
                                       + self.src1 + "&0x800000 ? 0xff800000 : 0))\n")
            self.decompiler_data.write(self.vdst + " = " + v0 + " * " + v1 + "\n")
            self.decompiler_data.number_of_v0 += 1
            self.decompiler_data.number_of_v1 += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'f32':
            reg_entire = self.node.state.registers[self.src1].integrity
            new_value, _, _ = make_op(self.node, self.src0, self.src1, " * ", 'as_float(', 'as_float(')
            return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix,
                                 reg_entire=reg_entire)
        if self.suffix == 'i32_i24':
            reg_entire = self.node.state.registers[self.src1].integrity
            new_value, _, _ = make_op(self.node, self.src0, self.src1, " * ", '(int)', '(int)')
            return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix,
                                 reg_entire=reg_entire)
        return super().to_fill_node()
