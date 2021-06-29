from enum import Enum, auto


class OperationStatus(Enum):
    to_print = auto()
    to_fill_node = auto()
    to_print_unresolved = auto()
