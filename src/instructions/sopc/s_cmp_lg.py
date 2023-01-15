from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values


class SCmpLg(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.ssrc0 = self.instruction[1]
        self.ssrc1 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in ['i32', 'u32']:
            self.decompiler_data.write(f"scc = {self.ssrc0} != {self.ssrc1} // {self.instruction[0]}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['i32', 'u32']:
            return compare_values(self.node, "scc", self.ssrc0, self.ssrc1, "", "", " != ", self.suffix)
        return super().to_fill_node()
