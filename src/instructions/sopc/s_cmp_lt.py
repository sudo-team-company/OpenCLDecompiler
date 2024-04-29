from .s_cmp import SCmp


class SCmpLt(SCmp):
    def __init__(self, node, suffix):
        super().__init__(node, suffix, '<')
