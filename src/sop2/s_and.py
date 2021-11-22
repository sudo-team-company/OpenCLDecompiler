from src.base_instruction import BaseInstruction


class SAnd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix in ['b32', 'b64']:
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " & " +
                                       self.ssrc1 + " // s_and_" + self.suffix + "\n")
            self.decompiler_data.write("scc" + " = " + self.sdst + " != 0\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['b32', 'b64']:
            # не требуется ли здесь создание?
            self.node.state.registers[self.sdst] = self.node.state.registers[self.ssrc0]
            return self.node
        else:
            return super().to_fill_node()
