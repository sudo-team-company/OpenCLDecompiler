from enum import Enum, auto


class TypeOfFlag(Enum):
    auto_decompilation = auto()
    only_opencl = auto()
    only_clrx = auto()
