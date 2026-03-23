from src.ir.registers.reg import Reg64, RegOrVal_ty
from src.ir.instructions.generic import GenericInstruction

class Store(GenericInstruction):
    def __init__(self, address: Reg64, value: RegOrVal_ty, is_scalar, size):
        super().__init__("store", address, value, is_scalar=is_scalar)
        self.address = address
        self.value = value
        self.size = size

    def _get_normalize_opcode(self) -> str:
        prefix = "s_store" if self.is_scalar() else "flat_store"
        if self.size == 8:
            return f"{prefix}_byte"
        elif self.size == 32:
            return f"{prefix}_dword"
        elif self.size == 64:
            return f"{prefix}_dwordx2"
        else:
            return f"{prefix}_dwordx4"
        

class Store8(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty, is_scalar):
        super().__init__(address, value, is_scalar=is_scalar, size=8)

class Store32(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty, is_scalar):
        super().__init__(address, value, is_scalar=is_scalar, size=32)

class Store64(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty, is_scalar):
        super().__init__(address, value, is_scalar=is_scalar, size=64)

class Store128(Store):
    def __init__(self, address: Reg64, value: RegOrVal_ty, is_scalar):
        super().__init__(address, value, is_scalar=is_scalar, size=128)
