from .v_cmp import VCmp


class VCmpNe(VCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '!=')
