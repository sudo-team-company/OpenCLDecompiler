from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values


class SCmpGt(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.ssrc0 = self.instruction[1]
        self.ssrc1 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            self.decompiler_data.write("scc = (int)" + self.ssrc0 + " > (int)" + self.ssrc1 + " // s_cmp_gt_i32\n")
            return self.node
        if self.suffix == 'u32':
            self.decompiler_data.write("scc = " + self.ssrc0 + " > " + self.ssrc1 + " // s_cmp_gt_u32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'i32':
            return compare_values(self.node, "scc", self.ssrc0, self.ssrc1, "(int)", "(int)", " > ", self.suffix)
        if self.suffix == 'u32':
            return compare_values(self.node, "scc", self.ssrc0, self.ssrc1, "", "", " > ", self.suffix)
        return super().to_fill_node()
