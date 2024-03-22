from src.instructions.sopp.s_cbranch import SCbranch


class SCbranchVccnz(SCbranch):
    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write("pc = vcc!=0 ?" + reladdr + " : pc+4 // s_cbranch_vccnz\n")
        return self.node

    def to_print(self):
        self.output_string = self.node.state.registers["vcc"].val
        return self.output_string
