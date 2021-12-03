import re

from src.integrity import Integrity
from src.register_type import RegisterType


class Register:
    def __init__(self, val, type_of_elem, integrity):
        self.val = val
        self.type: RegisterType = type_of_elem
        self.integrity: Integrity = integrity
        self.version = None
        self.prev_version = []
        self.data_type = None

    def add_version(self, name_version, num_version):
        self.version = name_version + "_" + str(num_version + 1)

    def make_prev(self):
        name_version = self.version[:self.version.find("_")]
        num_version = self.version[self.version.find("_") + 1:]
        self.prev_version = [name_version + "_" + str(int(num_version) - 1)]

    def add_prev(self, prev_version):
        self.prev_version.append(prev_version)


def is_sgpr(reg: str) -> bool:
    """Matches s0, s12 and etc."""
    return re.match("s[0-9]+", reg) is not None


def is_vgpr(reg: str) -> bool:
    """Matches v0, v12 and etc."""
    return re.match("v[0-9]+", reg) is not None


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
    """Matches v[0:1], v[10:12] and etc."""
    if re.match("v\\[[0-9]+:[0-9]+]", reg) is not None:
        start, end = reg.split(':')
        start: int = int(start[2:])
        end: int = int(end[:-1])
        return end - start == 1
    return False


def is_pair(reg: str) -> bool:
    return is_sgpr_pair(reg) or is_vgpr_pair(reg)


def is_sgpr_range(reg: str) -> bool:
    """Matches s[0:1], s[10:11] and etc."""
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


def get_next_reg(reg: str) -> str:
    return reg[0] + str(int(reg[1:]) + 1)
