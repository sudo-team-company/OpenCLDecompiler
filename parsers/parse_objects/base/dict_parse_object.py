from typing import Optional

from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.parse_object import EmptyParseObject


class DictParseObject(ParseObject):
    def __init__(self, obj: dict[any, any]):
        super().__init__(obj)

    def __add__(self, other: "ParseObject") -> Optional["ParseObject"]:
        if isinstance(other, EmptyParseObject):
            return self

        if not isinstance(other, DictParseObject):
            return None

        tmp_obj = self.obj.copy()
        tmp_obj.update(other.obj)
        return DictParseObject(tmp_obj)

    def __repr__(self) -> str:
        return str(self.obj)
