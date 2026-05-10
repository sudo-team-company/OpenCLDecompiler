import copy
from collections.abc import Sequence
from typing import Any

from src.node import Node



class NodeLoweringContext:
    def __init__(self, state: Any, parents: list[Node]):
        self.state = state
        self.parents = list(parents)

    def emit_backend(
        self,
        backend_cls: type,
        opcode: str,
        operands: Sequence[Any],
        suffix: str = ""
    ) -> Node:
        node = Node(
            opcode,
            list(operands),
            copy.deepcopy(self.state),
        )
        self._attach(node, self.parents)
        last_node = backend_cls(node, suffix).to_fill_node()
        return self._advance(last_node)

    @staticmethod
    def _attach(node: Node, parents: list[Node]) -> None:
        for parent in parents:
            node.parent.append(parent)
            parent.add_child(node)

    def _advance(self, last_node: Node) -> Node:
        self.state = last_node.state
        self.parents = [last_node]
        return last_node
