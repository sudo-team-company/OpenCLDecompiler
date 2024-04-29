from .s_cmp import SCmp


class SCmpGt(SCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '>')
