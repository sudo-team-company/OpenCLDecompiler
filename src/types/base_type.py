from dataclasses import dataclass
from enum import Enum, auto


class UnknownTypeException(Exception):
    pass

class TypeModifiers(Enum):
    GLOBAL = auto()
    LOCAL = auto()
    CONST = auto()
    PRIVATE = auto()

class BaseType:
    def __init__(self, size_bytes = 0, is_signed = True, is_integer = True, number_of_components = 0, is_global = False):
        self.size_bytes = size_bytes
        self.is_signed = is_signed
        self.is_integer = is_integer
        self.number_of_components = number_of_components
        self.modifiers: set[TypeModifiers] = set()
        if is_global:
            self.modifiers.add(TypeModifiers.GLOBAL)

    def getSize(self):
        return int(self.size_bytes) * int(self.number_of_components)
    
    def __eq__(self, other) -> bool:
        return self.size_bytes == other.size_bytes and\
        self.is_signed == other.is_signed and\
        self.is_integer == other.is_integer and\
        self.number_of_components == other.number_of_components and\
        self.modifiers == other.modifiers

class UnknownType(BaseType):
    def __init__(self):
        super().__init__(0, False, False, 0, False)

    def __str__(self):
        return "UNKNOWN TYPE"