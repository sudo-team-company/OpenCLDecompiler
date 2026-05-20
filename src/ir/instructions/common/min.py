from src.instructions.sop2.s_min import SMin
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType


class IRMin(GenericInstruction):
    allowed_types = (IRType.I32,)

    def __init__(self, dst, src0, src1, op_type: IRType):
        super().__init__("min", dst, src0, src1, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        return "s_min_i32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SMin,
            self._get_normalize_opcode(),
            self.operands,
            "i32",
        )
