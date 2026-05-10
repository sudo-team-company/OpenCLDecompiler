from src.ir.registers.reg import Reg_ty, RegOrVal_ty
from src.ir.instructions.generic import GenericInstruction

from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.sop1.s_mov import SMov


class Mov(GenericInstruction):
    def __init__(self, destination: Reg_ty, source: RegOrVal_ty, is_scalar):
        super().__init__("mov", destination, source, is_scalar=is_scalar)
        self.destination = destination
        self.source = source

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64

    def _get_normalize_opcode(self) -> str:
        return "s_mov_b64" if self._is_64bit() else "s_mov_b32"
        
    def get_suffix(self):
        if self._is_64bit():
            return "b64"
        return "b32"

    def to_fill_node(self, state, parents):
        # NOTE забавный факт, если разбивать mov64 на mov32 x2 то тесты sub показывают более правильный результат(вместо "a + -1" будет "a - 1")
        return NodeLoweringContext(state, parents).emit_backend(
            SMov,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )
