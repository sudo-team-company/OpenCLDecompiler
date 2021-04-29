from enum import Enum, auto


class Integrity(Enum):
    entire = auto()
    low_part = auto()
    high_part = auto()
