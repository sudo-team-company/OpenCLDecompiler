from src.decompiler_data import DecompilerData
from src.driver_format import DriverFormat
from . import amdcl2_parser, rocm_parser, unknown_parser

parsers = {
    DriverFormat.AMDCL2: amdcl2_parser,
    DriverFormat.ROCM: rocm_parser,
    DriverFormat.UNKNOWN: unknown_parser,
}


def parse_kernel(text):
    return parsers[DecompilerData().driver_format].parse_kernel(text)
