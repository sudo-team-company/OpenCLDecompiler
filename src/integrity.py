from enum import Enum, auto


class Integrity(Enum):
    integer = auto()
    low_part = auto()
    high_part = auto()
