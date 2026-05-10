from src.ir.instructions.generic import GenericInstruction

from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.vop2.v_cndmask import VCndmask

class CSelect(GenericInstruction):
    def __init__(self, dst, src0, src1, cond,  is_scalar: bool):
        super().__init__("cselect", dst, src0, src1, cond, is_scalar=is_scalar)
   
    def _get_normalize_opcode(self) -> str:
        return "v_cndmask_b32"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VCndmask,
            self._get_normalize_opcode(),
            self.operands,
            "b32",
        )