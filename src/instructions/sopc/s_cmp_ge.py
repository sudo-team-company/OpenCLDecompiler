from ...node import Node
from .s_cmp import SCmp


class SCmpGe(SCmp):
    def __init__(self, node: Node, suffix: str):
        super().__init__(node, suffix, ">=")
