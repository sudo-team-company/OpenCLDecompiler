class ExecCondition:
    DEFAULT = ""

    def __init__(self, and_chain):
        self.and_chain = and_chain

    def top(self) -> str:
        return self.and_chain[-1]

    def __and__(self, cond: str) -> "ExecCondition":
        new_and_chain = self.and_chain[::]
        new_and_chain.append(cond)
        return ExecCondition(new_and_chain)

    def __or__(self, other: "ExecCondition") -> "ExecCondition":
        if len(self.and_chain) == len(other.and_chain):
            assert self.and_chain[:-1] == other.and_chain[:-1]
            assert self.and_chain[-1] == self.make_not(other.and_chain[-1])
            return ExecCondition(self.and_chain[:-1:])
        assert len(self.and_chain) > len(other.and_chain)
        assert self.and_chain[: len(other.and_chain)] == other.and_chain
        return ExecCondition(other.and_chain[::])

    def __xor__(self, other: "ExecCondition") -> "ExecCondition":
        if len(other.and_chain) < len(self.and_chain):
            return self.xor(other)
        return other.xor(self)

    def xor(self, other: "ExecCondition") -> "ExecCondition":
        assert other.and_chain == self.and_chain[:-1]
        assert len(other.and_chain) == len(self.and_chain) - 1
        new_and_chain = self.and_chain[:-1:] + [self.make_not(self.top())]
        return ExecCondition(new_and_chain)

    @staticmethod
    def make_not(cond: str) -> str:
        if len(cond) >= 3 and cond[:2] == "!(" and cond[-1] == ")":  # noqa: PLR2004
            return cond[2:-1:]
        return "!(" + cond + ")"

    def __str__(self):
        return " && ".join("(" + x + ")" for x in self.and_chain)

    @staticmethod
    def default() -> "ExecCondition":
        return ExecCondition([ExecCondition.DEFAULT])

    @staticmethod
    def is_closing_for(end_exec_condition: "ExecCondition", if_exec_condition: "ExecCondition") -> bool:
        end_len = len(end_exec_condition.and_chain)
        return (
            len(if_exec_condition.and_chain) > end_len
            and if_exec_condition.and_chain[:end_len] == end_exec_condition.and_chain
        )
