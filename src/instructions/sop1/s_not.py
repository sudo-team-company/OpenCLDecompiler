from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value


class SNot(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in ["b32", "b64"]:
            self.decompiler_data.write(f"{self.sdst} = ~{self.ssrc0} // {self.name}\n")
            self.decompiler_data.write(f"scc = {self.sdst} != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ["b32", "b64"]:
            new_value = f"!({self.node.state[self.ssrc0].val})"
            data_type = self.suffix
            reg_type = self.node.state[self.ssrc0].type
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0], data_type, reg_type=reg_type)
        return super().to_fill_node()
