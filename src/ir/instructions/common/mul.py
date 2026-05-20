from src.instructions.vop2.v_add import VAdd
from src.instructions.vop2.v_mac import VMac
from src.instructions.vop2.v_mul_f32 import VMulF32
from src.instructions.vop3.v_mad import VMad
from src.instructions.vop3.v_mul_lo import VMulHi, VMulLo
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Reg32, Reg_ty, RegOrVal_ty, Val, get_reg_rang


class Mul24(GenericInstruction):
    allowed_types = (IRType.U32, IRType.I32)

    def __init__(
        self,
        destination: Reg32,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("mul", destination, operand1, operand2, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        return "v_mul_i32_i24"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VMulF32,
            "v_mul_i32_i24",
            self.operands,
            "i32_i24",
        )


class MulF(GenericInstruction):
    allowed_types = (IRType.F32,)

    def __init__(
        self,
        destination: Reg32,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("mul", destination, operand1, operand2, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        return "v_mul_f32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VMulF32,
            self._get_normalize_opcode(),
            self.operands,
            "f32",
        )


class MacF32(GenericInstruction):
    allowed_types = (IRType.F32,)

    def __init__(
        self,
        destination: Reg32,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("mac_f", destination, operand1, operand2, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        return "v_mac_f32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VMac,
            self._get_normalize_opcode(),
            self.operands,
            "f32",
        )


class MulLo(GenericInstruction):
    allowed_types = (IRType.U16, IRType.I16, IRType.U32, IRType.I32, IRType.U64, IRType.I64)

    def __init__(
        self,
        destination: Reg_ty,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("mul", destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2

    def _is_64bit(self) -> bool:
        return self.op_type in (IRType.U64, IRType.I64)

    def _get_normalize_opcode(self) -> str:
        return "v_mul_lo_i32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        if not self._is_64bit():
            return ctx.emit_backend(
                VMulLo,
                self._get_normalize_opcode(),
                self.operands,
                "u32",
            )

        dest_lo, dest_hi = get_reg_rang(self.destination)
        op1_lo, op1_hi = get_reg_rang(self.operand1)
        op2_lo, op2_hi = get_reg_rang(self.operand2)
        ctx.emit_backend(VMulHi, "v_mul_hi_u32", [dest_lo, op1_lo, op2_lo], "u32")
        ctx.emit_backend(VMulLo, "v_mul_lo_u32", [dest_hi, op1_lo, op2_hi], "u32")
        ctx.emit_backend(VAdd, "v_add_u32", [dest_hi, dest_hi, dest_lo], "u32")
        ctx.emit_backend(VMulLo, "v_mul_lo_u32", [dest_lo, op1_hi, op2_lo], "u32")
        ctx.emit_backend(VAdd, "v_add_u32", [dest_hi, dest_hi, dest_lo], "u32")
        return ctx.emit_backend(VMulLo, "v_mul_lo_u32", [dest_lo, op1_lo, op2_lo], "u32")


class MulHi(GenericInstruction):
    allowed_types = (IRType.U32, IRType.I32)

    def __init__(
        self,
        destination: Reg32,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("mul_hi", destination, operand1, operand2, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        if self.op_type == IRType.I32:
            return "v_mul_hi_i32"
        return "s_mul_hi_u32"

    def get_suffix(self):
        if self.op_type == IRType.I32:
            return "i32"
        return "u32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VMulHi,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )


class MulWide(GenericInstruction):
    allowed_types = (IRType.U64_U32, IRType.I64_I32)

    def __init__(
        self,
        destination: Reg_ty,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("mul", destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2

    def _is_64bit(self) -> bool:
        return True

    def _get_normalize_opcode(self) -> str:
        if self.op_type == IRType.I64_I32:
            return "v_mad_i64_i32"
        return "v_mad_u64_u32"

    def get_suffix(self):
        if self.op_type == IRType.I64_I32:
            return "i64_i32"
        return "u64_u32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VMad,
            self._get_normalize_opcode(),
            [self.destination, Val("0"), self.operand1, self.operand2, Val("0")],
            self.get_suffix(),
        )
