from src.decompiler_data import DecompilerData
from src.sopp.s_cbranch import SCbranch


class SCbranchScc0(SCbranch):
    def to_print_unresolved(self, node, instruction):
        decompiler_data = DecompilerData()
        reladdr = instruction[1]
        decompiler_data.write("pc = scc==0 ?" + reladdr + " : pc+4 // s_cbranch_scc0\n")
        return node

    def to_print(self, node):
        output_string = node.state.registers["scc"].val
        return output_string
