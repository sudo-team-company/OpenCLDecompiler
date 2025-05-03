import copy
from enum import Enum

from src.expression_manager.types.asm_types import ASMTypes
from src.expression_manager.types.base_type import BaseType, UnknownTypeExceptionError

_byte_size_to_type_integer: dict[int, str] = {
    1: "char",
    2: "short",
    4: "int",
    8: "long",
}

_byte_size_to_type_float: dict[int, str] = {
    2: "half",
    4: "float",
    8: "double",
}


class OpenCLType(BaseType):
    def __init__(self, size_bytes=0, is_signed=True, is_integer=True, number_of_components=1):  # noqa: FBT002
        super().__init__(size_bytes, is_signed, is_integer, number_of_components)

    def get_type_string(self):
        if self.is_integer:
            if _byte_size_to_type_integer.get(self.size_bytes) is not None:
                return _byte_size_to_type_integer[self.size_bytes]
            raise UnknownTypeExceptionError
        # float
        if _byte_size_to_type_float.get(self.size_bytes) is not None:
            return _byte_size_to_type_float[self.size_bytes]
        raise UnknownTypeExceptionError

    def __str__(self):
        if self.size_bytes <= 0:
            return "Unknown OpenCL Type"

        signed_prefix = "u" if self.is_integer and not self.is_signed else ""
        type_prefix = self.get_type_string()
        number_of_components_prefix = "" if self.number_of_components == 1 else str(self.number_of_components)

        return signed_prefix + type_prefix + number_of_components_prefix


class UnknownOpenCLType(OpenCLType):
    def __init__(self):
        super().__init__(0)


class OpenCLTypes(Enum):
    def __str__(self):
        return str(self.value)

    def __eq__(self, other):
        return self.value == other.value

    @staticmethod
    def from_string(type_hint) -> "OpenCLTypes":
        if isinstance(type_hint, OpenCLTypes):
            return type_hint

        if not isinstance(type_hint, str):
            return OpenCLTypes.UNKNOWN

        assert type_hint.startswith("g") is False
        assert type_hint.startswith("__global ") is False

        if "b32" in type_hint or "b64" in type_hint:
            type_hint = type_hint.replace("b", "u", 1)

        opencl_type = OpenCLTypes.UNKNOWN
        for e in OpenCLTypes:
            if str(e) == type_hint:
                opencl_type = e
        if opencl_type == OpenCLTypes.UNKNOWN:
            asm_type = ASMTypes.from_string(type_hint)
            if asm_type != ASMTypes.UNKNOWN:
                opencl_type = OpenCLTypes.from_asm_type(asm_type)

        return opencl_type

    @staticmethod
    def from_asm_type(asm_type: ASMTypes) -> "OpenCLTypes":
        for t in OpenCLTypes:
            if t.value == asm_type.value:
                return t
        return OpenCLTypes.UNKNOWN

    def equal_without_modifiers(self, other: "OpenCLTypes") -> bool:
        return self.value.equal_without_modifiers(other.value)

    def set_number_of_components(self, number_of_components) -> "OpenCLTypes":
        new_type_value = copy.deepcopy(self.value)
        new_type_value.number_of_components = number_of_components
        return OpenCLTypes.from_string(str(new_type_value))

    def set_is_integer(self, is_integer) -> "OpenCLTypes":
        new_type_value = copy.deepcopy(self.value)
        new_type_value.is_integer = is_integer
        return OpenCLTypes.from_string(str(new_type_value))

    UNKNOWN = UnknownOpenCLType()

    # Base Types
    CHAR = OpenCLType(size_bytes=1)
    UCHAR = OpenCLType(size_bytes=1, is_signed=False)

    SHORT = OpenCLType(size_bytes=2)
    USHORT = OpenCLType(size_bytes=2, is_signed=False)

    INT = OpenCLType(size_bytes=4)
    UINT = OpenCLType(size_bytes=4, is_signed=False)

    LONG = OpenCLType(size_bytes=8)
    ULONG = OpenCLType(size_bytes=8, is_signed=False)

    HALF = OpenCLType(size_bytes=2, is_integer=False)
    FLOAT = OpenCLType(size_bytes=4, is_integer=False)
    DOUBLE = OpenCLType(size_bytes=8, is_integer=False)

    # Vector Types
    CHAR2 = OpenCLType(size_bytes=1, number_of_components=2)
    CHAR3 = OpenCLType(size_bytes=1, number_of_components=3)
    CHAR4 = OpenCLType(size_bytes=1, number_of_components=4)
    CHAR8 = OpenCLType(size_bytes=1, number_of_components=8)

    UCHAR2 = OpenCLType(size_bytes=1, number_of_components=2, is_signed=False)
    UCHAR3 = OpenCLType(size_bytes=1, number_of_components=3, is_signed=False)
    UCHAR4 = OpenCLType(size_bytes=1, number_of_components=4, is_signed=False)
    UCHAR8 = OpenCLType(size_bytes=1, number_of_components=8, is_signed=False)

    SHORT2 = OpenCLType(size_bytes=2, number_of_components=2)
    SHORT3 = OpenCLType(size_bytes=2, number_of_components=3)
    SHORT4 = OpenCLType(size_bytes=2, number_of_components=4)
    SHORT8 = OpenCLType(size_bytes=2, number_of_components=8)

    USHORT2 = OpenCLType(size_bytes=2, number_of_components=2, is_signed=False)
    USHORT3 = OpenCLType(size_bytes=2, number_of_components=3, is_signed=False)
    USHORT4 = OpenCLType(size_bytes=2, number_of_components=4, is_signed=False)
    USHORT8 = OpenCLType(size_bytes=2, number_of_components=8, is_signed=False)

    INT2 = OpenCLType(size_bytes=4, number_of_components=2)
    INT3 = OpenCLType(size_bytes=4, number_of_components=3)
    INT4 = OpenCLType(size_bytes=4, number_of_components=4)
    INT8 = OpenCLType(size_bytes=4, number_of_components=8)

    UINT2 = OpenCLType(size_bytes=4, number_of_components=2, is_signed=False)
    UINT3 = OpenCLType(size_bytes=4, number_of_components=3, is_signed=False)
    UINT4 = OpenCLType(size_bytes=4, number_of_components=4, is_signed=False)
    UINT8 = OpenCLType(size_bytes=4, number_of_components=8, is_signed=False)

    LONG2 = OpenCLType(size_bytes=8, number_of_components=2)
    LONG3 = OpenCLType(size_bytes=8, number_of_components=3)
    LONG4 = OpenCLType(size_bytes=8, number_of_components=4)
    LONG8 = OpenCLType(size_bytes=8, number_of_components=8)

    ULONG2 = OpenCLType(size_bytes=8, number_of_components=2, is_signed=False)
    ULONG3 = OpenCLType(size_bytes=8, number_of_components=3, is_signed=False)
    ULONG4 = OpenCLType(size_bytes=8, number_of_components=4, is_signed=False)
    ULONG8 = OpenCLType(size_bytes=8, number_of_components=8, is_signed=False)

    HALF2 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=2)
    HALF3 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=3)
    HALF4 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=4)
    HALF8 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=8)

    FLOAT2 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=2)
    FLOAT3 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=3)
    FLOAT4 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=4)
    FLOAT8 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=8)

    DOUBLE2 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=2)
    DOUBLE3 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=3)
    DOUBLE4 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=4)
    DOUBLE8 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=8)
