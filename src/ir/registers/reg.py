from __future__ import annotations

from abc import ABC, abstractmethod


RESERVED_REGISTER_NAME_CHARS = frozenset({"|", "#"})


def validate_register_name(name: str) -> None:
    forbidden_chars = RESERVED_REGISTER_NAME_CHARS.intersection(name)
    if forbidden_chars:
        chars = ", ".join(f"'{char}'" for char in sorted(forbidden_chars))
        raise ValueError(f"Register name '{name}' contains reserved character(s): {chars}")


class BaseReg(ABC):
    @property
    @abstractmethod
    def bit_width(self) -> int:
        pass

    @property
    @abstractmethod
    def type_suffix(self) -> str:
        pass

    @abstractmethod
    def to_text(self) -> str:
        pass


class Reg32(BaseReg):
    def __init__(self, name: str, *, _internal: bool = False):
        if not _internal:
            validate_register_name(name)
        self._name: str = name

    @property
    def bit_width(self) -> int:
        return 32

    @property
    def type_suffix(self) -> str:
        return "b32"

    @property
    def name(self) -> str:
        return self._name

    def to_text(self) -> str:
        return self._name


    @classmethod
    def internal(cls, name: str) -> Reg32:
        return cls(name, _internal=True)


class CompositeReg(BaseReg):
    def __init__(self, name: str, regs: list[Reg32], *, _internal: bool = False):
        if not _internal:
            validate_register_name(name)
        self._regs: tuple[Reg32, ...] = tuple(regs)
        self._name: str = name

    @property
    def bit_width(self) -> int:
        return 32 * len(self._regs)

    @property
    def type_suffix(self) -> str:
        return f"b{self.bit_width}"

    @property
    def regs(self) -> tuple[Reg32, ...]:
        return self._regs

    @property
    def name(self) -> str:
        return self._name
    
    def to_text(self) -> str:
        names = [reg.to_text() for reg in self._regs]
        return f"{self._name}[{', '.join(names)}]"

    def get_element(self, index: int) -> Reg32:
        return self._regs[index]

    @classmethod
    def internal(cls, name: str, regs: list[Reg32]) -> CompositeReg:
        return cls(name, regs, _internal=True)
    
    def __len__(self):
        return len(self._regs)
    

class Reg64(CompositeReg):
    def __init__(self, name: str, *, _internal: bool = False):
        if not _internal:
            validate_register_name(name)
        super().__init__(
            name,
            [Reg32.internal(name + "|lo"), Reg32.internal(name + "|hi")],
            _internal=True,
        )

    @classmethod
    def internal(cls, name: str) -> Reg64:
        return cls(name, _internal=True)


class PredReg(Reg64):
    def __init__(self, name: str, *, _internal: bool = False):
        super().__init__(name, _internal=_internal)

    @property
    def type_suffix(self) -> str:
        return "pred"


class Val:
    def __init__(self, value: str):
        self._value = value

    @property
    def value(self) -> str:
        return self._value

    @property
    def name(self) -> str:
        return self._value
    
    def to_text(self) -> str:
        return self._value
    


Reg_ty = Reg32 | Reg64 | PredReg | CompositeReg
RegOrVal_ty = Reg_ty | Val

def get_reg_rang(reg: Reg_ty) -> tuple[Reg32, ...]:
    if isinstance(reg, CompositeReg):
        return tuple(reg.regs)
    return (reg,)

def expand_register_names(reg: Reg_ty) -> tuple[str, ...]:
    return tuple(sub_reg.name for sub_reg in get_reg_rang(reg))

def is_reg(reg) -> bool:
    return isinstance(reg, Reg32)

def is_range(reg) -> bool:
    return isinstance(reg, CompositeReg)

def is_predicate(reg) -> bool:
    return isinstance(reg, PredReg)
