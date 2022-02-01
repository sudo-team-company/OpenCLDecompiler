from instructions.sopp.s_cbranch import SCbranch


class SCbranchScc0(SCbranch):
    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write("pc = scc==0 ?" + reladdr + " : pc+4 // s_cbranch_scc0\n")
        return self.node

    def to_print(self):
        self.output_string = self.node.state.registers["scc"].val
        return self.output_string
