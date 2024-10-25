from .v_cmp import VCmp


class VCmpLt(VCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '<')
