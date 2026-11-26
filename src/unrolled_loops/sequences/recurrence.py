from collections.abc import Iterator
from dataclasses import dataclass
from typing import Self

from src.unrolled_loops.sequences.base import IteratorSequence, c_div, fits_int32, register_sequence


@dataclass(frozen=True)
class MonotonicRecurrence(IteratorSequence):
    init: int
    last: int

    @property
    def increasing(self) -> bool:
        return self.last >= self.init

    def holds(self, value: int) -> bool:
        return value <= self.last if self.increasing else value >= self.last

    def condition(self, var: str) -> str:
        return f"{var} {'<=' if self.increasing else '>='} {self.last}"


def _plus(term: int) -> str:
    return f" - {-term}" if term < 0 else f" + {term}"


@register_sequence(priority=10)
@dataclass(frozen=True)
class ArithmeticSequence(MonotonicRecurrence):
    step: int

    @classmethod
    def counter(cls, length: int) -> Self:
        return cls(0, length - 1, 1)

    @classmethod
    def guess(cls, values: list[int]) -> Iterator[Self]:
        if len(values) >= 2:  # noqa: PLR2004
            yield cls(values[0], values[-1], values[1] - values[0])

    def next(self, value: int) -> int:
        return value + self.step

    def update(self, var: str) -> str:
        return f"{var} = {var}{_plus(self.step)}"


@register_sequence(priority=20)
@dataclass(frozen=True)
class GeometricSequence(MonotonicRecurrence):
    factor: int
    divide: bool = False

    @classmethod
    def guess(cls, values: list[int]) -> Iterator[Self]:
        if len(values) < 2 or values[0] == 0 or values[1] == 0:  # noqa: PLR2004
            return
        first, second = values[0], values[1]
        if abs(second) > abs(first):
            if second % first == 0:
                yield cls(first, values[-1], second // first)
        else:
            # Largest divisor that gives ``second``; smaller ones give a larger quotient.
            yield cls(first, values[-1], c_div(first, second), divide=True)

    def holds(self, value: int) -> bool:
        return abs(self.factor) >= 2 and super().holds(value)  # noqa: PLR2004

    def next(self, value: int) -> int:
        return c_div(value, self.factor) if self.divide else value * self.factor

    def update(self, var: str) -> str:
        return f"{var} = {var} {'/' if self.divide else '*'} {self.factor}"


@register_sequence(priority=30)
@dataclass(frozen=True)
class AffineSequence(MonotonicRecurrence):
    """``i = i * mul + add``: ``1, 3, 7, 15, ...`` for ``i = i * 2 + 1``.
    """

    mul: int
    add: int

    @classmethod
    def guess(cls, values: list[int]) -> Iterator[Self]:
        if len(values) < 3:  # noqa: PLR2004
            return
        a0, a1, a2 = values[:3]
        # a1 = mul * a0 + add, a2 = mul * a1 + add  =>  mul = (a2 - a1) / (a1 - a0)
        if a1 == a0 or (a2 - a1) % (a1 - a0) != 0:
            return
        mul = (a2 - a1) // (a1 - a0)
        add = a1 - mul * a0
        if mul not in {0, 1} and add != 0:
            yield cls(a0, values[-1], mul, add)

    def next(self, value: int) -> int:
        product = value * self.mul
        # An overflowing ``i * mul`` is returned as is, so that ``generates`` rejects the sequence.
        return product + self.add if fits_int32(product) else product

    def update(self, var: str) -> str:
        return f"{var} = {var} * {self.mul}{_plus(self.add)}"
