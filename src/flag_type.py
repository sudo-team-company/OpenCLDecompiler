from enum import Enum, auto


class FlagType(Enum):
    AUTO_DECOMPILATION = auto()
    ONLY_OPENCL = auto()
    ONLY_CLRX = auto()
