from src.instructions.vop2.v_cndmask import VCndmask
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType


class CSelect(GenericInstruction):
    allowed_types = (IRType.B32, IRType.B64, IRType.PRED)

    def __init__(self, dst, src0, src1, cond, op_type: IRType):
        super().__init__("cselect", dst, src0, src1, cond, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        return "v_cndmask_b32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VCndmask,
            self._get_normalize_opcode(),
            self.operands,
            "b32",
        )
