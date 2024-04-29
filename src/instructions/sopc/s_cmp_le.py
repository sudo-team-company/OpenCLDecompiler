from .s_cmp import SCmp


class SCmpLe(SCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '<=')
