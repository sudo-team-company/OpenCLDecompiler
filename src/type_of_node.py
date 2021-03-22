from enum import Enum, auto


class TypeNode(Enum):
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
