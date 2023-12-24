import enum
import re
from typing import Union, Optional

from src.integrity import Integrity
from src.opencl_types import vector_type_dict
from src.register_content import RegisterContent, EmptyRegisterContent
from src.register_content_combiner import RegisterContentCombiner
from src.register_type import RegisterType


class RegisterSignType(enum.Enum):
    POSITIVE = 0
    NEGATIVE = 1


class Register:
    def __init__(
            self,
            val,
            type_of_elem,
            integrity,
            *,
            size: int = 32,
            sign=RegisterSignType.POSITIVE,
            data_type: Optional[str] = None,
    ):
        self.val: Union[RegisterContentCombiner, any] = val
        self.type: Union[RegisterType, list[RegisterType]] = type_of_elem
        self.integrity: Integrity = integrity
        self.version = None
        self.prev_version = []
        self.data_type = data_type
        self.exec_condition = None
        self.size = size
        self.sign: Union[RegisterSignType, list[RegisterSignType]] = sign

    def get_value(self) -> any:
        if isinstance(self.val, RegisterContentCombiner):
            return self.val.maybe_get_by_idx(0).content

        return self.val

    def append_content(self, content: RegisterContent):
        if not isinstance(self.val, RegisterContentCombiner):
            raise Exception(f"Register value must be type of {type(RegisterContentCombiner)}")

        if self.val.get_size() + content.size > self.size:
            raise Exception(f"Combined content size mustn't be grater than {self.size} although size "
                            f"after content append is {self.val.get_size() + content.size}")

        self.val.append_content(content)

    def maybe_acquire_content(self, begin: int, end: int) -> Optional[RegisterContent]:
        if not isinstance(self.val, RegisterContentCombiner):
            raise Exception(f"Register value must be type of {type(RegisterContentCombiner)}")

        return self.val.maybe_acquire_content(begin, end)

    def try_unwrap_value(self) -> bool:
        from src.decompiler_data import make_op

        if not isinstance(self.val, RegisterContentCombiner):
            return False

        if self.val.get_count() == 0:
            self.val = None
            self.type = RegisterType.UNKNOWN
            self.sign = RegisterSignType.POSITIVE

            return True

        if self.val.get_count() == 1:
            self.type = self.val.maybe_get_by_idx(0).type
            self.val = self.val.maybe_get_by_idx(0).content

            return True

        return False

    def __and__(self, other):
        if not isinstance(self.val, RegisterContentCombiner):
            raise NotImplementedError()

        return self.val & other

    def __rshift__(self, other):
        if not isinstance(self.val, RegisterContentCombiner):
            raise NotImplementedError()

        return self.val >> other

    def __add__(self, other) -> "SumRegister":
        from src.sum_register import SumRegister
        if not isinstance(other, Register) and not isinstance(other, SumRegister):
            raise NotImplementedError()

        reg = other
        reg.try_unwrap_value()
        self.try_unwrap_value()

        if isinstance(reg, SumRegister):
            return reg + self
        if isinstance(reg, Register):
            return SumRegister([Register(
                val=self.val,
                type_of_elem=self.type,
                integrity=self.integrity,
                sign=self.sign,
            )]) + reg

    def add_version(self, name_version, num_version):
        self.version = name_version + "_" + str(num_version + 1)

    def make_prev(self):
        name_version = self.version[:self.version.find("_")]
        num_version = self.version[self.version.find("_") + 1:]
        self.prev_version = [name_version + "_" + str(int(num_version) - 1)]

    def add_prev(self, prev_version):
        self.prev_version.append(prev_version)

    def inc_version(self):
        name, version = self.version.split("_")
        return name + "_" + str(int(version) + 1)


def is_vector_type(data_type: str) -> bool:
    return data_type in vector_type_dict


def is_sgpr(reg: str) -> bool:
    """Matches s0, s12 and etc."""
    return re.match("s[0-9]+", reg) is not None


def is_vgpr(reg: str) -> bool:
    """Matches v0, v12 and etc."""
    return re.match("v[0-9]+", reg) is not None or reg == 'vcc'


def is_reg(reg: str) -> bool:
    return is_sgpr(reg) or is_vgpr(reg)


def is_sgpr_pair(reg: str) -> bool:
    """Matches s[0:1], s[10:11] and etc."""
    if re.match("s\\[[0-9]+:[0-9]+]", reg) is not None:
        start, end = reg.split(':')
        start: int = int(start[2:])
        end: int = int(end[:-1])
        return end - start == 1
    return False


def is_vgpr_pair(reg: str) -> bool:
    """Matches v[0:1], v[10:11] and etc."""
    if re.match("v\\[[0-9]+:[0-9]+]", reg) is not None:
        start, end = reg.split(':')
        start: int = int(start[2:])
        end: int = int(end[:-1])
        return end - start == 1
    return False


def is_pair(reg: str) -> bool:
    return is_sgpr_pair(reg) or is_vgpr_pair(reg)


def is_sgpr_range(reg: str) -> bool:
    """Matches s[0:1], s[10:12] and etc."""
    return re.match("s\\[[0-9]+:[0-9]+]", reg) is not None


def is_vgpr_range(reg: str) -> bool:
    """Matches v[0:1], v[10:12] and etc."""
    return re.match("v\\[[0-9]+:[0-9]+]", reg) is not None


def is_range(reg: str) -> bool:
    return is_vgpr_range(reg) or is_sgpr_range(reg)


def split_range(reg: str) -> (str, str):
    """Splits v[0:1], s[10:12] and etc."""
    start, end = reg.split(':')
    start: str = reg[0] + start[2:]
    end: str = reg[0] + end[:-1]
    return start, end


def check_and_split_regs(reg: str) -> (str, str):
    return split_range(reg) if is_range(reg) else (reg, reg)


def check_and_split_regs_range_to_full_list(reg: str) -> [str]:
    if not is_range(reg):
        return [reg]
    start, end = reg.split(':')
    return [reg[0] + str(i) for i in range(int(start[2:]), int(end[:-1]) + 1)]


def get_next_reg(reg: str) -> str:
    return reg[0] + str(int(reg[1:]) + 1)
