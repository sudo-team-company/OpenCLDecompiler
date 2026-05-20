from src.ir.asm_to_ir.amd.instruction_rules import get_instruction_rule
from src.ir.asm_to_ir.amd.register_factory import RegFactory
from src.ir.asm_to_ir.lowering import InstructionContext
from src.ir.instructions.special.init_reg import InitReg
from src.ir.instructions.special.memory import MemoryAllocation, Store
from src.ir.kernel import Kernel
from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Val
from src.model.config_data import ConfigData


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


def text_to_ir(text: list[str], cf: ConfigData) -> Kernel:
    rf = RegFactory()

    kernel = Kernel(cf.kernel_name, cf.size_of_work_groups)

    kernel.predicates.add(rf.parse_operand("exec"))
    kernel.predicates.add(rf.parse_operand("vcc"))
    kernel.predicates.add(rf.parse_operand("scc"))

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
        line = raw_line.strip()
        if not line:
            continue

        parts = line.split()
        if not parts:
            continue

        opcode = parts[0]
        operands = []
        if "ds" in opcode and "offset" not in parts[-1]:
            parts.append("offset:0")

        if len(parts) > 1 and parts[1] == "m0,":
            continue

        for raw_operand in parts[1:]:
            operand = raw_operand.rstrip(",")
            parsed_operand = rf.parse_operand(operand)
            if "offset" in operand:
                offset = int(operand[7:])
                offset_map[offset] = "lc" + str(offset)
                local_memory_name = offset_map[offset]
                parsed_operand = rf.get_or_create(local_memory_name, "64")
            operands.append(parsed_operand)

        create_instruction_from_opcode(kernel, opcode, operands)

    offsets = list(offset_map.keys())
    offsets.append(cf.local_size)
    offsets.sort()
    for key in range(len(offsets) - 1):
        lc_name = offset_map[offsets[key]]
        lc_size = int(offsets[key + 1] - offsets[key])
        kernel.local_memory.set(lc_name, lc_size)

    return kernel
