"""Loop body values as a function of simple loop counter, v = f(i).

Used when next iter value cannot be expressed via current one.
Polynomials are interpolated via Newton forward form, and the simplest one is chosen.
"""

import itertools
import math
from collections.abc import Iterator
from dataclasses import dataclass
from fractions import Fraction
from typing import Self

from src.unrolled_loops.sequences.base import IteratorSequence, fits_int32, register_sequence

MIN_DEGREE = 2
MAX_DEGREE = 3 # consider not to complex polynomials
MAX_START = 4  # the counter may start later than 0 to get a simpler polynomial: (k + 2)^2 -> i * i


def polynomial_degree(values: list[int]) -> int | None:
    row = values
    for degree in range(MAX_DEGREE + 1):
        if len(row) < 2:  # noqa: PLR2004
            return None
        if all(v == row[0] for v in row):
            return degree
        row = [b - a for a, b in itertools.pairwise(row)]
    return None


def _mul_linear(poly: list[Fraction], root: int) -> list[Fraction]:
    result = [Fraction(0)] * (len(poly) + 1)
    for power, coef in enumerate(poly):
        result[power + 1] += coef
        result[power] -= coef * root
    return result


def interpolate(values: list[int], start: int, degree: int) -> list[Fraction]:
    coefs = [Fraction(0)] * (degree + 1)
    row = values
    binomial = [Fraction(1)]
    for j in range(degree + 1):
        for power, coef in enumerate(binomial):
            coefs[power] += row[0] * coef
        binomial = [c / (j + 1) for c in _mul_linear(binomial, start + j)]
        row = [b - a for a, b in itertools.pairwise(row)]
    return coefs


def _monomial(coef: int, power: int, var: str) -> str:
    if power == 0:
        return str(abs(coef))
    product = " * ".join([var] * power)
    return product if abs(coef) == 1 else f"{abs(coef)} * {product}"


@register_sequence(priority=100)
@dataclass(frozen=True)
class PolynomialSequence(IteratorSequence):
    init: int
    last: int
    coefs: tuple[int, ...]
    denominator: int = 1

    @classmethod
    def guess(cls, values: list[int]) -> Iterator[Self]:
        degree = polynomial_degree(values)
        if degree is None or degree < MIN_DEGREE:
            return
        candidates = [
            cls.from_fractions(values, start, interpolate(values, start, degree)) for start in range(MAX_START + 1)
        ]
        yield from sorted(candidates, key=lambda seq: seq.complexity)

    @classmethod
    def from_fractions(cls, values: list[int], start: int, coefs: list[Fraction]) -> Self:
        denominator = math.lcm(*(c.denominator for c in coefs))
        numerators = tuple(int(c * denominator) for c in coefs)
        return cls(start, start + len(values) - 1, numerators, denominator)

    @property
    def complexity(self) -> tuple[int, int, int, int]:
        nonzero = sum(1 for c in self.coefs if c != 0)
        return nonzero, self.denominator, sum(abs(c) for c in self.coefs), self.init

    def holds(self, value: int) -> bool:
        return value <= self.last

    def next(self, value: int) -> int:
        return value + 1

    def condition(self, var: str) -> str:
        return f"{var} <= {self.last}"

    def update(self, var: str) -> str:
        return f"{var} = {var} + 1"

    def _terms(self) -> list[tuple[int, int]]:
        return [(c, p) for p, c in reversed(list(enumerate(self.coefs))) if c != 0]

    def value_at(self, value: int) -> int | None:
        total = 0
        for coef, power in self._terms():
            term = coef
            for _ in range(power):
                term *= value
                if not fits_int32(term):
                    return None
            total += term
            if not fits_int32(total):
                return None
        if total % self.denominator != 0:
            return None
        return total // self.denominator

    def value(self, var: str) -> str:
        expr = ""
        for coef, power in self._terms():
            monomial = _monomial(coef, power, var)
            if not expr:
                expr = f"-{monomial}" if coef < 0 else monomial
            else:
                expr += f" - {monomial}" if coef < 0 else f" + {monomial}"
        if self.denominator != 1:
            expr = f"({expr}) / {self.denominator}"
        return f"({expr})"
