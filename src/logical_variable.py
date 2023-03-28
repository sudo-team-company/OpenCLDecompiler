class ExecCondition:
    def __init__(self, and_chain):
        self.and_chain = and_chain

    def top(self) -> str:
        return self.and_chain[0]

    def push(self, other: str) -> None:
        self.and_chain.append(other)

    def pop(self) -> str:
        return self.and_chain.pop()

    def deny_top(self) -> None:
        self.push(self.make_not(self.pop()))

    @staticmethod
    def make_not(cond: str) -> str:
        return "!(" + cond + ")"
