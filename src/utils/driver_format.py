from enum import Enum


class DriverFormat(Enum):
    AMDCL2 = '.amdcl2'
    ROCM = '.rocm'
    UNKNOWN = None

    @classmethod
    def _missing_(cls, value):
        if isinstance(value, list):
            try:
                return DriverFormat(value[1])
            except ValueError:
                return DriverFormat.UNKNOWN
        return DriverFormat.UNKNOWN
