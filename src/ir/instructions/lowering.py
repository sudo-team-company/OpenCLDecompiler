from __future__ import annotations

import copy
from typing import TYPE_CHECKING, Any

from src.node import Node
from src.node_effects import NodeEffects

if TYPE_CHECKING:
    from collections.abc import Sequence

    from src.ir.instructions.generic import GenericInstruction


class NodeLoweringContext:
    def __init__(self, state: Any, parents: list[Node], instruction: GenericInstruction | None = None):
        self.state = state
        self.parents = list(parents)
        self.instruction = instruction
        self._emitted: list[tuple[Node, NodeEffects | None]] = []

    def emit_backend(
        self,
        backend_cls: type,
        opcode: str,
        operands: Sequence[Any],
        suffix: str = "",
        *,
        effects: NodeEffects | None = None,
    ) -> Node:
        node = Node(
            opcode,
            list(operands),
            copy.deepcopy(self.state),
        )
        self._emitted.append((node, effects))
        self._assign_effects()
        self._attach(node, self.parents)
        last_node = backend_cls(node, suffix).to_fill_node()
        return self._advance(last_node)

    def _assign_effects(self) -> None:
        # Recomputed on every emit: until the second emit we do not know that the instruction is split.
        if len(self._emitted) == 1:
            node, explicit = self._emitted[0]
            if explicit is not None:
                node.effects = explicit
            elif self.instruction is not None:
                node.effects = NodeEffects.from_instruction(self.instruction)
            else:
                node.effects = NodeEffects.from_operands(node.operands)
            return

        for node, explicit in self._emitted:
            node.effects = explicit if explicit is not None else NodeEffects.from_operands(node.operands)

    @staticmethod
    def _attach(node: Node, parents: list[Node]) -> None:
        for parent in parents:
            node.parent.append(parent)
            parent.add_child(node)

    def _advance(self, last_node: Node) -> Node:
        self.state = last_node.state
        self.parents = [last_node]
        return last_node
