from src.instructions.sopp.s_cbranch import SCbranch


class SCbranchVccz(SCbranch):
    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write(f"pc = vcc==0 ?{reladdr} : pc+4 // {self.name}\n")
        return self.node

    def to_print(self):
        self.output_string = self.node.state["vcc"].val
        return self.output_string
