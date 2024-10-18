from src.decompiler_data import set_reg_value
from .v_cmp import VCmp


class VCmpGt(VCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '>')

    def to_fill_node(self):
        if self.s0 in self.node.state and self.s1 in self.node.state and \
                self.node.state[self.s0].type == self.node.state[self.s1].type and \
                self.node.state[self.s0].val == self.node.state[self.s1].val:
            return set_reg_value(self.node, '0', self.d0, [self.s0, self.s1], self.suffix)
        return super().to_fill_node()
