from abc import ABC, abstractmethod
from typing import List, Tuple


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

    def __str__(self):
        return self.to_text()


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


class Reg64(BaseReg):
    def __init__(self, name: str):
        self._name: str = name

    @property
    def bit_width(self) -> int:
        return 64

    @property
    def type_suffix(self) -> str:
        return "b64"

    @property
    def name(self) -> str:
        return self._name

    def to_text(self) -> str:
        return self._name


class PredReg(BaseReg):
    def __init__(self, name: str = "exec"):
        self._name: str = name

    @property
    def bit_width(self) -> int:
        return 64

    @property
    def type_suffix(self) -> str:
        return "pred"

    @property
    def name(self) -> str:
        return self._name

    def to_text(self) -> str:
        return self._name


class CompositeReg(BaseReg):

    def __init__(self, name: str, regs: List[Reg32]):
        self._regs: Tuple[Reg32, ...] = tuple(regs)
        self._name: str = name

    @property
    def bit_width(self) -> int:
        return 32 * len(self._regs)

    @property
    def type_suffix(self) -> str:
        return f"b{self.bit_width}"

    @property
    def regs(self) -> Tuple[Reg32, ...]:
        return self._regs

    @property
    def name(self) -> str:
        return self._name
    
    def to_text(self) -> str:
        names = [reg.to_text() for reg in self._regs]
        return f"{self._name}[{', '.join(names)}]"

    def get_element(self, index: int) -> Reg32:
        return self._regs[index]

    def __len__(self):
        return len(self._regs)



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
