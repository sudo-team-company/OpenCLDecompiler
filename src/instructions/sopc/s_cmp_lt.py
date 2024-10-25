from .s_cmp import SCmp
from ...node import Node


class SCmpLt(SCmp):
    def __init__(self, node: Node, suffix: str):
        super().__init__(node, suffix, '<')
