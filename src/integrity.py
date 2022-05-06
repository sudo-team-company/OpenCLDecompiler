from enum import Enum, auto


class Integrity(Enum):
    ENTIRE = auto()
    LOW_PART = auto()
    HIGH_PART = auto()
