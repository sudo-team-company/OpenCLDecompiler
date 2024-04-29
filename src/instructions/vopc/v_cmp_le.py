from src.decompiler_data import set_reg_value
from src.register_type import RegisterType
from .v_cmp import VCmp


class VCmpLe(VCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '<=')

    def to_fill_node(self):
        if self.src1 in self.node.state.registers and \
                self.node.state.registers[self.src1].type == RegisterType.DIVISION_PASS:
            return set_reg_value(self.node, "", self.sdst, [self.src0, self.src1], self.suffix,
                                 reg_type=RegisterType.DIVISION_PASS)
        return super().to_fill_node()
