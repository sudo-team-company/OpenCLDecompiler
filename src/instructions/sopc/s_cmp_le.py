from ...node import Node
from .s_cmp import SCmp


class SCmpLe(SCmp):
    def __init__(self, node: Node, suffix: str):
        super().__init__(node, suffix, "<=")
