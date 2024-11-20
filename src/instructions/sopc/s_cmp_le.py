from .s_cmp import SCmp
from ...node import Node


class SCmpLe(SCmp):
    def __init__(self, node: Node, suffix: str):
        super().__init__(node, suffix, "<=")
