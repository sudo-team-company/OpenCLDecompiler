from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values
from src.register import check_and_split_regs


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
        if self.suffix == 'u64':
            # TODO: Сделать честное присвоение
            start_src0, _ = check_and_split_regs(self.src0)
            start_src1, _ = check_and_split_regs(self.src1)
            return compare_values(self.node, self.sdst, start_src0, start_src1, '(ulong)', '(uint)', " > ", self.suffix)
        if self.suffix == 'i32':
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(int)', '(int)', " > ", self.suffix)
        if self.suffix == 'u32':
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(uint)', '(uint)', " > ", self.suffix)
        if self.suffix == 'f64':
            start_src0, _ = check_and_split_regs(self.src0)
            start_src1, _ = check_and_split_regs(self.src1)
            return compare_values(self.node, self.sdst, start_src0, start_src1, '(uint)', '(uint)', " > ", self.suffix)
        return super().to_fill_node()
