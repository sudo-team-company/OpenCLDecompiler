from src.instructions.sop1.s_mov import SMov
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Reg_ty, RegOrVal_ty

QWORD_BITS = 64


class Mov(GenericInstruction):
    allowed_types = (
        IRType.B16,
        IRType.B32,
        IRType.B64,
        IRType.U16,
        IRType.U32,
        IRType.U64,
        IRType.I32,
        IRType.I64,
        IRType.F32,
        IRType.F64,
        IRType.PRED,
    )

    def __init__(self, destination: Reg_ty, source: RegOrVal_ty, op_type: IRType):
        super().__init__("mov", destination, source, op_type=op_type)
        self.destination = destination
        self.source = source

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == QWORD_BITS

    def _get_normalize_opcode(self) -> str:
        return "s_mov_b64" if self._is_64bit() else "s_mov_b32"

    def get_suffix(self):
        if self._is_64bit():
            return "b64"
        return "b32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SMov,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )
