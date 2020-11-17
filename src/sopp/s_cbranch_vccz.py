from src.sopp.s_cbranch import SCbranch


class SCbranchVccz(SCbranch):
    def to_print(self, node):
        output_string = node.state.registers["vcc"].val
        return output_string
