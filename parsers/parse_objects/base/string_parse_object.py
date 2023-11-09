from typing import Optional

from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.parse_object import EmptyParseObject


class StringParseObject(ParseObject):
    def __init__(self, obj: str):
        super().__init__(obj)

    def __add__(self, other: ParseObject) -> Optional[ParseObject]:
        if isinstance(other, EmptyParseObject):
            return self

        if not isinstance(other, StringParseObject):
            return None

        return StringParseObject(self.obj + other.obj)

    def __repr__(self) -> str:
        return self.obj
