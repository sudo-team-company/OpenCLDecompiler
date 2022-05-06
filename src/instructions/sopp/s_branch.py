from src.base_instruction import BaseInstruction


class SBranch(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.reladdr = self.instruction[1]

    def to_print_unresolved(self):
        self.decompiler_data.write("pc = " + self.reladdr + " // s_branch\n")
        self.decompiler_data.write("goto " + self.reladdr + "\n")
        return self.node

    def to_fill_node(self):
        self.node = self.decompiler_data.to_fill_branch_node(self.node, self.instruction)
        self.node.instruction = "branch"
        return self.node
