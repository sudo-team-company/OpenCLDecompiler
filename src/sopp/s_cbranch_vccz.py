from src.sopp.s_cbranch import SCbranch
from src.decompiler_data import DecompilerData


class SCbranchVccz(SCbranch):
    def to_print_unresolved(self, node, instruction):
        decompiler_data = DecompilerData()
        reladdr = instruction[1]
        decompiler_data.write("pc = vcc==0 ?" + reladdr + " : pc+4 // s_cbranch_vccz\n")
        return node

    def to_print(self, node):
        output_string = node.state.registers["vcc"].val
        return output_string
