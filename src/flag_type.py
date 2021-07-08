from enum import Enum, auto


class FlagType(Enum):
    auto_decompilation = auto()
    only_opencl = auto()
    only_clrx = auto()
