from enum import Enum, auto


class RegionType(Enum):
    BASIC = auto()
    LINEAR = auto()
    IF_STATEMENT = auto()
    IF_ELSE_STATEMENT = auto()
    LOOP = auto()
    START_LOOP = auto()
    BACK_EDGE = auto()
    BREAK_REGION = auto()
    CONTINUE_REGION = auto()
    RETURN_REGION = auto()
    UNROLLED_LOOP = auto()
