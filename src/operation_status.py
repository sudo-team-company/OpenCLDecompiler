from enum import Enum, auto


class OperationStatus(Enum):
    TO_PRINT = auto()
    TO_FILL_NODE = auto()
    TO_PRINT_UNRESOLVED = auto()
