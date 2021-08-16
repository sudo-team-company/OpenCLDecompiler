from enum import Enum, auto


class RegionType(Enum):
    basic = auto()
    linear = auto()
    ifstatement = auto()
    ifelsestatement = auto()
    circle = auto()
    startcircle = auto()
    backedge = auto()
    breakregion = auto()
    continueregion = auto()
    returnregion = auto()
