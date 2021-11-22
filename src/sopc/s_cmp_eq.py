from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values


class SCmpEq(BaseInstruction):
    # think about types and separate
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.ssrc0 = self.instruction[1] if suffix != 'u64' \
            else self.instruction[1][0] + self.instruction[1][2: self.instruction[1].find(':')]
        self.ssrc1 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in ['i32', 'u32', 'u64']:
            self.decompiler_data.write("scc = " + self.ssrc0 + "==" + self.ssrc1 + " // s_cmp_eq_" + self.suffix + "\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['i32', 'u32', 'u64']:
            return compare_values(self.node, "scc", self.ssrc0, self.ssrc1, "", "", " == ", self.suffix)
        else:
            return super().to_fill_node()
