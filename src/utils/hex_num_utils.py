import re
import struct


def is_hex_num(src: str) -> bool:
    return re.fullmatch(r'0x[0-9a-fA-F]+', src) is not None


def hex_to_dec_with_sign(hex_num_str: str, size: int = 32) -> str:
    assert is_hex_num(hex_num_str)
    bin_num_str = bin(int(hex_num_str, 16))[2:]
    extension_bit = bin_num_str[0]
    extension_size = size - len(bin_num_str)
    bin_num_str = '0b' + extension_bit * extension_size + bin_num_str
    hex_num_str = hex(int(bin_num_str, 2))[2:]
    return str(struct.unpack('>i', bytes.fromhex(hex_num_str))[0])
