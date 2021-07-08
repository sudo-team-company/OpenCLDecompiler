from enum import Enum, auto


class NodeRegionType(Enum):
    basic = auto()
    linear = auto()
    ifstatement = auto()
    ifelsestatement = auto()
    circle = auto()
    startcircle = auto()
    backedge = ()
    breakregion = ()
    continueregion = ()
    returnregion = ()
