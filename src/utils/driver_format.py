from enum import Enum


class DriverFormat(Enum):
    AMDCL2 = '.amdcl2'
    ROCM = '.rocm'
    AMDGPU_DIS = 'amdgpu-dis'
    UNKNOWN = None

    @classmethod
    def _missing_(cls, value):
        if isinstance(value, list):
            if (res := DriverFormat(value[1])) != DriverFormat.UNKNOWN:
                return res
            if '\t.amdgpu_pal_metadata' in value:
                return DriverFormat.AMDGPU_DIS
        return DriverFormat.UNKNOWN
