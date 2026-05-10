from src.ir.instructions.generic import GenericInstruction
from src.instructions.sopp.s_waitcnt import SWaitcnt
from src.ir.instructions.lowering import NodeLoweringContext


class Barrier(GenericInstruction):
    def __init__(self, is_scalar: bool):
        super().__init__("barrier", is_scalar=is_scalar)
   
    def _get_normalize_opcode(self) -> str:
        return "s_waitcnt"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SWaitcnt,
            self._get_normalize_opcode(),
            self.operands,
        )
