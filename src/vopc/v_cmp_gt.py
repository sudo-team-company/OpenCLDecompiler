from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values
from src.upload import find_first_last_num_to_from


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
        elif self.suffix == 'i32':
            self.decompiler_data.write(self.sdst + " = (int)" + self.src0 + " > (int)"
                                       + self.src1 + " // v_cmp_gt_i32\n")
            return self.node
        elif self.suffix == 'u32':
            self.decompiler_data.write(self.sdst + " = (uint)" + self.src0 + " > (uint)"
                                       + self.src1 + " // v_cmp_gt_u32\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u64':
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(self.src0, self.src1)
            self.src0 = name_of_to + str(first_to)
            self.src1 = name_of_from + str(first_from)
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(ulong)', '(uint)', " > ", self.suffix)
        elif self.suffix == 'i32':
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(int)', '(int)', " > ", self.suffix)
        elif self.suffix == 'u32':
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(uint)', '(uint)', " > ", self.suffix)
        else:
            return super().to_fill_node()
