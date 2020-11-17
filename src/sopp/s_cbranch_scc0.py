from src.sopp.s_cbranch import SCbranch


class SCbranchScc0(SCbranch):
    def to_print(self, node):
        output_string = node.state.registers["scc"].val
        return output_string
