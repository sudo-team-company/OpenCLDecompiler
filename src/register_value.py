from typing import Optional

from src.register_type import RegisterType


class ValueSegment:
    def __init__(self, begin: int, end: int, val: any, type: RegisterType):
        assert begin >= end

        self.begin = begin
        self.end = end

        self.val = val
        self.type = type


class RegisterValue:
    def __init__(self, bits: int, val: any):
        self.bits: int = bits
        self.segments: list[ValueSegment] = []

        self.insert_value(val)

    def maybe_acquire_value(self, begin: int, end: int) -> Optional[tuple[any, RegisterType]]:
        for segment in self.segments:
            if segment.begin == begin and segment.end == end:
                return segment.val, segment.type

        return None

    def insert_value(self, obj: any):
        if isinstance(obj, list):
            for elem in obj:
                if not isinstance(elem, tuple):
                    raise Exception("List value must be specified as tuple")

                x, type_, begin, end = elem
                self.segments.append(ValueSegment(begin, end, x, type_))
        else:
            if isinstance(obj, tuple):
                x, type_ = obj
                self.segments.append(ValueSegment(self.bits - 1, 0, obj, type_))
            else:
                self.segments.append(ValueSegment(self.bits - 1, 0, obj, RegisterType.UNKNOWN))

        self._sort_segments()

    def _sort_segments(self):
        self.segments.sort(key=lambda x: x.begin)
