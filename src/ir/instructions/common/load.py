from src.ir.registers.reg import Reg64, Reg_ty, Val
from src.ir.instructions.generic import GenericInstruction
from src.register import check_and_split_regs
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER

class Load(GenericInstruction):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val, is_scalar, size):
        super().__init__("load", destination, address, offset, is_scalar=is_scalar)
        self.destination = destination
        self.address = address
        self.offset = offset
        self.size = size

    def _get_normalize_opcode(self) -> str:
        prefix = "s_load"

        if self.size<= 32:
            return f"{prefix}_dword"
        elif self.size <= 64:
            return f"{prefix}_dwordx2"
        else:
            return f"{prefix}_dwordx4"

    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        result = []
        opcode = self._get_normalize_opcode()
        dest_str = manager.map(self.destination)
        addr_str = manager.map(self.address)
        offset_str = manager.map(self.offset)

        start, end = check_and_split_regs(dest_str)
        start, end = int(start[1:]), int(end[1:])
        all_parts = [f"s{i}" for i in range(start, end + 1)]
        total_parts = len(all_parts)
        
        parts_to_load = (self.size) // 32
        
        if total_parts > parts_to_load:
            for i in range(parts_to_load, total_parts):
                result.append(["v_mov_b32", all_parts[i], "0"])
        
        result.append([opcode, dest_str, addr_str, offset_str])
        return result
    

class Load32(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val, is_scalar):
        super().__init__(destination, address, offset, is_scalar=is_scalar, size=32)

class Load64(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val, is_scalar):
        super().__init__(destination, address, offset, is_scalar=is_scalar, size=64)

class Load128(Load):
    def __init__(self, destination: Reg_ty, address: Reg64, offset: Val, is_scalar):
        super().__init__(destination, address, offset, is_scalar=is_scalar, size=128)
