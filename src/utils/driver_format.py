from enum import Enum


class DriverFormat(Enum):
    AMDCL2 = '.amdcl2'
    ROCM = '.rocm'
    AMDGPU_DIS = 'amdgpu-dis'
    UNKNOWN = None

    @classmethod
    def _missing_(cls, value):
        if isinstance(value, list):
            try:
                return DriverFormat(value[1])
            except ValueError:
                pass
            if '\t.amdgpu_pal_metadata' in value:
                return DriverFormat.AMDGPU_DIS
        return DriverFormat.UNKNOWN
