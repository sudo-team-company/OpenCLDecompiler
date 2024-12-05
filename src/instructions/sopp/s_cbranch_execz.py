from src.instructions.sopp.s_cbranch import SCbranch


class SCbranchExecz(SCbranch):
    def to_fill_node(self):
        return self.node

    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write(f"pc = exec==0 ?{reladdr} : pc+4 // {self.name}\n")
        return self.node
