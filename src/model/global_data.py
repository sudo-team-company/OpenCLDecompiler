import struct
from typing import Union

class GlobalData:
    def __init__(self, raw_bytes: bytearray, addr: int):
        self.addr: int = addr
        self.raw_data: bytearray = raw_bytes

    def get_value(self, offset: int, size: int, type_hint: str) -> Union[int, float]:
        if offset + size > len(self.raw_data):
            raise IndexError(f"Offset {offset} with size {size} is out of bounds (len={len(self.raw_data)})")

        fmt = f"<{type_hint}"

        expected_size = struct.calcsize(fmt)
        if expected_size != size:
            raise ValueError(f"Size mismatch for type {type_hint}: expected {expected_size}, got {size}")

        return struct.unpack_from(fmt, self.raw_data, offset)[0]
    
    def __repr__(self):
        return f"raw_bytes=bytearray(b'{self.raw_data.hex()}'), addr={self.addr}"