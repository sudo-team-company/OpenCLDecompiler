from src.register import Register


class KernelState:
    def __init__(self):
        self._registers: dict[str, Register] = {}

    def get(self, key: str, default: Register | None = None) -> Register | None:
        return self._registers.get(key, default)

    def __getitem__(self, key: str) -> Register:
        return self._registers[key]

    def __setitem__(self, key: str, value: Register):
        assert isinstance(key, str)
        assert isinstance(value, Register)
        self._registers[key] = value

    def __iter__(self):
        return self._registers.__iter__()

    def __contains__(self, key: str) -> bool:
        return self._registers.__contains__(key)
