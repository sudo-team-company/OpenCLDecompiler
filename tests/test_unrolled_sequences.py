from collections.abc import Iterator
from dataclasses import dataclass
from typing import Self

import pytest

from src.unrolled_loops.sequences import (
    AffineSequence,
    ArithmeticSequence,
    GeometricSequence,
    IteratorSequence,
    PolynomialSequence,
    detect_sequence,
    register_sequence,
    registered_sequences,
)
from src.unrolled_loops.sequences import base as sequences_base
from src.unrolled_loops.sequences.recurrence import MonotonicRecurrence


def run_printed(seq: IteratorSequence, limit: int = 1000) -> list[int]:
    """Run the printed loop header as Python code (``/`` as ``//``: test values are positive)."""

    def py(expr: str) -> str:
        return expr.replace("/", "//")

    values = []
    i = seq.init
    while eval(py(seq.condition("i"))):  # noqa: S307
        values.append(eval(py(seq.value("i"))))  # noqa: S307
        scope = {"i": i}
        exec(py(seq.update("i")), {}, scope)  # noqa: S102
        i = scope["i"]
        assert len(values) <= limit
    return values


@pytest.mark.parametrize(
    ("values", "kind", "header", "value"),
    [
        (list(range(7, 70, 3)), ArithmeticSequence, "i = 7; i <= 67; i = i + 3", "i"),
        (list(range(50, 10, -2)), ArithmeticSequence, "i = 50; i >= 12; i = i - 2", "i"),
        ([2**k for k in range(20)], GeometricSequence, "i = 1; i <= 524288; i = i * 2", "i"),
        ([5 * 3**k for k in range(10)], GeometricSequence, "i = 5; i <= 98415; i = i * 3", "i"),
        ([2**k for k in range(20, -1, -1)], GeometricSequence, "i = 1048576; i >= 1; i = i / 2", "i"),
        ([100, 33, 11, 3, 1], GeometricSequence, "i = 100; i >= 1; i = i / 3", "i"),
        ([2**k - 1 for k in range(1, 21)], AffineSequence, "i = 1; i <= 1048575; i = i * 2 + 1", "i"),
        ([3, 7, 19, 55, 163], AffineSequence, "i = 3; i <= 163; i = i * 3 - 2", "i"),
        ([k * k for k in range(20)], PolynomialSequence, "i = 0; i <= 19; i = i + 1", "(i * i)"),
        ([k * k for k in range(2, 20)], PolynomialSequence, "i = 2; i <= 19; i = i + 1", "(i * i)"),
        (
            [k * (k + 1) // 2 for k in range(1, 20)],
            PolynomialSequence,
            "i = 1; i <= 19; i = i + 1",
            "((i * i + i) / 2)",
        ),
        ([k**3 - 2 * k for k in range(18)], PolynomialSequence, "i = 0; i <= 17; i = i + 1", "(i * i * i - 2 * i)"),
        ([-(k * k) + 5 for k in range(10)], PolynomialSequence, "i = 0; i <= 9; i = i + 1", "(-i * i + 5)"),
    ],
)
def test_detect(values: list[int], kind: type[IteratorSequence], header: str, value: str):
    seq = detect_sequence(values)
    assert type(seq) is kind
    assert f"i = {seq.init}; {seq.condition('i')}; {seq.update('i')}" == header
    assert seq.value("i") == value
    assert run_printed(seq) == values


@pytest.mark.parametrize(
    "values",
    [
        pytest.param([1, 5, 2, 8, 3], id="random"),
        pytest.param([(-2) ** k for k in range(10)], id="alternating"),
        pytest.param([2**k for k in range(31)], id="next value overflows int"),
        pytest.param([3 * 2**k for k in range(30)], id="i * 2 overflows int"),
        pytest.param([k**4 for k in range(10)], id="polynomial degree too high"),
        pytest.param([1, 2], id="too short for anything but arithmetic"),
    ],
)
def test_reject(values: list[int]):
    seq = detect_sequence(values)
    if values == [1, 2]:
        assert type(seq) is ArithmeticSequence
        return
    assert seq is None


def test_counter():
    seq = ArithmeticSequence.counter(20)
    assert seq.generates(list(range(20)))
    assert run_printed(seq) == list(range(20))


def test_kinds_do_not_overlap():
    # Arithmetic and geometric sequences are special cases of affine and polynomial ones,
    # but they must be printed by their own kinds.
    assert AffineSequence.detect(list(range(0, 30, 3))) is None
    assert AffineSequence.detect([2**k for k in range(10)]) is None
    assert PolynomialSequence.detect(list(range(0, 30, 3))) is None


def test_priority_order():
    kinds = registered_sequences()
    assert kinds.index(ArithmeticSequence) < kinds.index(GeometricSequence)
    assert kinds.index(GeometricSequence) < kinds.index(AffineSequence)
    assert kinds.index(AffineSequence) < kinds.index(PolynomialSequence)


def test_register_new_kind(monkeypatch: pytest.MonkeyPatch):
    monkeypatch.setattr(sequences_base, "_registry", list(sequences_base._registry))  # noqa: SLF001

    values = [2, 4, 16, 256]  # one more value would make the next one, 65536 * 65536, overflow int
    assert detect_sequence(values) is None

    @register_sequence(priority=50)
    @dataclass(frozen=True)
    class SquareRecurrence(MonotonicRecurrence):
        @classmethod
        def guess(cls, values: list[int]) -> Iterator[Self]:
            yield cls(values[0], values[-1])

        def next(self, value: int) -> int:
            return value * value

        def update(self, var: str) -> str:
            return f"{var} = {var} * {var}"

    seq = detect_sequence(values)
    assert type(seq) is SquareRecurrence
    assert run_printed(seq) == values


def test_wrong_guess_is_rejected():
    # The arithmetic guess for 1, 2, 4, 8 is step 1; it must not be taken as the answer.
    values = [1, 2, 4, 8]
    assert list(ArithmeticSequence.guess(values)) == [ArithmeticSequence(1, 8, 1)]
    assert ArithmeticSequence.detect(values) is None
    assert type(detect_sequence(values)) is GeometricSequence


def test_polynomial_skips_overflowing_candidate():
    # The simplest form, -i * i + B * i for i = 4 .. 13, overflows int in B * 13,
    # although every value fits; a counter starting at 3 gives a form that does not overflow.
    big = 165191050  # big * 13 > INT_MAX >= big * 13 - 13 * 13
    values = [-x * x + big * x for x in range(4, 14)]

    simplest = next(PolynomialSequence.guess(values))
    assert simplest.value("i") == f"(-i * i + {big} * i)"
    assert not simplest.generates(values)

    seq = PolynomialSequence.detect(values)
    assert seq is not None
    assert (seq.init, seq.last) == (3, 12)
    assert run_printed(seq) == values
