from src.instructions.sopp.s_nop import SNop
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext


class Ignore(GenericInstruction):
    def __init__(self, *_operands):
        super().__init__("s_nop")

    def to_text(self) -> str:
        return ""

    def get_parts(self) -> list[list[str]]:
        return []

    def get_operands(self):
        return []

    def _get_normalize_opcode(self):
        return "s_nop"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SNop,
            self._get_normalize_opcode(),
            self.operands,
        )
