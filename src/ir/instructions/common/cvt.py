from src.instructions.sop1.s_mov import SMov
from src.instructions.sop2.s_and import SAnd
from src.instructions.vop1.v_cvt import VCvt
from src.instructions.vop2.v_ashrrev import VAshrrev
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Reg64, Reg_ty, RegOrVal_ty, Val, get_reg_rang


class Cvt32To64(GenericInstruction):
    allowed_types = (IRType.U64_U32, IRType.I64_I32)

    def __init__(self, destination: Reg64, operand1: RegOrVal_ty, op_type: IRType):
        super().__init__("cvt32to64", destination, operand1, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        dest_lo, dest_hi = get_reg_rang(self.destination)
        ctx.emit_backend(
            SMov,
            "s_mov_b32",
            [dest_lo, self.operand1],
            "b32",
        )

        if self.op_type == IRType.I64_I32:
            return ctx.emit_backend(
                VAshrrev,
                "v_ashrrev_i32",
                [dest_hi, Val("31"), self.operand1],
                "i32",
            )

        return ctx.emit_backend(
            SMov,
            "s_mov_b32",
            [dest_hi, Val("0")],
            "b32",
        )


class Cvt16To32(GenericInstruction):
    allowed_types = (IRType.U32_U16, IRType.I32_I16, IRType.U16_U32)

    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, op_type: IRType):
        super().__init__("cvt16to32", destination, operand1, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            SAnd,
            "s_and_b32",
            [self.destination, Val("0xffff"), self.operand1],
            "b32",
        )


class Cvt64To32(GenericInstruction):
    allowed_types = (IRType.U32_U64,)

    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, op_type: IRType):
        super().__init__("cvt64to32", destination, operand1, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            SMov,
            "s_mov_b32",
            [self.destination, self.operand1.get_element(0)],
            "b32",
        )


class CvtF32ToI32(GenericInstruction):
    allowed_types = (IRType.I32_F32,)

    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, op_type: IRType):
        super().__init__("cvt_f32_to_i32", destination, operand1, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1

    def _get_normalize_opcode(self) -> str:
        return "v_cvt_i32_f32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VCvt,
            self._get_normalize_opcode(),
            self.operands,
            "i32_f32",
        )


class CvtF64ToI32(GenericInstruction):
    allowed_types = (IRType.I32_F64,)

    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, op_type: IRType):
        super().__init__("cvt_f64_to_i32", destination, operand1, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1

    def _get_normalize_opcode(self) -> str:
        return "v_cvt_i32_f64"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VCvt,
            self._get_normalize_opcode(),
            self.operands,
            "i32_f64",
        )


class CvtI32ToF32(GenericInstruction):
    allowed_types = (IRType.F32_I32,)

    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, op_type: IRType):
        super().__init__("cvt_i32_to_f32", destination, operand1, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1

    def _get_normalize_opcode(self) -> str:
        return "v_cvt_f32_i32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VCvt,
            self._get_normalize_opcode(),
            self.operands,
            "f32_i32",
        )


class CvtU32ToF64(GenericInstruction):
    allowed_types = (IRType.F64_U32,)

    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, op_type: IRType):
        super().__init__("cvt_u32_to_f64", destination, operand1, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1

    def _get_normalize_opcode(self) -> str:
        return "v_cvt_f64_u32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VCvt,
            self._get_normalize_opcode(),
            self.operands,
            "f64_u32",
        )


class CvtI32ToF64(GenericInstruction):
    allowed_types = (IRType.F64_I32,)

    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, op_type: IRType):
        super().__init__("cvt_i32_to_f64", destination, operand1, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1

    def _get_normalize_opcode(self) -> str:
        return "v_cvt_f64_i32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VCvt,
            self._get_normalize_opcode(),
            self.operands,
            "f64_i32",
        )
