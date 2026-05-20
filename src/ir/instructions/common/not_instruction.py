from src.instructions.sop1.s_not import SNot
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import PredReg


class Not(GenericInstruction):
    allowed_types = (IRType.PRED, IRType.I32, IRType.B32, IRType.B64)

    def __init__(self, destination: PredReg, source: PredReg, op_type: IRType):
        super().__init__("not", destination, source, op_type=op_type)
        self.destination = destination
        self.source = source

    def _get_normalize_opcode(self) -> str:
        return "s_not_b64"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SNot,
            self._get_normalize_opcode(),
            self.operands,
            "b64",
        )
