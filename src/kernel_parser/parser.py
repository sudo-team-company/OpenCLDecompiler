from . import amdcl2_parser, rocm_parser, amdgpu_dis_parser, unknown_parser
from ..utils import DriverFormat

parsers = {
    DriverFormat.AMDCL2: amdcl2_parser,
    DriverFormat.ROCM: rocm_parser,
    DriverFormat.AMDGPU_DIS: amdgpu_dis_parser,
    DriverFormat.UNKNOWN: unknown_parser,
}


def parse_gpu(text: list[str]) -> str | None:
    for row in text:
        if row.startswith(".gpu "):
            return row.removeprefix(".gpu ").strip().lower()
    return None


def parse_kernel(text):
    driver_format = DriverFormat(text)
    gpu = parse_gpu(text)
    return driver_format, parsers[driver_format].parse_kernel(text), gpu
