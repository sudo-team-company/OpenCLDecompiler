from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values


class SCmpkLg(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.src0: str = self.instruction[1]
        self.simm16: str = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            self.decompiler_data.write(f"scc = (uint){self.src0} != (uint){self.simm16} // s_cmpk_lg_u32\n")
            return self.node
        if self.suffix == 'i32':
            self.decompiler_data.write(f"scc = (int){self.src0} != (int){self.simm16} // s_cmpk_lg_i32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            return compare_values(self.node, "scc", self.src0, self.simm16, '(uint)', '(uint)', " != ", self.suffix)
        if self.suffix == 'i32':
            return compare_values(self.node, "scc", self.src0, self.simm16, '(int)', '(int)', " != ", self.suffix)
        return super().to_fill_node()
