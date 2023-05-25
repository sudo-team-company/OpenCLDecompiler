from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values


class VCmpGe(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            self.decompiler_data.write(self.sdst + " = (uint)" + self.src0 +
                                       " >= (uint)" + self.src1 + " // v_cmp_ge_u32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['u32', 'i32']:
            return compare_values(self.node, self.sdst, self.src0, self.src1, '(uint)', '(uint)', " >= ", self.suffix)
        return super().to_fill_node()
