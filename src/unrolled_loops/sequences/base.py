from abc import ABC, abstractmethod
from collections.abc import Callable, Iterator
from typing import Self

INT32_MIN = -(2**31)
INT32_MAX = 2**31 - 1
UINT32_MAX = 2**32 - 1


def fits_int32(value: int) -> bool:
    return INT32_MIN <= value <= INT32_MAX


def to_int32(value: int) -> int | None:
    if fits_int32(value):
        return value
    if INT32_MAX < value <= UINT32_MAX:
        return value - 2**32
    return None


def c_div(a: int, b: int) -> int:
    q = abs(a) // abs(b)
    return q if (a >= 0) == (b > 0) else -q


class IteratorSequence(ABC):
    init: int

    @classmethod
    @abstractmethod
    def guess(cls, values: list[int]) -> Iterator[Self]:
        """Yield candidate parameters of this kind for ``values``, the most preferred first."""

    @classmethod
    def detect(cls, values: list[int]) -> Self | None:
        return next((seq for seq in cls.guess(values) if seq.generates(values)), None)

    @abstractmethod
    def holds(self, value: int) -> bool:
        """Python semantics of ``condition``."""

    @abstractmethod
    def next(self, value: int) -> int:
        """Python semantics of ``update``, with C integer arithmetic."""

    @abstractmethod
    def condition(self, var: str) -> str:
        """OpenCL loop condition, e.g. ``i <= 121``."""

    @abstractmethod
    def update(self, var: str) -> str:
        """OpenCL loop update, e.g. ``i = i + 3``."""

    def value_at(self, value: int) -> int | None:
        """Constant of the loop body for a header value; ``None`` if it cannot be computed in ``int``."""
        return value

    def value(self, var: str) -> str:
        """Python semantics of ``condition``."""
        return var

    def generates(self, values: list[int]) -> bool:
        """Check that the loop runs exactly ``len(values)`` times and produces ``values``.

        Every header value, including the one that stops the loop, must fit into ``int``:
        signed overflow in the update would be undefined behaviour.
        """
        current = self.init
        produced: list[int] = []
        while fits_int32(current) and self.holds(current):
            if len(produced) == len(values):
                return False
            value = self.value_at(current)
            if value is None or value != values[len(produced)]:
                return False
            produced.append(value)
            current = self.next(current)
        return fits_int32(current) and len(produced) == len(values)


_registry: list[tuple[int, type[IteratorSequence]]] = []


def register_sequence(priority: int) -> Callable[[type[IteratorSequence]], type[IteratorSequence]]:
    def decorator(cls: type[IteratorSequence]) -> type[IteratorSequence]:
        _registry.append((priority, cls))
        _registry.sort(key=lambda item: item[0])
        return cls

    return decorator


def registered_sequences() -> list[type[IteratorSequence]]:
    return [cls for _, cls in _registry]


def detect_sequence(values: list[int]) -> IteratorSequence | None:
    for cls in registered_sequences():
        sequence = cls.detect(values)
        if sequence is not None:
            return sequence
    return None
