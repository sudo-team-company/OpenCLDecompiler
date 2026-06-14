from src.instructions.sopp.s_endpgm import SEndpgm
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext


class EndPgm(GenericInstruction):
    def __init__(self):
        super().__init__("endpgm")

    def _get_normalize_opcode(self) -> str:
        return "s_endpgm"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SEndpgm,
            self._get_normalize_opcode(),
            self.operands,
        )
