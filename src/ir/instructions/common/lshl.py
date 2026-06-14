from src.instructions.vop2.v_ashrrev import VAshrrev
from src.instructions.vop2.v_lshlrev import VLshlrev
from src.instructions.vop2.v_lshrrev import VLshrrev
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Reg_ty, RegOrVal_ty

QWORD_BITS = 64


class ShiftInstruction(GenericInstruction):
    allowed_types = (IRType.B16, IRType.B32, IRType.B64, IRType.I32, IRType.I64)

    def __init__(
        self,
        name: str,
        destination: Reg_ty,
        operand1: Reg_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__(name, destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == QWORD_BITS

    def get_suffix(self):
        if self._is_64bit():
            return "b64"
        return "b32"


class LShlRev(ShiftInstruction):
    def __init__(
        self,
        destination: Reg_ty,
        operand1: Reg_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("lshl", destination, operand1, operand2, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        if self._is_64bit():
            return "v_lshlrev_b64"
        return "v_lshlrev_b32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VLshlrev,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )


class LShrRev(ShiftInstruction):
    def __init__(
        self,
        destination: Reg_ty,
        operand1: Reg_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("rshl", destination, operand1, operand2, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        if self._is_64bit():
            return "v_lshrrev_b64"
        return "v_lshrrev_b32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VLshrrev,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )


class AShrRev(ShiftInstruction):
    allowed_types = (IRType.I32, IRType.I64)

    def __init__(
        self,
        destination: Reg_ty,
        operand1: Reg_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("rshl", destination, operand1, operand2, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        if self._is_64bit():
            return "v_ashrrev_i64"
        return "v_ashrrev_i32"

    def get_suffix(self):
        if self._is_64bit():
            return "i64"
        return "i32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VAshrrev,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )


class LShl(LShlRev):
    def __init__(
        self,
        destination: Reg_ty,
        operand1: Reg_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__(destination, operand2, operand1, op_type=op_type)


class LShr(LShrRev):
    def __init__(
        self,
        destination: Reg_ty,
        operand1: Reg_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__(destination, operand2, operand1, op_type=op_type)


class AShr(AShrRev):
    def __init__(
        self,
        destination: Reg_ty,
        operand1: Reg_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__(destination, operand2, operand1, op_type=op_type)
