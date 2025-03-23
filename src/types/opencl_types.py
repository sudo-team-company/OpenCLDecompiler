from enum import Enum

from src.types.asm_types import ASMTypes
from src.types.base_type import BaseType, TypeModifiers, UnknownTypeException

class OpenCLType(BaseType):
    def __init__(self, size_bytes = 0, is_signed = True, is_integer = True, number_of_components = 1, is_global = False):
        super().__init__(size_bytes, is_signed, is_integer, number_of_components, is_global)

    def getTypeString(self):
        if self.is_integer:
            if self.size_bytes == 8:
                return "long"
            elif self.size_bytes == 4:
                return "int"
            elif self.size_bytes == 2:
                return "short"
            elif self.size_bytes == 1:
                return "char"
            else:
                raise UnknownTypeException
        else:
            if self.size_bytes == 8:
                return "double"
            elif self.size_bytes == 4:
                return "float"
            elif self.size_bytes == 2:
                return "half"
            else:
                raise UnknownTypeException

    def __str__(self):
        if self.size_bytes <= 0:
            return "Unknown OpenCL Type"

        global_prefix = "__global " if TypeModifiers.GLOBAL in self.modifiers else ""
        signed_prefix = "u" if self.is_integer and not self.is_signed else ""
        type_prefix = self.getTypeString()
        number_of_components_prefix = "" if self.number_of_components == 1 else str(self.number_of_components)

        return global_prefix + signed_prefix + type_prefix + number_of_components_prefix

class UnknownOpenCLType(OpenCLType):
    def __init__(self):
        super().__init__(0)

#todo: add ptr, local and const
class OpenCLTypes(Enum):
    def __str__(self):
        return str(self.value)
    
    def __eq__(self, other):
        return self.value == other.value
    
    def from_string(s):
        for e in OpenCLTypes:
            if str(e) == s:
                return e
        return OpenCLTypes.UNKNOWN
    
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

    HALF =  OpenCLType(size_bytes=2, is_integer=False)
    FLOAT =     OpenCLType(size_bytes=4, is_integer=False)
    DOUBLE =     OpenCLType(size_bytes=8, is_integer=False)

    # Vector Types
    CHAR2 =     OpenCLType(size_bytes=1, number_of_components=2)
    CHAR4 =     OpenCLType(size_bytes=1, number_of_components=4)
    CHAR8 =     OpenCLType(size_bytes=1, number_of_components=8)
    UCHAR2 =    OpenCLType(size_bytes=1, number_of_components=2, is_signed=False)
    UCHAR4 =    OpenCLType(size_bytes=1, number_of_components=4, is_signed=False)
    UCHAR8 =    OpenCLType(size_bytes=1, number_of_components=8, is_signed=False)

    SHORT2 =    OpenCLType(size_bytes=2, number_of_components=2)
    SHORT4 =    OpenCLType(size_bytes=2, number_of_components=4)
    SHORT8 =    OpenCLType(size_bytes=2, number_of_components=8)
    USHORT2 =   OpenCLType(size_bytes=2, number_of_components=2, is_signed=False)
    USHORT4 =   OpenCLType(size_bytes=2, number_of_components=4, is_signed=False)
    USHORT8 =   OpenCLType(size_bytes=2, number_of_components=8, is_signed=False)

    INT2 = OpenCLType(size_bytes=4, number_of_components=2)
    INT4 = OpenCLType(size_bytes=4, number_of_components=4)
    INT8 = OpenCLType(size_bytes=4, number_of_components=8)
    UINT2 = OpenCLType(size_bytes=4, number_of_components=2, is_signed=False)
    UINT4 = OpenCLType(size_bytes=4, number_of_components=4, is_signed=False)
    UINT8 = OpenCLType(size_bytes=4, number_of_components=8, is_signed=False)

    LONG2 = OpenCLType(size_bytes=8, number_of_components=2)
    LONG4 = OpenCLType(size_bytes=8, number_of_components=4)
    LONG8 = OpenCLType(size_bytes=8, number_of_components=8)
    ULONG2 = OpenCLType(size_bytes=8, number_of_components=2, is_signed=False)
    ULONG4 = OpenCLType(size_bytes=8, number_of_components=4, is_signed=False)
    ULONG8 = OpenCLType(size_bytes=8, number_of_components=8, is_signed=False)
    
    HALF2 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=2)
    HALF4 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=4)
    HALF8 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=8)

    FLOAT2 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=2)
    FLOAT4 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=4)
    FLOAT8 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=8)

    DOUBLE2 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=2)
    DOUBLE4 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=4)
    DOUBLE8 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=8)

    # Global Types
    GLOBAL_CHAR = OpenCLType(size_bytes=1, is_global=True)
    GLOBAL_UCHAR = OpenCLType(size_bytes=1, is_signed=False, is_global=True)
    GLOBAL_SHORT = OpenCLType(size_bytes=2, is_global=True)
    GLOBAL_USHORT = OpenCLType(size_bytes=2, is_signed=False, is_global=True)
    GLOBAL_INT = OpenCLType(size_bytes=4, is_global=True)
    GLOBAL_UINT = OpenCLType(size_bytes=4, is_signed=False, is_global=True)
    GLOBAL_LONG = OpenCLType(size_bytes=8, is_global=True)
    GLOBAL_ULONG = OpenCLType(size_bytes=8, is_signed=False, is_global=True)
    GLOBAL_HALF = OpenCLType(size_bytes=2, is_integer=False, is_global=True)
    GLOBAL_FLOAT = OpenCLType(size_bytes=4, is_integer=False, is_global=True)
    GLOBAL_DOUBLE = OpenCLType(size_bytes=8, is_integer=False, is_global=True)
    GLOBAL_CHAR2 = OpenCLType(number_of_components=2, is_global=True)
    GLOBAL_CHAR4 = OpenCLType(number_of_components=4, is_global=True)
    GLOBAL_CHAR8 = OpenCLType(number_of_components=8, is_global=True)
    GLOBAL_UCHAR2 = OpenCLType(number_of_components=2, is_signed=False, is_global=True)
    GLOBAL_UCHAR4 = OpenCLType(number_of_components=4, is_signed=False, is_global=True)
    GLOBAL_UCHAR8 = OpenCLType(number_of_components=8, is_signed=False, is_global=True)
    GLOBAL_SHORT2 = OpenCLType(size_bytes=2, number_of_components=2, is_global=True)
    GLOBAL_SHORT4 = OpenCLType(size_bytes=2, number_of_components=4, is_global=True)
    GLOBAL_SHORT8 = OpenCLType(size_bytes=2, number_of_components=8, is_global=True)
    GLOBAL_USHORT2 = OpenCLType(size_bytes=2, number_of_components=2, is_signed=False, is_global=True)
    GLOBAL_USHORT4 = OpenCLType(size_bytes=2, number_of_components=4, is_signed=False, is_global=True)
    GLOBAL_USHORT8 = OpenCLType(size_bytes=2, number_of_components=8, is_signed=False, is_global=True)
    GLOBAL_INT2 = OpenCLType(size_bytes=4, number_of_components=2, is_global=True)
    GLOBAL_INT4 = OpenCLType(size_bytes=4, number_of_components=4, is_global=True)
    GLOBAL_INT8 = OpenCLType(size_bytes=4, number_of_components=8, is_global=True)
    GLOBAL_UINT2 = OpenCLType(size_bytes=4, number_of_components=2, is_signed=False, is_global=True)
    GLOBAL_UINT4 = OpenCLType(size_bytes=4, number_of_components=4, is_signed=False, is_global=True)
    GLOBAL_UINT8 = OpenCLType(size_bytes=4, number_of_components=8, is_signed=False, is_global=True)
    GLOBAL_LONG2 = OpenCLType(size_bytes=8, number_of_components=2, is_global=True)
    GLOBAL_LONG4 = OpenCLType(size_bytes=8, number_of_components=4, is_global=True)
    GLOBAL_LONG8 = OpenCLType(size_bytes=8, number_of_components=8, is_global=True)
    GLOBAL_ULONG2 = OpenCLType(size_bytes=8, number_of_components=2, is_signed=False, is_global=True)
    GLOBAL_ULONG4 = OpenCLType(size_bytes=8, number_of_components=4, is_signed=False, is_global=True)
    GLOBAL_ULONG8 = OpenCLType(size_bytes=8, number_of_components=8, is_signed=False, is_global=True)
    GLOBAL_HALF2 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=2, is_global=True)
    GLOBAL_HALF4 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=4, is_global=True)
    GLOBAL_HALF8 = OpenCLType(size_bytes=2, is_integer=False, number_of_components=8, is_global=True)
    GLOBAL_FLOAT2 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=2, is_global=True)
    GLOBAL_FLOAT4 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=4, is_global=True)
    GLOBAL_FLOAT8 = OpenCLType(size_bytes=4, is_integer=False, number_of_components=8, is_global=True)
    GLOBAL_DOUBLE2 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=2, is_global=True)
    GLOBAL_DOUBLE4 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=4, is_global=True)
    GLOBAL_DOUBLE8 = OpenCLType(size_bytes=8, is_integer=False, number_of_components=8, is_global=True)

def make_opencl_type_from_asm_type(asm_type : ASMTypes) -> OpenCLTypes:
    for t in OpenCLTypes:
        if t.value == asm_type.value:
            return t
    return OpenCLTypes.UNKNOWN

def make_opencl_type(type_hint) -> OpenCLTypes:
    if isinstance(type_hint, OpenCLTypes):
        return type_hint
    
    if not isinstance(type_hint, str):
        return OpenCLTypes.UNKNOWN
    
    opencl_type = OpenCLTypes.from_string(type_hint)
    if opencl_type == OpenCLTypes.UNKNOWN:
        asm_type = ASMTypes.from_string(type_hint)
        if asm_type != ASMTypes.UNKNOWN:
            opencl_type = make_opencl_type_from_asm_type(asm_type)

    return opencl_type