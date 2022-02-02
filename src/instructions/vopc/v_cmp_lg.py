from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values


class VCmpLg(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            self.decompiler_data.write(self.sdst + " = (int)" + self.src0 +
                                       " != (int)" + self.src1 + " // v_cmp_lg_i32\n")
            return self.node
        if self.suffix == 'u32':
            self.decompiler_data.write(self.sdst + " = (uint)" + self.src0 +
                                       " != (uint)" + self.src1 + " // v_cmp_lg_u32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'i32':
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(int)', '(int)', " != ", self.suffix)
        return super().to_fill_node()
