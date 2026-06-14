import re
from typing import Any

from src.ir.asm_to_ir.amd.instruction_rules import get_instruction_rule
from src.ir.asm_to_ir.amd.register_factory import RegFactory
from src.ir.asm_to_ir.lowering import InstructionContext
from src.ir.instructions.special.init_reg import InitReg
from src.ir.instructions.special.memory import MemoryAllocation, Store
from src.ir.kernel import Kernel
from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Val
from src.model.config_data import ConfigData


def get_gdata_offset(instruction: str) -> int:
    match = re.search(r"\.gdata(?:\+(\d+))?", instruction)
    if match is None:
        return 0
    return int(match.group(1) or 0)


def get_gdata_name(offset: int) -> str:
    return f"arr{offset}__gdata"


def _global_data_instruction_text(instruction: Any) -> str:
    if isinstance(instruction, tuple):
        return str(instruction[0])
    return str(instruction)


def process_global_data(
    kernel: Kernel,
    set_of_global_data_instruction: list[Any],
    set_of_global_data_bytes: list[str],
) -> dict[int, str]:
    offsets = sorted(
        {
            get_gdata_offset(_global_data_instruction_text(instruction))
            for instruction in set_of_global_data_instruction
            if ".gdata" in _global_data_instruction_text(instruction)
        }
    )
    if not offsets:
        return {}

    offset_to_name = {offset: get_gdata_name(offset) for offset in offsets}
    slice_boundaries = [*offsets, len(set_of_global_data_bytes)]

    for index in range(len(slice_boundaries) - 1):
        offset = slice_boundaries[index]
        next_offset = slice_boundaries[index + 1]
        kernel.global_memory.set(offset_to_name[offset], set_of_global_data_bytes[offset:next_offset])

    return offset_to_name


def init_dispatch_reg(dispatch_reg: Reg_ty, kernel: Kernel):
    kernel.create_instruction(MemoryAllocation, dispatch_reg)
    kernel.create_instruction(Store, dispatch_reg, Val("general_setup"), Val("uint"), Val("0"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_local_size(0)"), Val("uint"), Val("4"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_local_size(2)"), Val("uint"), Val("8"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(0)"), Val("uint"), Val("12"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(1)"), Val("uint"), Val("16"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(2)"), Val("uint"), Val("20"))
    kernel.create_instruction(Store, dispatch_reg, Val("UNKNOWN"), Val("uint"), Val("24"))


def create_instruction_from_opcode(kernel: Kernel, opcode: str, operands: list[RegOrVal_ty]):
    normalized_opcode = opcode.removesuffix("_e32").removesuffix("_e64")

    rule = get_instruction_rule(normalized_opcode)
    if rule is None:
        raise NotImplementedError(normalized_opcode)

    rule.emit(
        InstructionContext(
            kernel=kernel,
            operands=operands,
        )
    )


def _parse_amd_operand(
    raw_operand: str,
    rf: RegFactory,
    global_offset_map: dict[int, str],
    offset_map: dict[int, str],
) -> RegOrVal_ty:
    operand = raw_operand.rstrip(",")
    if ".gdata" in operand:
        offset = get_gdata_offset(operand)
        global_memory_name = global_offset_map.get(offset, get_gdata_name(offset))
        return rf.get_or_create(global_memory_name, "64")

    if "offset" in operand:
        offset = int(operand[7:])
        offset_map[offset] = "lc" + str(offset)
        return rf.get_or_create(offset_map[offset], "64")

    return rf.parse_operand(operand)


def _parse_amd_instruction_line(
    raw_line: str,
    rf: RegFactory,
    global_offset_map: dict[int, str],
    offset_map: dict[int, str],
) -> tuple[str, list[RegOrVal_ty]] | None:
    line = raw_line.strip()
    if not line:
        return None

    parts = line.split()
    if not parts:
        return None

    opcode = parts[0]
    if "ds" in opcode and "offset" not in parts[-1]:
        parts.append("offset:0")

    if len(parts) > 1 and parts[1] == "m0,":
        return None

    operands = [_parse_amd_operand(raw_operand, rf, global_offset_map, offset_map) for raw_operand in parts[1:]]
    return opcode, operands


def text_to_ir(
    text: list[str],
    cf: ConfigData,
    set_of_global_data_bytes: list[str],
    set_of_global_data_instruction: list[str],
) -> Kernel:
    rf = RegFactory()

    kernel = Kernel(cf.kernel_name, cf.size_of_work_groups)

    kernel.predicates.add(rf.parse_operand("exec"))
    kernel.predicates.add(rf.parse_operand("vcc"))
    kernel.predicates.add(rf.parse_operand("scc"))
    global_offset_map = process_global_data(kernel, set_of_global_data_instruction, set_of_global_data_bytes)

    for arg in cf.arguments:
        name_to_check = arg.name
        name_to_check = name_to_check.removeprefix("*")
        if not name_to_check.startswith("_"):
            kernel.arguments.add(arg.name, arg.type_name, const=arg.const, offset=arg.offset, hidden=arg.hidden)

    arg_reg_name = "s[6:7]" if cf.usesetup else "s[4:5]"
    agr_reg = rf.parse_operand(arg_reg_name)
    kernel.arguments.set_arg_ptr(agr_reg)

    if cf.usesetup:
        init_dispatch_reg(rf.parse_operand("s[4:5]"), kernel)

    g_id_shift = 8 if cf.usesetup else 6
    dimensions = max(cf.dimensions.split(","), key=len)
    for dim in range(len(dimensions)):
        kernel.create_instruction(InitReg, rf.parse_operand(f"s{g_id_shift + dim}"), Val(f"get_group_id({dim})"))
        kernel.create_instruction(InitReg, rf.parse_operand(f"v{dim}"), Val(f"get_local_id({dim})"))

    offset_map: dict[int, str] = {}
    for raw_line in text:
        parsed_instruction = _parse_amd_instruction_line(raw_line, rf, global_offset_map, offset_map)
        if parsed_instruction is None:
            continue

        opcode, operands = parsed_instruction
        create_instruction_from_opcode(kernel, opcode, operands)

    offsets = list(offset_map.keys())
    offsets.append(cf.local_size)
    offsets.sort()
    for key in range(len(offsets) - 1):
        lc_name = offset_map[offsets[key]]
        lc_size = int(offsets[key + 1] - offsets[key])
        kernel.local_memory.set(lc_name, lc_size)

    return kernel
