from src.instructions.vopc.v_cmp_eq import VCmpEq
from src.instructions.vopc.v_cmp_ge import VCmpGe
from src.instructions.vopc.v_cmp_gt import VCmpGt
from src.instructions.vopc.v_cmp_le import VCmpLe
from src.instructions.vopc.v_cmp_lt import VCmpLt
from src.instructions.vopc.v_cmp_ne import VCmpNe
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import PredReg, RegOrVal_ty


class BaseCompare(GenericInstruction):
    allowed_types = (IRType.U32, IRType.I32, IRType.U64, IRType.I64, IRType.F32, IRType.F64)

    operation: str
    backend_instruction: type

    def __init__(
        self,
        destination: PredReg,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__(f"cmp.{self.operation}", destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2

    def _get_normalize_opcode(self) -> str:
        return f"v_cmp_{self.operation}_i32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            self.backend_instruction, self._get_normalize_opcode(), self.operands, "i32"
        )


class CompareEq(BaseCompare):
    operation = "eq"
    backend_instruction = VCmpEq


class CompareNe(BaseCompare):
    operation = "ne"
    backend_instruction = VCmpNe


class CompareLt(BaseCompare):
    operation = "lt"
    backend_instruction = VCmpLt


class CompareLe(BaseCompare):
    operation = "le"
    backend_instruction = VCmpLe


class CompareGt(BaseCompare):
    operation = "gt"
    backend_instruction = VCmpGt


class CompareGe(BaseCompare):
    operation = "ge"
    backend_instruction = VCmpGe


_COMPARE_CLASSES = {
    "eq": CompareEq,
    "ne": CompareNe,
    "lg": CompareNe,
    "lt": CompareLt,
    "le": CompareLe,
    "gt": CompareGt,
    "ge": CompareGe,
}


def get_compare_class(comparison: str) -> type[BaseCompare]:
    return _COMPARE_CLASSES[comparison]
