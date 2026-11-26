from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

from src.ir.registers.reg import BaseReg, expand_register_names

if TYPE_CHECKING:
    from collections.abc import Iterable

    from src.ir.instructions.generic import GenericInstruction


def _register_names(operands: Iterable[object]) -> frozenset[str]:
    names: set[str] = set()
    for operand in operands:
        if isinstance(operand, BaseReg):
            names.update(expand_register_names(operand))
    return frozenset(names)


@dataclass(frozen=True)
class NodeEffects:
    reads: frozenset[str] = frozenset()
    writes: frozenset[str] = frozenset()
    has_side_effects: bool = False
    is_control_flow: bool = False

    @classmethod
    def from_instruction(cls, instruction: GenericInstruction) -> NodeEffects:
        return cls(
            reads=frozenset(instruction.get_read_register_names()),
            writes=frozenset(instruction.get_written_register_names()),
            has_side_effects=instruction.has_side_effects(),
            is_control_flow=instruction.is_control_flow(),
        )

    @classmethod
    def from_operands(
        cls,
        operands: Iterable[object],
        *,
        writes_first_operand: bool = True,
        has_side_effects: bool = False,
        is_control_flow: bool = False,
    ) -> NodeEffects:
        operands = list(operands)
        if writes_first_operand and operands:
            written, read = operands[:1], operands[1:]
        else:
            written, read = [], operands
        return cls(
            reads=_register_names(read),
            writes=_register_names(written),
            has_side_effects=has_side_effects,
            is_control_flow=is_control_flow,
        )
