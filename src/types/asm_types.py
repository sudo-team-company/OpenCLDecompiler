from enum import Enum

from src.expression_tree.base_type import BaseType, UnknownTypeException
    
class ASMType(BaseType):
    def __init__(self, size_bytes = 0, is_signed = True, is_integer = True, number_of_components = 1, is_global = False):
        super().__init__(size_bytes, is_signed, is_integer, number_of_components, is_global)

    def getTypeString(self):
        if self.is_integer:
            signed_prefix = "u" if self.is_integer and not self.is_signed else "i"

            if self.size_bytes == 8:
                return signed_prefix + "64"
            elif self.size_bytes == 4:
                return signed_prefix + "32"
            elif self.size_bytes == 2:
                return signed_prefix + "16"
            elif self.size_bytes == 1:
                return signed_prefix + "8"
            else:
                raise UnknownTypeException
        else:
            if self.size_bytes == 8:
                return "f64"
            elif self.size_bytes == 4:
                return "f32"
            elif self.size_bytes == 2:
                return "f16"
            else:
                raise UnknownTypeException

    def __str__(self):
        if self.size_bytes <= 0:
            return "Unknown ASM Type"

        global_prefix = "g" if self.is_global else ""
        type_prefix = self.getTypeString()
        number_of_components_prefix = "" if self.number_of_components == 1 else str(self.number_of_components)

        return global_prefix + type_prefix + number_of_components_prefix

class UnknownASMType(ASMType):
    def __init__(self):
        super().__init__()

class ASMTypes(Enum):
    def __str__(self):
        return str(self.value)
    
    def __eq__(self, other):
        return self.value == other.value
    
    def fromString(s) -> ASMType:
        for e in ASMTypes:
            if str(e) == s:
                return e.value
        return ASMTypes.UNKNOWN.value
    
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

    # Global Types
    GLOBAL_CHAR = ASMType(size_bytes=1, is_global=True)
    GLOBAL_UCHAR = ASMType(size_bytes=1, is_signed=False, is_global=True)
    GLOBAL_SHORT = ASMType(size_bytes=2, is_global=True)
    GLOBAL_USHORT = ASMType(size_bytes=2, is_signed=False, is_global=True)
    GLOBAL_INT = ASMType(size_bytes=4, is_global=True)
    GLOBAL_UINT = ASMType(size_bytes=4, is_signed=False, is_global=True)
    GLOBAL_LONG = ASMType(size_bytes=8, is_global=True)
    GLOBAL_ULONG = ASMType(size_bytes=8, is_signed=False, is_global=True)
    GLOBAL_HALF = ASMType(size_bytes=2, is_integer=False, is_global=True)
    GLOBAL_FLOAT = ASMType(size_bytes=4, is_integer=False, is_global=True)
    GLOBAL_DOUBLE = ASMType(size_bytes=8, is_integer=False, is_global=True)
    GLOBAL_CHAR2 = ASMType(number_of_components=2, is_global=True)
    GLOBAL_CHAR4 = ASMType(number_of_components=4, is_global=True)
    GLOBAL_CHAR8 = ASMType(number_of_components=8, is_global=True)
    GLOBAL_UCHAR2 = ASMType(number_of_components=2, is_signed=False, is_global=True)
    GLOBAL_UCHAR4 = ASMType(number_of_components=4, is_signed=False, is_global=True)
    GLOBAL_UCHAR8 = ASMType(number_of_components=8, is_signed=False, is_global=True)
    GLOBAL_SHORT2 = ASMType(size_bytes=2, number_of_components=2, is_global=True)
    GLOBAL_SHORT4 = ASMType(size_bytes=2, number_of_components=4, is_global=True)
    GLOBAL_SHORT8 = ASMType(size_bytes=2, number_of_components=8, is_global=True)
    GLOBAL_USHORT2 = ASMType(size_bytes=2, number_of_components=2, is_signed=False, is_global=True)
    GLOBAL_USHORT4 = ASMType(size_bytes=2, number_of_components=4, is_signed=False, is_global=True)
    GLOBAL_USHORT8 = ASMType(size_bytes=2, number_of_components=8, is_signed=False, is_global=True)
    GLOBAL_INT2 = ASMType(size_bytes=4, number_of_components=2, is_global=True)
    GLOBAL_INT4 = ASMType(size_bytes=4, number_of_components=4, is_global=True)
    GLOBAL_INT8 = ASMType(size_bytes=4, number_of_components=8, is_global=True)
    GLOBAL_UINT2 = ASMType(size_bytes=4, number_of_components=2, is_signed=False, is_global=True)
    GLOBAL_UINT4 = ASMType(size_bytes=4, number_of_components=4, is_signed=False, is_global=True)
    GLOBAL_UINT8 = ASMType(size_bytes=4, number_of_components=8, is_signed=False, is_global=True)
    GLOBAL_LONG2 = ASMType(size_bytes=8, number_of_components=2, is_global=True)
    GLOBAL_LONG4 = ASMType(size_bytes=8, number_of_components=4, is_global=True)
    GLOBAL_LONG8 = ASMType(size_bytes=8, number_of_components=8, is_global=True)
    GLOBAL_ULONG2 = ASMType(size_bytes=8, number_of_components=2, is_signed=False, is_global=True)
    GLOBAL_ULONG4 = ASMType(size_bytes=8, number_of_components=4, is_signed=False, is_global=True)
    GLOBAL_ULONG8 = ASMType(size_bytes=8, number_of_components=8, is_signed=False, is_global=True)
    GLOBAL_HALF2 = ASMType(size_bytes=2, is_integer=False, number_of_components=2, is_global=True)
    GLOBAL_HALF4 = ASMType(size_bytes=2, is_integer=False, number_of_components=4, is_global=True)
    GLOBAL_HALF8 = ASMType(size_bytes=2, is_integer=False, number_of_components=8, is_global=True)
    GLOBAL_FLOAT2 = ASMType(size_bytes=4, is_integer=False, number_of_components=2, is_global=True)
    GLOBAL_FLOAT4 = ASMType(size_bytes=4, is_integer=False, number_of_components=4, is_global=True)
    GLOBAL_FLOAT8 = ASMType(size_bytes=4, is_integer=False, number_of_components=8, is_global=True)
    GLOBAL_DOUBLE2 = ASMType(size_bytes=8, is_integer=False, number_of_components=2, is_global=True)
    GLOBAL_DOUBLE4 = ASMType(size_bytes=8, is_integer=False, number_of_components=4, is_global=True)
    GLOBAL_DOUBLE8 = ASMType(size_bytes=8, is_integer=False, number_of_components=8, is_global=True)

# print(ASMTypes.CHAR2)
# print(ASMTypes.HALF)
# print(ASMTypes.FLOAT)
# print(ASMTypes.DOUBLE)
# print(ASMTypes.FLOAT4)
# print(ASMTypes.FLOAT8)
# print(ASMTypes.GLOBAL_FLOAT8)
# print(ASMTypes.fromString("f64"))
# print(ASMTypes.fromString("gf64"))
