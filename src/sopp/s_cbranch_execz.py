from src.sopp.s_cbranch import SCbranch


class SCbranchExecz(SCbranch):
    def to_print(self, node):
        output_string = node.state.registers["exec"].val
        return output_string
