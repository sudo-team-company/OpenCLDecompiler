from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values, set_reg_value


class VCmpGt(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'u64':
            self.decompiler_data.write(self.sdst + " = (ulong)" + self.src0 + " > (uint)"
                                       + self.src1 + " // v_cmp_gt_u64\n")
            # почему uint???
            return self.node
        if self.suffix == 'i32':
            self.decompiler_data.write(self.sdst + " = (int)" + self.src0 + " > (int)"
                                       + self.src1 + " // v_cmp_gt_i32\n")
            return self.node
        if self.suffix == 'u32':
            self.decompiler_data.write(self.sdst + " = (uint)" + self.src0 + " > (uint)"
                                       + self.src1 + " // v_cmp_gt_u32\n")
            return self.node
        if self.suffix == 'f64':
            self.decompiler_data.write(self.sdst + " = (double)" + self.src0 + " > (double)"
                                       + self.src1 + " // v_cmp_gt_f64\n")
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.src0 in self.node.state.registers and self.src1 in self.node.state.registers and \
                self.node.state.registers[self.src0].type == self.node.state.registers[self.src1].type and \
                self.node.state.registers[self.src0].val == self.node.state.registers[self.src1].val:
            return set_reg_value(self.node, "0", self.sdst, [self.src0, self.src1], self.suffix)
        if self.suffix == 'u64':
            # TODO: Сделать честное присвоение
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(ulong)', '(uint)', " > ", self.suffix)
        if self.suffix == 'i32':
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(int)', '(int)', " > ", self.suffix)
        if self.suffix == 'u32':
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(uint)', '(uint)', " > ", self.suffix)
        if self.suffix == 'f64':
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(uint)', '(uint)', " > ", self.suffix)
        return super().to_fill_node()
