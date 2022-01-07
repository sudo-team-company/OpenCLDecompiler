from src.decompiler_data import DecompilerData as _DecompilerData
from src.driver_format import DriverFormat as _DriverFormat
from . import _amdcl2_parser, _rocm_parser, _unknown_parser

__all__ = ["parse_kernel"]

_kernel_parsers = {
    _DriverFormat.AMDCL2: _amdcl2_parser,
    _DriverFormat.ROCM: _rocm_parser,
    _DriverFormat.UNKNOWN: _unknown_parser,
}


def parse_kernel(text):
    decompiler_data = _DecompilerData()
    return _kernel_parsers[decompiler_data.driver_format].parse_kernel(text)
