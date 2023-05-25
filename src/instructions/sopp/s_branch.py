from src.instructions.sopp.s_cbranch import SCbranch


class SBranch(SCbranch):
    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write("pc = " + reladdr + " // s_branch\n")
        self.decompiler_data.write("goto " + reladdr + "\n")
        return self.node
