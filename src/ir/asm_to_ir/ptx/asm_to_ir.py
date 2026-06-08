import re
import struct
from dataclasses import dataclass

from src.ir.asm_to_ir.lowering import InstructionContext
from src.ir.asm_to_ir.ptx.instruction_rules import get_instruction_rule
from src.ir.asm_to_ir.ptx.ptx_kernel import PTXArgument, PTXKernel
from src.ir.asm_to_ir.ptx.register_factory import RegFactory
from src.ir.instructions.control_flow import Label
from src.ir.instructions.special.init_reg import InitReg
from src.ir.kernel import Kernel
from src.ir.registers.reg import PredReg, Reg64, RegOrVal_ty, Val

_MEMORY_ADDRESS_OFFSET_PATTERN = re.compile(r"^\[\s*(%[\w.$]+)\s*[+-]\s*[+-]?(?:0x[0-9a-fA-F]+|\d+)\s*\]$")
_PTX_F32_HEX_LITERAL_PATTERN = re.compile(r"^([+-]?)0[fF]([0-9a-fA-F]{8})$")


def _strip_array_suffix(name: str) -> str:
    return name.split("[", 1)[0]


def _extract_array_size(name: str) -> int | None:
    if "[" not in name or not name.endswith("]"):
        return None

    size_text = name[name.index("[") + 1 : -1]
    if not size_text.isdigit():
        return None

    return int(size_text)


def _align_to_eight(size: int) -> int:
    return ((size + 7) // 8) * 8


def _argument_declared_size(arg: PTXArgument) -> int:
    if arg.is_pointer:
        return 8

    element_count = _extract_array_size(arg.name) or 1
    element_size = max(1, arg.size // 8)
    return element_size * element_count


def _split_operands(text: str) -> list[str]:
    operands: list[str] = []
    current: list[str] = []
    brace_depth = 0
    bracket_depth = 0

    for char in text:
        if char == "{":
            brace_depth += 1
        elif char == "}":
            brace_depth -= 1
        elif char == "[":
            bracket_depth += 1
        elif char == "]":
            bracket_depth -= 1

        if char == "," and brace_depth == 0 and bracket_depth == 0:
            operand = "".join(current).strip()
            if operand:
                operands.append(operand)
            current = []
            continue

        current.append(char)

    operand = "".join(current).strip()
    if operand:
        operands.append(operand)

    return operands


def _normalize_memory_operand_for_rf(operand: str) -> str:
    match = _MEMORY_ADDRESS_OFFSET_PATTERN.match(operand)
    if match is None:
        return operand

    return f"[{match.group(1)}]"


def _normalize_ptx_f32_hex_literal(operand: str) -> str:
    match = _PTX_F32_HEX_LITERAL_PATTERN.match(operand)
    if match is None:
        return operand

    sign, hex_digits = match.groups()
    value = struct.unpack(">f", bytes.fromhex(hex_digits))[0]
    if sign == "-":
        value = -value

    return str(value)


@dataclass(frozen=True)
class InstructionEmitRequest:
    kernel: Kernel
    opcode: str
    operands: list[RegOrVal_ty]
    args_offset: dict[str, Val]
    operand_tokens: list[str] | None = None
    predicate: PredReg | None = None
    predicate_negated: bool = False


def _create_instruction_from_opcode(request: InstructionEmitRequest) -> None:
    rule = get_instruction_rule(request.opcode, request.args_offset)
    if rule is None:
        raise NotImplementedError(request.opcode)

    rule.emit(
        InstructionContext(
            kernel=request.kernel,
            operands=request.operands,
            predicate=request.predicate,
            predicate_negated=request.predicate_negated,
            extras={
                "args_offset": request.args_offset,
                "operand_tokens": request.operand_tokens or [],
            },
        )
    )


# TODO(GFV) наду унифицировать типы в двух asm_to_text
def _normalize_arg_type(arg: PTXArgument) -> str:
    vector_size = _extract_array_size(arg.name)
    alignment_to_type = {
        1: "char",
        2: "short",
        4: "int",
        8: "long",
        16: "int4",
    }
    vector_type_map = {
        ("b8", 2): "char2",
        ("u8", 2): "char2",
        ("s8", 2): "char2",
        ("b8", 4): "char4",
        ("u8", 4): "char4",
        ("s8", 4): "char4",
        ("b8", 32): "uint8",
    }
    type_to_type = {
        "b8": "char",
        "u8": "char",
        "s8": "char",
        "b16": "short",
        "u16": "short",
        "s16": "short",
        "b32": "uint",
        "u32": "uint",
        "s32": "int",
        "b64": "ulong",
        "u64": "ulong",
        "s64": "long",
        "f32": "float",
        "f64": "double",
    }

    if vector_size is not None:
        vector_type = vector_type_map.get((arg.type_name, vector_size))
        if vector_type is not None:
            return vector_type

    if arg.is_pointer:
        address_space = arg.address_space or "global"
        fallback_type = alignment_to_type.get(arg.alignment, "long")
        return f"__{address_space} {fallback_type}"
    return type_to_type.get(arg.type_name, arg.type_name)


def _normalize_arg_name(arg: PTXArgument, arg_idx: int) -> str:
    normalized_name = "arg" + str(arg_idx)
    if arg.is_pointer:
        return "*" + normalized_name
    return normalized_name


def _init_special_registers(kernel: Kernel, rf: RegFactory, special_registers: list[str]):
    for raw_reg_name in special_registers:
        reg_name = raw_reg_name
        value = None
        if reg_name[0] == "[" and reg_name[-1] == "]":
            reg_name = reg_name[1:-1]

        if reg_name in ("%envreg0", "%envreg1", "%envreg2"):
            value = "0"

        elif reg_name in ("%envreg3", "%envreg4", "%envreg5"):
            dim = int(reg_name[-1]) - 3
            value = f"get_global_offset({dim})"

        elif reg_name in ("%envreg6", "%envreg7", "%envreg8"):
            dim = int(reg_name[-1]) - 6
            value = f"get_num_groups({dim})"

        elif reg_name == "%envreg9":
            value = "get_work_dim()"

        elif reg_name in ("%tid.x", "%tid.y", "%tid.z"):
            dim_map = {"x": 0, "y": 1, "z": 2}
            dim = dim_map[reg_name[-1]]
            value = f"get_local_id({dim})"

        elif reg_name in ("%ctaid.x", "%ctaid.y", "%ctaid.z"):
            dim_map = {"x": 0, "y": 1, "z": 2}
            dim = dim_map[reg_name[-1]]
            value = f"get_group_id({dim})"

        elif reg_name in ("%ntid.x", "%ntid.y", "%ntid.z"):
            dim_map = {"x": 0, "y": 1, "z": 2}
            dim = dim_map[reg_name[-1]]
            value = f"get_local_size({dim})"

        if value is not None:
            kernel.create_instruction(InitReg, rf.get_or_create_auto(reg_name), Val(value))


def _ensure_predicate(kernel: Kernel, rf: RegFactory, predicate_name: str) -> PredReg:
    predicate = rf.get_or_create(predicate_name, "pred")
    kernel.predicates.add(predicate)
    return predicate


def text_to_ir(kernel_info: PTXKernel) -> Kernel:
    rf = RegFactory()

    kernel = Kernel(kernel_info.name, kernel_info.work_group_size)

    for name, size in kernel_info.locals.items():
        kernel.local_memory.set(name, size)
        rf.get_or_create(name, "64")

    for register in kernel_info.registers:
        if register.reg_type == "pred":
            kernel.predicates.add(rf.get_or_create(register.name, "pred"))

    args_offset = {}
    offset = 0
    for arg_idx, arg in enumerate(kernel_info.arguments):
        declared_size = _argument_declared_size(arg)
        kernel_argument = kernel.arguments.add(
            _normalize_arg_name(arg, arg_idx),
            _normalize_arg_type(arg),
            const=arg.is_const,
            offset=offset,
        )
        kernel_argument.declared_size = declared_size
        args_offset[_strip_array_suffix(arg.name)] = Val(hex(offset))
        offset += _align_to_eight(declared_size)

    arg_reg_name = "argptr"
    agr_reg = Reg64(arg_reg_name)
    kernel.arguments.set_arg_ptr(agr_reg)

    _init_special_registers(kernel, rf, kernel_info.special_registers)

    for instruction_info in kernel_info.instructions:
        line = instruction_info.text.strip()
        if not line:
            continue

        if line.endswith(":"):
            kernel.create_instruction(Label, Val("." + line[:-1]))
            continue

        parts = line.split(None, 1)
        if not parts:
            continue

        opcode = parts[0]
        operands = []

        operand_tokens = []
        if len(parts) > 1:
            operand_tokens = [_normalize_ptx_f32_hex_literal(operand) for operand in _split_operands(parts[1])]

        for operand in operand_tokens:
            normalized_operand = _normalize_memory_operand_for_rf(operand)
            parsed_operand = rf.get_or_create_auto(normalized_operand)
            operands.append(parsed_operand)

        predicate = None
        predicate_negated = instruction_info.predicate_negated
        if instruction_info.predicate is not None:
            predicate = _ensure_predicate(kernel, rf, instruction_info.predicate)

        _create_instruction_from_opcode(
            InstructionEmitRequest(
                kernel=kernel,
                opcode=opcode,
                operands=operands,
                args_offset=args_offset,
                operand_tokens=operand_tokens,
                predicate=predicate,
                predicate_negated=predicate_negated,
            )
        )

    return kernel
