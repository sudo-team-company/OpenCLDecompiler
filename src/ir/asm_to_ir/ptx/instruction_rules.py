import re

from src.ir.asm_to_ir.lowering import Emit, Rule, named64, op, same
from src.ir.instructions.common.add import Add
from src.ir.instructions.common.barrier import Barrier
from src.ir.instructions.common.bfe import Bfe
from src.ir.instructions.common.compare import get_compare_class
from src.ir.instructions.common.cselect import CSelect
from src.ir.instructions.common.cvt import Cvt16To32, Cvt32To64, Cvt64To32, CvtF32ToI32, CvtU32ToF64
from src.ir.instructions.common.endpgm import EndPgm
from src.ir.instructions.common.logical import And, Or
from src.ir.instructions.common.lshl import LShl, LShr
from src.ir.instructions.common.mad import Mad
from src.ir.instructions.common.min import IRMin
from src.ir.instructions.common.mov import Mov
from src.ir.instructions.common.mul import MacF32, MulF, MulHi, MulLo, MulWide
from src.ir.instructions.common.not_instruction import Not
from src.ir.instructions.common.sub import Sub
from src.ir.instructions.common.typed_memory import (
    MemoryAccessType,
    TypedMemoryFLoad,
    TypedMemoryFStore,
    TypedMemoryLoad,
)
from src.ir.instructions.control_flow import Branch, BranchNot, Jump
from src.ir.instructions.special.local_memory import LocalAdd, LocalLoad, LocalStore
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Val

_MEMORY_TYPE_PATTERN = re.compile(r"^[busf](8|16|32|64)$")
_MEMORY_ADDRESS_OFFSET_PATTERN = re.compile(r"^\[\s*(%[\w.$]+)\s*([+-])\s*([+-]?(?:0x[0-9a-fA-F]+|\d+))\s*\]$")

SETP_OPCODE_PARTS = 3

_PTX_TYPE_BY_SUFFIX = {
    "b16": IRType.B16,
    "b32": IRType.B32,
    "b64": IRType.B64,
    "u16": IRType.U16,
    "u32": IRType.U32,
    "u64": IRType.U64,
    "s16": IRType.I16,
    "s32": IRType.I32,
    "s64": IRType.I64,
    "f32": IRType.F32,
    "f64": IRType.F64,
    "pred": IRType.PRED,
}


def get_instruction_rule(opcode: str, args_offset) -> Rule | None:
    if opcode in ("bra", "bra.uni"):
        return _branch()
    if opcode.startswith("setp."):
        return _setp(opcode)
    if opcode.startswith("ld.param."):
        return _param_load(opcode, args_offset)
    if opcode.startswith("ld.global."):
        return _global_load(opcode)
    if opcode.startswith("st.global."):
        return _global_store(opcode)
    return instruction_rules.get(opcode)


def _branch() -> Rule:
    def emit_branch(ctx) -> None:
        target = Val("." + ctx.operand(0).name)
        predicate = ctx.predicate

        if predicate is None:
            ctx.kernel.create_instruction(Jump, target)
        elif ctx.predicate_negated:
            ctx.kernel.create_instruction(BranchNot, predicate, target)
        else:
            ctx.kernel.create_instruction(Branch, predicate, target)

    return Rule.dynamic(emit_branch)


def _parse_setp_opcode(opcode: str) -> str:
    parts = opcode.split(".")
    if len(parts) != SETP_OPCODE_PARTS:
        raise NotImplementedError(opcode)

    _, comparison, _ = parts

    return {
        "lo": "lt",
        "ls": "le",
        "leu": "le",
        "hi": "gt",
        "hs": "ge",
        "geu": "ge",
        "equ": "eq",
        "neu": "ne",
    }.get(comparison, comparison)


def _parse_ptx_opcode_type(opcode: str) -> IRType:
    return _PTX_TYPE_BY_SUFFIX[opcode.split(".")[-1]]


def _setp(opcode: str) -> Rule:
    comparison = _parse_setp_opcode(opcode)
    op_type = _parse_ptx_opcode_type(opcode)
    compare_class = get_compare_class(comparison)

    def emit_setp(ctx) -> None:
        ctx.emit(
            compare_class,
            ctx.operand(0),
            ctx.operand(1),
            ctx.operand(2),
            op_type=op_type,
        )

    return Rule.dynamic(emit_setp)


def _param_load(opcode: str, args_offset) -> Rule:
    access_type = _parse_memory_access_type(opcode)

    def emit_global_load(ctx) -> None:
        ctx.emit(TypedMemoryLoad, ctx.operand(0), named64("argptr"), args_offset[ctx.operand(1).name], access_type)

    return Rule.dynamic(emit_global_load)


def _global_load(opcode: str) -> Rule:
    access_type = _parse_memory_access_type(opcode)

    def emit_global_load(ctx) -> None:
        address = _emit_address_operand(ctx, 1)
        ctx.emit(TypedMemoryFLoad, ctx.operand(0), address, Val("0"), access_type)

    return Rule.dynamic(emit_global_load)


def _global_store(opcode: str) -> Rule:
    access_type = _parse_memory_access_type(opcode)

    def emit_global_store(ctx) -> None:
        address = _emit_address_operand(ctx, 0)
        ctx.emit(TypedMemoryFStore, address, ctx.operand(1), access_type)

    return Rule.dynamic(emit_global_store)


def _operand_token(ctx, operand_index: int) -> str:
    operand_tokens = ctx.extras.get("operand_tokens", [])
    if operand_index < len(operand_tokens):
        return operand_tokens[operand_index]

    return ctx.operand(operand_index).name


def _parse_memory_address_offset(token: str) -> Val | None:
    match = _MEMORY_ADDRESS_OFFSET_PATTERN.match(token)
    if match is None:
        return None

    sign = match.group(2)
    offset = int(match.group(3), 0)
    if sign == "-":
        offset = -offset

    return Val(str(offset))


def _emit_address_operand(ctx, operand_index: int):
    offset = _parse_memory_address_offset(_operand_token(ctx, operand_index))
    if offset is None:
        return ctx.operand(operand_index)

    offset32 = ctx.tmp("offset", "32")
    offset64 = ctx.tmp("offset64", "64")
    address = ctx.tmp("address", "64")

    ctx.emit(Mov, offset32, offset, op_type=IRType.I32)
    ctx.emit(Cvt32To64, offset64, offset32, op_type=IRType.I64_I32)
    ctx.emit(Add, address, ctx.operand(operand_index), offset64, op_type=IRType.U64)
    return address


def _parse_memory_access_type(opcode: str) -> MemoryAccessType:
    parts = opcode.split(".")
    address_space = "global"
    vector_width = 1
    base_type = None

    for part in parts[2:]:
        if part.startswith("v") and part[1:].isdigit():
            vector_width = int(part[1:])
            continue

        if _MEMORY_TYPE_PATTERN.match(part):
            base_type = part

    if base_type is None:
        raise NotImplementedError(opcode)

    return MemoryAccessType(
        address_space=address_space,
        base_type=base_type,
        vector_width=vector_width,
    )


instruction_rules = {
    "add.s32": same(Add, IRType.I32),
    "add.s64": same(Add, IRType.I64),
    "add.s16": same(Add, IRType.I16),
    "add.f64": same(Add, IRType.F64),
    "sub.s32": same(Sub, IRType.I32),
    "sub.s64": same(Sub, IRType.I64),
    "sub.s16": same(Sub, IRType.I16),
    "sub.f32": same(Sub, IRType.F32),
    "mul.lo.s16": same(MulLo, IRType.I16),
    "mul.lo.s32": same(MulLo, IRType.I32),
    "mul.hi.s32": same(MulHi, IRType.I32),
    "mul.lo.u32": same(MulLo, IRType.U32),
    "mul.hi.u32": same(MulHi, IRType.U32),
    "mul.wide.s32": same(MulWide, IRType.I64_I32),
    "mul.wide.u32": same(MulWide, IRType.U64_U32),
    "mul.lo.s64": same(MulLo, IRType.I64),
    "mul.f32": same(MulF, IRType.F32),
    "mad.lo.s32": same(Mad, IRType.I64_I32),
    "mov.u16": same(Mov, IRType.U16),
    "mov.b32": same(Mov, IRType.B32),
    "mov.u32": same(Mov, IRType.U32),
    "mov.b64": same(Mov, IRType.B64),
    "mov.u64": same(Mov, IRType.U64),
    "mov.f32": same(Mov, IRType.F32),
    "cvt.s64.s32": same(Cvt32To64, IRType.I64_I32),
    "cvt.u64.u32": same(Cvt32To64, IRType.U64_U32),
    "cvt.u32.u64": same(Cvt64To32, IRType.U32_U64),
    "cvt.u16.u32": same(Cvt16To32, IRType.U16_U32),
    "cvt.rzi.s32.f32": same(CvtF32ToI32, IRType.I32_F32),
    "cvt.rn.f64.u32": same(CvtU32ToF64, IRType.F64_U32),
    "cvt.s32.s16": same(Cvt16To32, IRType.I32_I16),
    "shl.b16": same(LShl, IRType.B16),
    "shl.b32": same(LShl, IRType.B32),
    "shl.b64": same(LShl, IRType.B64),
    "shr.s64": same(LShr, IRType.I64),
    "and.b64": same(And, IRType.B64),
    "st.shared.u32": same(LocalStore, IRType.B32),
    "atom.shared.add.u32": Rule(
        [
            Emit(LocalAdd, op(1), op(2), op_type=IRType.U32),
        ]
    ),
    "ld.shared.u32": same(LocalLoad, IRType.B32),
    "s_bfe_u32": same(Bfe, IRType.U32),
    "v_bfe_u32": same(Bfe, IRType.U32),
    "s_bfe_i32": same(Bfe, IRType.I32),
    "v_bfe_i32": same(Bfe, IRType.I32),
    "bar.sync": Rule([Emit(Barrier)]),
    "selp.b32": same(CSelect, op_type=IRType.B32),
    "selp.b64": same(CSelect, op_type=IRType.B64),
    "min.s32": same(IRMin, IRType.I32),
    "ret": same(EndPgm),
    "or.pred": same(Or, IRType.PRED),
    "and.b32": same(And, IRType.B32),
    "neg.s32": same(Not, IRType.I32),
    "fma.rn.f32": same(MacF32, IRType.F32),
}
