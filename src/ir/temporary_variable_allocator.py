from typing import ClassVar


class TemporaryVariableAllocator:
    _counters: ClassVar[dict[str, int]] = {}

    @classmethod
    def generate(cls, prefix: str = "tmp") -> str:
        if prefix not in cls._counters:
            cls._counters[prefix] = 0

        count = cls._counters[prefix]
        cls._counters[prefix] += 1

        return f"__{prefix}_{count}"

    @classmethod
    def reset(cls) -> None:
        cls._counters.clear()
