from src.ir.asm_to_ir.lowering import (
    OP_TYPE_UNSET,
    Emit,
    InstructionContext,
    OperationTypeArg,
    Rule,
    op,
    same,
    tmp64,
)
from src.ir.instructions.common.add import Add, AddC
from src.ir.instructions.common.barrier import Barrier
from src.ir.instructions.common.bfe import Bfe
from src.ir.instructions.common.compare import get_compare_class
from src.ir.instructions.common.cselect import CSelect
from src.ir.instructions.common.cvt import Cvt32To64, CvtF32ToI32, CvtF64ToI32, CvtI32ToF32, CvtI32ToF64, CvtU32ToF64
from src.ir.instructions.common.endpgm import EndPgm
from src.ir.instructions.common.load import FLoad, Load
from src.ir.instructions.common.logical import And, Or, Xor
from src.ir.instructions.common.lshl import AShr, AShrRev, LShl, LShlRev, LShr, LShrRev
from src.ir.instructions.common.mad import Mad
from src.ir.instructions.common.min import IRMin
from src.ir.instructions.common.mov import Mov
from src.ir.instructions.common.mul import MacF32, Mul24, MulF, MulHi, MulLo
from src.ir.instructions.common.permute import Permute32
from src.ir.instructions.common.store import FStore, Store
from src.ir.instructions.common.sub import Sub, SubRev
from src.ir.instructions.control_flow import Branch, BranchNot, Jump, Label
from src.ir.instructions.ignore import Ignore
from src.ir.instructions.special.local_memory import LocalAdd, LocalLoad, LocalStore
from src.ir.instructions.special.mask import ChangeMask
from src.ir.instructions.types import IRType
from src.ir.registers.reg import PredReg, Val

LOGICAL_INSTRUCTIONS = {
    "and": And,
    "or": Or,
    "xor": Xor,
}

EXPLICIT_VCC_OPERAND_COUNT = 4

_AMD_TYPE_BY_SUFFIX = {
    "b32": IRType.B32,
    "b64": IRType.B64,
    "u32": IRType.U32,
    "u64": IRType.U64,
    "i32": IRType.I32,
    "i64": IRType.I64,
    "f32": IRType.F32,
    "f64": IRType.F64,
}


def _ignore_explicit_vcc(instruction_class: type, op_type: OperationTypeArg = OP_TYPE_UNSET) -> Rule:
    def emit(ctx: InstructionContext) -> None:
        if len(ctx.operands) >= EXPLICIT_VCC_OPERAND_COUNT and ctx.operands[1].name == "vcc":
            ctx.emit(instruction_class, ctx.operands[0], ctx.operands[2], ctx.operands[3], op_type=op_type)
            return

        ctx.emit(instruction_class, *ctx.operands, op_type=op_type)

    return Rule.dynamic(emit)


def _writes_exec(ctx: InstructionContext) -> bool:
    return bool(ctx.operands) and ctx.operand(0).name == "exec"


def _same_with_exec_mask(instruction_class: type, op_type: OperationTypeArg = OP_TYPE_UNSET) -> Rule:
    def emit(ctx: InstructionContext) -> None:
        ctx.emit(instruction_class, *ctx.operands, op_type=op_type)
        if _writes_exec(ctx):
            ctx.emit(ChangeMask, PredReg("exec"))

    return Rule.dynamic(emit)


def get_instruction_rule(opcode: str) -> Rule | None:
    if opcode.startswith("."):
        return _label(opcode)

    if opcode.startswith("s_cmp_"):
        return _compare_rule(opcode, PredReg("scc"))

    if opcode.startswith("v_cmpx_"):
        return _compare_rule(opcode, PredReg("exec"))

    if opcode.startswith("v_cmp_"):
        return _vector_compare_rule(opcode)

    return instruction_rules.get(opcode)


def _parse_compare_opcode(opcode: str) -> str:
    comparison = opcode.split("_")[2]
    if not comparison:
        raise NotImplementedError(opcode)
    return comparison


def _parse_compare_type(opcode: str) -> IRType:
    return _AMD_TYPE_BY_SUFFIX.get(opcode.split("_")[-1], IRType.I32)


def _label(opcode: str) -> Rule:
    def emit(ctx: InstructionContext) -> None:
        ctx.emit(
            Label,
            Val(opcode[:-1]),
        )

    return Rule.dynamic(emit)


def _compare_rule(opcode: str, destination: PredReg) -> Rule:
    comparison = _parse_compare_opcode(opcode)
    op_type = _parse_compare_type(opcode)
    compare_class = get_compare_class(comparison)

    def emit(ctx: InstructionContext) -> None:
        ctx.emit(
            compare_class,
            destination,
            ctx.operand(0),
            ctx.operand(1),
            op_type=op_type,
        )
        if destination.name == "exec":
            ctx.emit(ChangeMask, PredReg("exec"))

    return Rule.dynamic(emit)


def _vector_compare_rule(opcode: str) -> Rule:
    comparison = _parse_compare_opcode(opcode)
    op_type = _parse_compare_type(opcode)
    compare_class = get_compare_class(comparison)

    def emit(ctx: InstructionContext) -> None:
        ctx.emit(
            compare_class,
            ctx.operand(0),
            ctx.operand(1),
            ctx.operand(2),
            op_type=op_type,
        )

    return Rule.dynamic(emit)


def _branch(predicate: PredReg) -> Rule:
    def emit(ctx: InstructionContext) -> None:
        ctx.emit(
            Branch,
            predicate,
            Val(ctx.operand(0).name),
        )

    return Rule.dynamic(emit)


def _branch_not(predicate: PredReg) -> Rule:
    def emit(ctx: InstructionContext) -> None:
        ctx.emit(
            BranchNot,
            predicate,
            Val(ctx.operand(0).name),
        )

    return Rule.dynamic(emit)


def _saveexec(operation, op_type: IRType = IRType.B64) -> Rule:
    return Rule(
        [
            Emit(Mov, op(0), PredReg("exec"), op_type=IRType.PRED),
            Emit(operation, PredReg("exec"), PredReg("exec"), op(1), op_type=op_type),
            Emit(ChangeMask, PredReg("exec")),
        ]
    )


def _scalar_cselect_b64() -> Rule:
    def replace_exec(operand):
        return Val("1") if operand.name == "exec" else operand

    def emit(ctx: InstructionContext) -> None:
        ctx.emit(
            CSelect,
            ctx.operand(0),
            replace_exec(ctx.operand(2)),
            replace_exec(ctx.operand(1)),
            PredReg("scc"),
            op_type=IRType.B64,
        )

    return Rule.dynamic(emit)


_local_store_like = Rule(
    [
        Emit(Mov, tmp64("base"), op(2), op_type=IRType.B64),
        Emit(Cvt32To64, tmp64("index"), op(0), op_type=IRType.U64_U32),
        Emit(Add, tmp64("address"), tmp64("base"), tmp64("index"), op_type=IRType.U64),
        Emit(LocalStore, tmp64("address"), op(1), op_type=IRType.B32),
    ]
)

_local_add_like = Rule(
    [
        Emit(Mov, tmp64("base"), op(2), op_type=IRType.B64),
        Emit(Cvt32To64, tmp64("index"), op(0), op_type=IRType.U64_U32),
        Emit(Add, tmp64("address"), tmp64("base"), tmp64("index"), op_type=IRType.U64),
        Emit(LocalAdd, tmp64("address"), op(1), op_type=IRType.U32),
    ]
)

_local_load = Rule(
    [
        Emit(Mov, tmp64("base"), op(2), op_type=IRType.B64),
        Emit(Cvt32To64, tmp64("index"), op(1), op_type=IRType.U64_U32),
        Emit(Add, tmp64("address"), tmp64("base"), tmp64("index"), op_type=IRType.U64),
        Emit(LocalLoad, op(0), tmp64("address"), op_type=IRType.B32),
    ]
)


instruction_rules = {
    "s_branch": same(Jump),
    "s_cbranch_scc0": _branch_not(PredReg("scc")),
    "s_cbranch_scc1": _branch(PredReg("scc")),
    "s_cbranch_execz": Rule([Emit(Ignore)]),
    "s_cbranch_execnz": Rule([Emit(Ignore)]),
    "s_cbranch_vccz": _branch_not(PredReg("vcc")),
    "s_cbranch_vccnz": _branch(PredReg("vcc")),
    "s_and_saveexec_b64": _saveexec(And),
    "s_or_saveexec_b64": _saveexec(Or),
    "s_xor_saveexec_b64": _saveexec(Xor),
    "s_andn2_saveexec_b64": _saveexec(Xor),
    "v_add_u32": _ignore_explicit_vcc(Add, IRType.U32),
    "s_add_u32": _ignore_explicit_vcc(Add, IRType.U32),
    "v_add_f64": same(Add, IRType.F64),
    "v_addc_u32": _ignore_explicit_vcc(AddC, IRType.U32),
    "s_addc_u32": _ignore_explicit_vcc(AddC, IRType.U32),
    "s_sub_u32": _ignore_explicit_vcc(Sub, IRType.U32),
    "v_subrev_u32": _ignore_explicit_vcc(SubRev, IRType.U32),
    "v_sub_u32": _ignore_explicit_vcc(Sub, IRType.U32),
    "s_subb_u32": _ignore_explicit_vcc(Sub, IRType.U32),
    "v_subb_u32": _ignore_explicit_vcc(Sub, IRType.U32),
    "v_sub_f32": same(Sub, IRType.F32),
    "v_mul_u32": same(MulLo, IRType.U32),
    "s_mul_u32": same(MulLo, IRType.U32),
    "v_mul_hi_u32": same(MulHi, IRType.U32),
    "s_mul_hi_u32": same(MulHi, IRType.U32),
    "v_mul_lo_u32": same(MulLo, IRType.U32),
    "s_mul_lo_u32": same(MulLo, IRType.U32),
    "v_mul_i32": same(MulLo, IRType.I32),
    "s_mul_i32": same(MulLo, IRType.I32),
    "v_mul_hi_i32": same(MulHi, IRType.I32),
    "s_mul_hi_i32": same(MulHi, IRType.I32),
    "v_mul_i32_i24": same(Mul24, IRType.I32),
    "v_mul_f32": same(MulF, IRType.F32),
    "v_mac_f32": Rule([Emit(MacF32, op(0), op(1), op(2), op(0), op_type=IRType.F32)]),
    "v_mad_u32": same(Mad, IRType.U64_U32),
    "s_mad_u32": same(Mad, IRType.U64_U32),
    "v_lshl_b32": same(LShl, IRType.B32),
    "s_lshl_b32": same(LShl, IRType.B32),
    "s_lshl_b64": same(LShl, IRType.B64),
    "v_lshlrev_b32": same(LShlRev, IRType.B32),
    "s_lshlrev_b32": same(LShlRev, IRType.B32),
    "v_lshlrev_b64": same(LShlRev, IRType.B64),
    "v_lshr_b32": same(LShr, IRType.B32),
    "s_lshr_b32": same(LShr, IRType.B32),
    "v_lshrrev_b32": same(LShrRev, IRType.B32),
    "s_lshrrev_b32": same(LShrRev, IRType.B32),
    "v_lshrrev_b64": same(LShrRev, IRType.B64),
    "s_ashr_i32": same(AShr, IRType.I32),
    "v_ashrrev_i64": same(AShrRev, IRType.I64),
    "v_ashrrev_i32": same(AShrRev, IRType.I32),
    "s_and_b32": _same_with_exec_mask(And, IRType.B32),
    "s_and_b64": _same_with_exec_mask(And, IRType.B64),
    "v_and_b32": _same_with_exec_mask(And, IRType.B32),
    "s_xor_b32": _same_with_exec_mask(Xor, IRType.B32),
    "s_xor_b64": _same_with_exec_mask(Xor, IRType.B64),
    "v_xor_b32": _same_with_exec_mask(Xor, IRType.B32),
    "s_or_b32": _same_with_exec_mask(Or, IRType.B32),
    "s_or_b64": _same_with_exec_mask(Or, IRType.B64),
    "v_or_b32": _same_with_exec_mask(Or, IRType.B32),
    "s_andn2_b64": _same_with_exec_mask(Xor, IRType.B64),
    "v_mov_b32": _same_with_exec_mask(Mov, IRType.B32),
    "s_mov_b32": _same_with_exec_mask(Mov, IRType.B32),
    "s_mov_b64": _same_with_exec_mask(Mov, IRType.B64),
    "s_movk_i32": _same_with_exec_mask(Mov, IRType.I32),
    "s_load_dword": same(Load, IRType.B32),
    "s_load_dwordx2": same(Load, IRType.B64),
    "s_load_dwordx4": same(Load, IRType.B128),
    "flat_load_dword": same(FLoad, IRType.B32),
    "flat_load_dwordx2": same(FLoad, IRType.B64),
    "flat_load_dwordx4": same(FLoad, IRType.B128),
    "flat_store_byte": same(FStore, IRType.B8),
    "flat_store_short": same(FStore, IRType.B16),
    "flat_store_dword": same(FStore, IRType.B32),
    "flat_store_dwordx2": same(FStore, IRType.B64),
    "flat_store_dwordx4": same(FStore, IRType.B128),
    "s_store_dword": same(Store, IRType.B32),
    "s_store_dwordx2": same(Store, IRType.B64),
    "ds_write_b32": _local_store_like,
    "ds_read_b32": _local_load,
    "ds_add_u32": _local_add_like,
    "s_bfe_u32": same(Bfe, IRType.U32),
    "v_bfe_u32": same(Bfe, IRType.U32),
    "s_bfe_i32": same(Bfe, IRType.I32),
    "v_bfe_i32": same(Bfe, IRType.I32),
    "v_perm_b32": same(Permute32, IRType.B32),
    "v_cvt_i32_f32": same(CvtF32ToI32, IRType.I32_F32),
    "v_cvt_f64_u32": same(CvtU32ToF64, IRType.F64_U32),
    "v_cvt_f32_i32": same(CvtI32ToF32, IRType.F32_I32),
    "v_cvt_f64_i32": same(CvtI32ToF64, IRType.F64_I32),
    "v_cvt_i32_f64": same(CvtF64ToI32, IRType.I32_F64),
    "s_endpgm": same(EndPgm),
    "s_waitcnt": Rule([Emit(Barrier)]),
    "s_nop": Rule([Emit(Ignore)]),
    "v_cndmask_b32": Rule([Emit(CSelect, op(0), op(2), op(1), op(3), op_type=IRType.B32)]),
    "s_min_i32": same(IRMin, IRType.I32),
    "s_cselect_b64": _scalar_cselect_b64(),
}
