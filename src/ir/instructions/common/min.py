from src.ir.instructions.generic import GenericInstruction

from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.sop2.s_min import SMin

class IRMin(GenericInstruction):
    def __init__(self, dst, src0, src1,  is_scalar: bool):
        super().__init__("min", dst, src0, src1, is_scalar=is_scalar)
   
    def _get_normalize_opcode(self) -> str:
        return "s_min_i32"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SMin,
            self._get_normalize_opcode(),
            self.operands,
            "i32",
        )