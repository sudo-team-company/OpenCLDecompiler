from enum import Enum

from src.expression_manager.types.base_type import BaseType, UnknownTypeExceptionError


class ASMType(BaseType):
    def __init__(self, size_bytes=0, is_signed=True, is_integer=True, number_of_components=1):  # noqa: FBT002
        super().__init__(size_bytes, is_signed, is_integer, number_of_components)

    def get_type_string(self):
        if self.is_integer:
            signed_prefix = "u" if self.is_integer and not self.is_signed else "i"
            if self.size_bytes in [1, 2, 4, 8]:
                return signed_prefix + f"{self.size_bytes * 8}"
            raise UnknownTypeExceptionError
        # float
        if self.size_bytes in [2, 4, 8]:
            return f"f{self.size_bytes * 8}"
        raise UnknownTypeExceptionError

    def __str__(self):
        if self.size_bytes <= 0:
            return "Unknown ASM Type"

        type_prefix = self.get_type_string()
        number_of_components_prefix = "" if self.number_of_components == 1 else str(self.number_of_components)

        return type_prefix + number_of_components_prefix


class UnknownASMType(ASMType):
    def __init__(self):
        super().__init__()


class ASMTypes(Enum):
    def __str__(self):
        return str(self.value)

    def __eq__(self, other):
        return self.value == other.value

    def __hash__(self):
        return hash(self.value)

    @staticmethod
    def from_string(s):
        for e in ASMTypes:
            if str(e) == s:
                return e
        return ASMTypes.UNKNOWN

    UNKNOWN = UnknownASMType()

    # Base Types
    CHAR = ASMType(size_bytes=1)
    UCHAR = ASMType(size_bytes=1, is_signed=False)

    SHORT = ASMType(size_bytes=2)
    USHORT = ASMType(size_bytes=2, is_signed=False)

    INT = ASMType(size_bytes=4)
    UINT = ASMType(size_bytes=4, is_signed=False)

    LONG = ASMType(size_bytes=8)
    ULONG = ASMType(size_bytes=8, is_signed=False)

    HALF = ASMType(size_bytes=2, is_integer=False)
    FLOAT = ASMType(size_bytes=4, is_integer=False)
    DOUBLE = ASMType(size_bytes=8, is_integer=False)

    # Vector Types
    CHAR2 = ASMType(size_bytes=1, number_of_components=2)
    CHAR4 = ASMType(size_bytes=1, number_of_components=4)
    CHAR8 = ASMType(size_bytes=1, number_of_components=8)
    UCHAR2 = ASMType(size_bytes=1, number_of_components=2, is_signed=False)
    UCHAR4 = ASMType(size_bytes=1, number_of_components=4, is_signed=False)
    UCHAR8 = ASMType(size_bytes=1, number_of_components=8, is_signed=False)

    SHORT2 = ASMType(size_bytes=2, number_of_components=2)
    SHORT4 = ASMType(size_bytes=2, number_of_components=4)
    SHORT8 = ASMType(size_bytes=2, number_of_components=8)
    USHORT2 = ASMType(size_bytes=2, number_of_components=2, is_signed=False)
    USHORT4 = ASMType(size_bytes=2, number_of_components=4, is_signed=False)
    USHORT8 = ASMType(size_bytes=2, number_of_components=8, is_signed=False)

    INT2 = ASMType(size_bytes=4, number_of_components=2)
    INT4 = ASMType(size_bytes=4, number_of_components=4)
    INT8 = ASMType(size_bytes=4, number_of_components=8)
    UINT2 = ASMType(size_bytes=4, number_of_components=2, is_signed=False)
    UINT4 = ASMType(size_bytes=4, number_of_components=4, is_signed=False)
    UINT8 = ASMType(size_bytes=4, number_of_components=8, is_signed=False)

    LONG2 = ASMType(size_bytes=8, number_of_components=2)
    LONG4 = ASMType(size_bytes=8, number_of_components=4)
    LONG8 = ASMType(size_bytes=8, number_of_components=8)
    ULONG2 = ASMType(size_bytes=8, number_of_components=2, is_signed=False)
    ULONG4 = ASMType(size_bytes=8, number_of_components=4, is_signed=False)
    ULONG8 = ASMType(size_bytes=8, number_of_components=8, is_signed=False)

    HALF2 = ASMType(size_bytes=2, is_integer=False, number_of_components=2)
    HALF4 = ASMType(size_bytes=2, is_integer=False, number_of_components=4)
    HALF8 = ASMType(size_bytes=2, is_integer=False, number_of_components=8)

    FLOAT2 = ASMType(size_bytes=4, is_integer=False, number_of_components=2)
    FLOAT4 = ASMType(size_bytes=4, is_integer=False, number_of_components=4)
    FLOAT8 = ASMType(size_bytes=4, is_integer=False, number_of_components=8)

    DOUBLE2 = ASMType(size_bytes=8, is_integer=False, number_of_components=2)
    DOUBLE4 = ASMType(size_bytes=8, is_integer=False, number_of_components=4)
    DOUBLE8 = ASMType(size_bytes=8, is_integer=False, number_of_components=8)
