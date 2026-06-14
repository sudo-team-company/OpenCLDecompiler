class ExecCondition:
    DEFAULT = ""

    def __init__(self, and_chain):
        self.and_chain = self._normalize_and_chain(and_chain)

    def top(self) -> str:
        return self.and_chain[-1]

    def __and__(self, cond: str) -> "ExecCondition":
        new_and_chain = self.and_chain[::]
        new_and_chain.append(cond)
        return ExecCondition(new_and_chain)

    def __or__(self, other: "ExecCondition") -> "ExecCondition":
        sibling_parent = self.negated_sibling_parent(other)
        if sibling_parent is not None:
            return sibling_parent

        if self.is_superset_of(other):
            return ExecCondition.from_conditions(other.condition_set())
        if other.is_superset_of(self):
            return ExecCondition.from_conditions(self.condition_set())

        return ExecCondition.from_conditions(str(self) + "||" + str(other))

    def __xor__(self, other: "ExecCondition") -> "ExecCondition":
        if other.is_strict_subset_of(self):
            return self.xor(other)
        assert self.is_strict_subset_of(other)
        return other.xor(self)

    def __str__(self):
        return " && ".join("(" + x + ")" for x in self.and_chain)

    def __eq__(self, other) -> bool:
        if not isinstance(other, ExecCondition):
            return NotImplemented
        return self.condition_set() == other.condition_set()

    def __hash__(self) -> int:
        return hash(self.condition_set())

    def condition_set(self) -> frozenset[str]:
        return frozenset(self._significant_conditions())

    def is_subset_of(self, other: "ExecCondition") -> bool:
        return self.condition_set().issubset(other.condition_set())

    def is_strict_subset_of(self, other: "ExecCondition") -> bool:
        return self.is_subset_of(other) and self != other

    def is_superset_of(self, other: "ExecCondition") -> bool:
        return self.condition_set().issuperset(other.condition_set())

    def is_strict_superset_of(self, other: "ExecCondition") -> bool:
        return self.is_superset_of(other) and self != other

    def xor(self, other: "ExecCondition") -> "ExecCondition":
        self_conditions = self.condition_set()
        other_conditions = other.condition_set()
        added_conditions = self_conditions - other_conditions

        assert other_conditions.issubset(self_conditions)
        assert len(added_conditions) == 1

        added_condition = next(iter(added_conditions))
        return ExecCondition.from_conditions([*other_conditions, self.make_not(added_condition)])

    def negated_sibling_parent(self, other: "ExecCondition") -> "ExecCondition | None":
        self_conditions = self.condition_set()
        other_conditions = other.condition_set()

        self_only = self_conditions - other_conditions
        other_only = other_conditions - self_conditions
        if len(self_only) != 1 or len(other_only) != 1:
            return None

        self_cond = next(iter(self_only))
        other_cond = next(iter(other_only))
        if not self.are_negations(self_cond, other_cond):
            return None

        return ExecCondition.from_conditions(self_conditions & other_conditions)

    def _significant_conditions(self) -> list[str]:
        return [cond for cond in self.and_chain if cond != self.DEFAULT]

    @staticmethod
    def _normalize_and_chain(and_chain) -> list[str]:
        normalized = sorted(cond for cond in and_chain if cond != ExecCondition.DEFAULT)
        if not normalized:
            return [ExecCondition.DEFAULT]
        return normalized

    @staticmethod
    def default() -> "ExecCondition":
        return ExecCondition([ExecCondition.DEFAULT])

    @staticmethod
    def from_conditions(conditions) -> "ExecCondition":
        and_chain = sorted(cond for cond in conditions if cond != ExecCondition.DEFAULT)
        if not and_chain:
            and_chain = [ExecCondition.DEFAULT]
        return ExecCondition(and_chain)

    @staticmethod
    def are_negations(left: str, right: str) -> bool:
        return left == ExecCondition.make_not(right) or right == ExecCondition.make_not(left)

    @staticmethod
    def make_not(cond: str) -> str:
        if len(cond) >= 3 and cond[:2] == "!(" and cond[-1] == ")":  # noqa: PLR2004
            return cond[2:-1:]
        return "!(" + cond + ")"
