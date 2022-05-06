from . import amdcl2_parser, rocm_parser, unknown_parser
from ..utils import DriverFormat

parsers = {
    DriverFormat.AMDCL2: amdcl2_parser,
    DriverFormat.ROCM: rocm_parser,
    DriverFormat.UNKNOWN: unknown_parser,
}


def parse_kernel(text):
    driver_format = DriverFormat(text)
    return driver_format, parsers[driver_format].parse_kernel(text)
