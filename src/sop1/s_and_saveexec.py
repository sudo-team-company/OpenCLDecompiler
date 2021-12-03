from src.base_instruction import BaseInstruction


class SAndSaveexec(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == "b64":
            self.decompiler_data.write(self.sdst + " = " + "exec // s_and_saveexec_b64\n")
            self.decompiler_data.write("exec = " + self.ssrc0 + " & exec\n")
            self.decompiler_data.write("scc = exec != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'b64':
            self.node.state.registers[self.sdst] = self.node.state.registers["exec"]
            self.node.state.registers["exec"] = self.node.state.registers[self.ssrc0]
            return self.node
        return super().to_fill_node()
