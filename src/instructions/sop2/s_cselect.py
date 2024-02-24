from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value


class SCselect(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b64':
            self.decompiler_data.write(self.sdst + " = scc ? " + self.ssrc0 + " : "
                                       + self.ssrc1 + " // s_cselect_b64\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['b32', 'b64']:
            ssrc0 = self.ssrc0
            if self.ssrc0 == "exec":
                ssrc0 = "1"
            new_value = self.node.state.registers["scc"].val + " ? " + ssrc0 + " : " + self.ssrc1
            return set_reg_value(self.node, new_value, self.sdst, [ssrc0, self.ssrc1], self.suffix)
        return super().to_fill_node()
