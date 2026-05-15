from __future__ import annotations

from enum import Enum


class IRType(Enum):
    NONE = "none"
    PRED = "pred"

    B8 = "b8"
    B16 = "b16"
    B32 = "b32"
    B64 = "b64"
    B128 = "b128"

    U8 = "u8"
    U16 = "u16"
    U32 = "u32"
    U64 = "u64"

    I8 = "i8"
    I16 = "i16"
    I32 = "i32"
    I64 = "i64"

    F16 = "f16"
    F32 = "f32"
    F64 = "f64"

    I64_I32 = "i64_i32"
    U64_U32 = "u64_u32"
    I32_F32 = "i32_f32"
    F64_U32 = "f64_u32"
    U32_U64 = "u32_u64"
    U32_U16 = "u32_u16"
    I32_I16 = "i32_i16"
    U16_U32 = "u16_u32"

    @property
    def suffix(self) -> str:
        return self.value

    @property
    def bits(self) -> int:
        if self in (IRType.NONE, IRType.PRED):
            return 0

        head = self.value.split("_", maxsplit=1)[0]
        return int(head[1:])

    @property
    def is_float(self) -> bool:
        return self.value.startswith("f")

    @property
    def is_bit_type(self) -> bool:
        return self.value.startswith("b")

    @property
    def is_compound(self) -> bool:
        return "_" in self.value

    def memory_suffix(self) -> str:
        return memory_suffix_for_bits(self.bits)


_BIT_TYPES_BY_BITS = {
    8: IRType.B8,
    16: IRType.B16,
    32: IRType.B32,
    64: IRType.B64,
    128: IRType.B128,
}

_MEMORY_SUFFIX_BY_BITS = {
    8: "byte",
    16: "short",
    32: "dword",
    64: "dwordx2",
    128: "dwordx4",
}


def bit_type_for_bits(bits: int) -> IRType:
    try:
        return _BIT_TYPES_BY_BITS[bits]
    except KeyError as exc:
        raise ValueError(f"Unsupported bit operation width: {bits}") from exc


def memory_suffix_for_bits(bits: int) -> str:
    try:
        return _MEMORY_SUFFIX_BY_BITS[bits]
    except KeyError as exc:
        raise ValueError(f"Unsupported memory operation width: {bits}") from exc


BIT_TYPES = tuple(_BIT_TYPES_BY_BITS.values())
INTEGER_TYPES = (IRType.I8, IRType.I16, IRType.I32, IRType.I64, IRType.U8, IRType.U16, IRType.U32, IRType.U64)
MEMORY_VALUE_TYPES = BIT_TYPES + INTEGER_TYPES + (IRType.F16, IRType.F32, IRType.F64)
