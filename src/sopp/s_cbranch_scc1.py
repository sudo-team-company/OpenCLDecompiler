from src.sopp.s_cbranch import SCbranch


class SCbranchScc1(SCbranch):
    def to_print(self, node):
        output_string = node.state.registers["scc"].val
        return output_string
        # decompiler_data.write("pc = scc1 == 0 ? " + reladdr + " : pc + 4\n")
