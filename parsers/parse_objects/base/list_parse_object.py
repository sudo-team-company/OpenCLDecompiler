from typing import Optional

from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.parse_object import EmptyParseObject


class ListParseObject(ParseObject):
    def __init__(self, obj: list[any]):
        super().__init__(obj)

    def __add__(self, other: "ParseObject") -> Optional["ParseObject"]:
        if isinstance(other, EmptyParseObject):
            return self

        if not isinstance(other, ListParseObject):
            return None

        tmp_obj = self.obj.copy()
        tmp_obj.extend(other.obj)
        return ListParseObject(tmp_obj)

    def __repr__(self) -> str:
        return str(self.obj)
