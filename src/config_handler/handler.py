from src.decompiler_data import DecompilerData
from src.driver_format import DriverFormat
from . import amdcl2_handler, rocm_handler, unknown_handler

handlers = {
    DriverFormat.AMDCL2: amdcl2_handler,
    DriverFormat.ROCM: rocm_handler,
    DriverFormat.UNKNOWN: unknown_handler,
}


def process_config(set_of_config, name_of_program):
    return handlers[DecompilerData().driver_format].process_config(set_of_config, name_of_program)
