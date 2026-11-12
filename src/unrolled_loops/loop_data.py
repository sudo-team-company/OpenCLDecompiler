from dataclasses import dataclass

from src.unrolled_loops.sequences import IteratorSequence

LOOP_VARIABLE = "i"
ACCUMULATOR = "acc"


@dataclass(frozen=True)
class UnrolledLoopData:
    acc_init: str
    iterator: IteratorSequence
    body: str

    def to_lines(self) -> list[str]:
        it = self.iterator
        var = LOOP_VARIABLE
        return [
            f"int {ACCUMULATOR} = {self.acc_init};",
            f"for (int {var} = {it.init}; {it.condition(var)}; {it.update(var)}) {{",
            f"    {ACCUMULATOR} = {self.body};",
            "}",
        ]
