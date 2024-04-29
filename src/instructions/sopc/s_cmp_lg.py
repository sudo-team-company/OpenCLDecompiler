from .s_cmp import SCmp


class SCmpLg(SCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '!=')
