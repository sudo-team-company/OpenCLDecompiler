from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.smem.s_load import SLoad
from src.instructions.flat.flat_load import FlatLoad

from src.ir.registers.reg import Reg64, Reg_ty, Val
from src.ir.instructions.generic import GenericInstruction

class Load(GenericInstruction):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val, is_scalar, size):
        self.destination = destination
        self.address = address
        self.offset = offset if offset != None else Val("0")
        super().__init__("load", self.destination, self.address, self.offset, is_scalar=is_scalar)
        self.size = size

    def _get_normalize_opcode(self) -> str:
        prefix = "s_load" if self.is_scalar() else "flat_load"

        if self.size<= 32:
            return f"{prefix}_dword"
        elif self.size <= 64:
            return f"{prefix}_dwordx2"
        else:
            return f"{prefix}_dwordx4"
        
    def _get_opcode(self):
        return SLoad if self.is_scalar() else FlatLoad

    def get_suffix(self):
        if self.size<= 32:
            return "dword"
        elif self.size <= 64:
            return "dwordx2"
        else:
            return "dwordx4"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            self._get_opcode(),
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )

                
class Load32(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None, is_scalar: bool = False):
        super().__init__(destination, address, offset, is_scalar=True, size=32)

class Load64(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None, is_scalar: bool = False):
        super().__init__(destination, address, offset, is_scalar=True, size=64)

class Load128(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None, is_scalar: bool = False):
        super().__init__(destination, address, offset, is_scalar=True, size=128)


class FLoad32(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None, is_scalar: bool = True):
        super().__init__(destination, address, offset, is_scalar=False, size=32)

class FLoad64(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None, is_scalar: bool = True):
        super().__init__(destination, address, offset, is_scalar=False, size=64)

class FLoad128(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val | None = None, is_scalar: bool = True):
        super().__init__(destination, address, offset, is_scalar=False, size=128)