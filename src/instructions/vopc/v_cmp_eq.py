from .v_cmp import VCmp


class VCmpEq(VCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '==')
