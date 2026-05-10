from __future__ import annotations

from abc import ABC, abstractmethod


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
    def __init__(self, name: str):
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
    def create_new(cls, name: str) -> Reg32:
        return cls(name) 

class CompositeReg(BaseReg):
    def __init__(self, name: str, regs: list[Reg32]):
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
    def create_new(cls, name: str, regs: list[Reg32]) -> CompositeReg:
        return cls(name, regs) 
    
    def __len__(self):
        return len(self._regs)
    

class Reg64(CompositeReg):
    def __init__(self, name: str):
        super().__init__(name, [Reg32(name+"|lo"), Reg32(name+"|hi")])

    @classmethod
    def create_new(cls, name: str, regs: list[Reg32]) -> CompositeReg:
        res = cls(name) 
        res._regs[0]._name = regs[0].name
        res._regs[1]._name = regs[1].name
        return res
    
class PredReg(Reg64):
    def __init__(self, name: str):
        super().__init__(name)

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
    
    @classmethod
    def create_new(cls, name: str) -> Reg32:
        return cls(name) 


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