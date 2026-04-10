from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.reg import Val
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER

class Barrier(GenericInstruction):
    def __init__(self, value: Val, is_scalar: bool):
        super().__init__("bar", value, is_scalar=is_scalar)
        self.value = value
   
    def _get_normalize_opcode(self) -> str:
        return "s_waitcnt"
    
    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        normalized = [manager.map(op) for op in self.operands]
        return [[self._get_normalize_opcode(), f'lgkmcnt({self.value.value})']]
