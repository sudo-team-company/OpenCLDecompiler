from __future__ import annotations

from dataclasses import dataclass, field
from typing import TYPE_CHECKING

from src.ir.passes.base import PassContext

if TYPE_CHECKING:
    from src.ir.kernel import Kernel


@dataclass(frozen=True)
class RegisterFlowEdge:
    register_name: str
    writer_index: int
    reader_index: int


@dataclass
class RegisterFlowGraph:
    edges: list[RegisterFlowEdge] = field(default_factory=list)
    writer_by_use: dict[tuple[int, str], int] = field(default_factory=dict)
    uses_by_writer: dict[int, list[RegisterFlowEdge]] = field(default_factory=dict)

    def get_writer(self, reader_index: int, register_name: str) -> int | None:
        return self.writer_by_use.get((reader_index, register_name))


class BuildRegisterFlowPass:
    name = "build-register-flow"

    def run(self, kernel, context: PassContext) -> None:
        graph = self._build(kernel)
        context.metadata["register_flow"] = graph

    def _build(self, kernel: Kernel) -> RegisterFlowGraph:
        graph = RegisterFlowGraph()
        last_writer: dict[str, int] = {}

        for index, instruction in enumerate(kernel.instructions.get()):
            read_registers = instruction.get_read_register_names()
            written_registers = instruction.get_written_register_names()

            for register_name in read_registers:
                writer_index = last_writer.get(register_name)
                if writer_index is None:
                    continue

                edge = RegisterFlowEdge(
                    register_name=register_name,
                    writer_index=writer_index,
                    reader_index=index,
                )
                graph.edges.append(edge)
                graph.writer_by_use[(index, register_name)] = writer_index
                graph.uses_by_writer.setdefault(writer_index, []).append(edge)

            for register_name in written_registers:
                last_writer[register_name] = index
        return graph
