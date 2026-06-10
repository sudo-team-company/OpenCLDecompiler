from __future__ import annotations

from dataclasses import dataclass, field
from typing import TYPE_CHECKING, Protocol

if TYPE_CHECKING:
    from collections.abc import Iterable


@dataclass
class PassContext:
    metadata: dict[str, object] = field(default_factory=dict)


class PipelinePass(Protocol):
    def run(self, ir_unit: object, context: PassContext) -> None: ...


class InvalidPipelinePassError(TypeError):
    def __init__(self, pipeline_name: str, pipeline_pass: object):
        super().__init__(
            f"Pipeline '{pipeline_name}' contains invalid pass {pipeline_pass!r}. "
            f"All passes must implement the 'run' method."
        )


class PassPipeline:
    def __init__(self, name: str, passes: Iterable[PipelinePass]):
        self.name = name
        self._passes = tuple(passes)

    @classmethod
    def anonymous(cls, passes: Iterable[PipelinePass]) -> PassPipeline:
        return cls("anonymous-pipeline", passes)

    @classmethod
    def named(cls, name: str, passes: Iterable[PipelinePass]) -> PassPipeline:
        return cls(name, passes)

    @property
    def passes(self) -> tuple[PipelinePass, ...]:
        return self._passes

    def run(self, ir_unit: object, context: PassContext | None = None) -> PassContext:
        if context is None:
            context = PassContext()

        for pipeline_pass in self._passes:
            run = getattr(pipeline_pass, "run", None)
            if not callable(run):
                raise InvalidPipelinePassError(self.name, pipeline_pass)
            run(ir_unit, context)

        return context
