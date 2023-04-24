class ExecCondition:
    DEFAULT = "0xffffffffffffffff"

    def __init__(self, and_chain):
        self.and_chain = and_chain

    def top(self) -> str:
        return self.and_chain[-1]

    def __and__(self, cond: str) -> 'ExecCondition':
        new_and_chain = self.and_chain[::]
        new_and_chain.append(cond)
        return ExecCondition(new_and_chain)

    def __or__(self, other: 'ExecCondition') -> 'ExecCondition':
        new_and_chain = []
        i = 0
        while i < len(other.and_chain) and self.and_chain[i] == other.and_chain[i]:
            new_and_chain.append(self.and_chain[i])
            i += 1
        return ExecCondition(new_and_chain)

    def __xor__(self, other: 'ExecCondition') -> 'ExecCondition':
        assert other.and_chain == self.and_chain[:-1]
        assert len(other.and_chain) == len(self.and_chain) - 1
        new_and_chain = self.and_chain[:-1:] + [self.make_not(self.top())]
        return ExecCondition(new_and_chain)

    @staticmethod
    def default():
        return ExecCondition([ExecCondition.DEFAULT])

    @staticmethod
    def make_not(cond: str) -> str:
        return "!(" + cond + ")"

    @staticmethod
    def is_closing_for(end_exec_condition: 'ExecCondition', pre_exec_condition: 'ExecCondition') -> bool:
        return len(pre_exec_condition.and_chain) >= len(end_exec_condition.and_chain) \
            and pre_exec_condition.and_chain[:len(end_exec_condition.and_chain)] == end_exec_condition.and_chain
