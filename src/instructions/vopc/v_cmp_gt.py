from src.decompiler_data import set_reg_value
from .v_cmp import VCmp


class VCmpGt(VCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '>')

    def to_fill_node(self):
        if self.src0 in self.node.state.registers and self.src1 in self.node.state.registers and \
                self.node.state.registers[self.src0].type == self.node.state.registers[self.src1].type and \
                self.node.state.registers[self.src0].val == self.node.state.registers[self.src1].val:
            return set_reg_value(self.node, '0', self.sdst, [self.src0, self.src1], self.suffix)
        return super().to_fill_node()
