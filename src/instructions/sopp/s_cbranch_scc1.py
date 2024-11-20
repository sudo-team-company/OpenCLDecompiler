from src.instructions.sopp.s_cbranch import SCbranch


class SCbranchScc1(SCbranch):
    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write(f"pc = scc==1 ?{reladdr} : pc+4 // {self.name}\n")
        return self.node

    def to_print(self):
        self.output_string = self.node.state["scc"].val
        return self.output_string
