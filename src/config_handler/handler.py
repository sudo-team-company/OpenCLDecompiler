from typing import List

from src.decompiler_data import DecompilerData
from src.driver_format import DriverFormat
from src.utils.config_data import ConfigData
from . import amdcl2_handler, rocm_handler, unknown_handler

handlers = {
    DriverFormat.AMDCL2: amdcl2_handler,
    DriverFormat.ROCM: rocm_handler,
    DriverFormat.UNKNOWN: unknown_handler,
}


def process_config(set_of_config: List[str]) -> ConfigData:
    decompiler_data = DecompilerData()
    return handlers[decompiler_data.driver_format].process_config(set_of_config)
