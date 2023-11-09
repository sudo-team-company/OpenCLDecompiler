from abc import abstractmethod
from typing import Optional


class ParseObject:
    def __init__(self, obj: any):
        self._obj = obj

    @property
    def obj(self) -> any:
        return self._obj

    @abstractmethod
    def __add__(self, other: "ParseObject") -> Optional["ParseObject"]:
        pass


class EmptyParseObject(ParseObject):
    def __init__(self):
        super().__init__(None)

    def __add__(self, other: ParseObject) -> Optional[ParseObject]:
        return other

    def __repr__(self) -> str:
        return ""
