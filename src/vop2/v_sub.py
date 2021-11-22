from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg
from src.register_type import RegisterType


def v_sub_fill_node(node, src0_reg, src1_reg, src0, src1, vdst, new_value, suffix):
    reg_type = RegisterType.INT32
    if src0_reg:
        reg_type = node.state.registers[src0].integrity
    elif src1_reg:
        reg_type = node.state.registers[src1].integrity
    return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix, reg_type=reg_type)


class VSub(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        if self.suffix == 'u32':
            self.vcc = self.instruction[2]
            self.src0 = self.instruction[3]
            self.src1 = self.instruction[4]
        else:
            self.src0 = self.instruction[2]
            self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            temp = "temp" + str(self.decompiler_data.number_of_temp)
            mask = "mask" + str(self.decompiler_data.number_of_mask)
            self.decompiler_data.write("ulong " + temp + " = (ulong)" + self.src0 +
                                       " - (ulong)" + self.src1 + " // v_sub_u32\n")
            self.decompiler_data.write(self.vdst + " = CLAMP ? (" + temp + ">>32 ? 0 : " + temp + ") : " + temp + "\n")
            self.decompiler_data.write(self.vcc + " = 0\n")  # vop2, sdst
            self.decompiler_data.write("ulong " + mask + " = (1ULL<<LANEID)\n")
            self.decompiler_data.write(self.vcc + " = (" + self.vcc + "&~" + mask + ") | (("
                                  + temp + ">>32) ? " + mask + " : 0)\n")
            self.decompiler_data.number_of_temp += 1
            self.decompiler_data.number_of_mask += 1
            return self.node
        elif self.suffix == 'f32':
            self.decompiler_data.write(self.vdst + " = as_float(" + self.src0 +
                                       ") - as_float(" + self.src1 + ") // v_sub_f32\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            new_val, src0_reg, src1_reg = make_op(self.node, self.src0, self.src1, " - ", '(ulong)', '')
            return v_sub_fill_node(self.node, src0_reg, src1_reg, self.src0, self.src1, self.vdst, new_val, self.suffix)
        elif self.suffix == 'f32':
            new_val, src0_reg, src1_reg = make_op(self.node, self.src0, self.src1, " - ", 'as_float(', 'as_float(')
            return v_sub_fill_node(self.node, src0_reg, src1_reg, self.src0, self.src1, self.vdst, new_val, self.suffix)
        else:
            return super().to_fill_node()
