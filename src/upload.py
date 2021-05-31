from src.register import Register
from src.integrity import Integrity
from src.type_of_reg import Type
from src.decompiler_data import DecompilerData
from src.opencl_types import make_suffix


def extract_from_regs(registers, left_board):
    last = 0
    first = 0
    name = registers
    if left_board != -1:
        separation = registers.index(":")
        right_board = registers.index("]")
        first = int(registers[(left_board + 1):separation])
        last = int(registers[(separation + 1):right_board])
        name = registers[:left_board]
    else:
        if "s" in registers or "v" in registers:
            name = registers[0]
            first = int(registers[1:])
            last = first
    return first, last, name


def find_first_last_num_to_from(to_registers, from_registers):
    left_board_from = from_registers.find("[")
    first_from, last_from, name_of_from = extract_from_regs(from_registers, left_board_from)
    left_board_to = to_registers.find("[")
    first_to, last_to, name_of_to = extract_from_regs(to_registers, left_board_to)
    return first_to, last_to, name_of_to, name_of_from, first_from, last_from


def upload_usesetup(state, to_registers, offset):
    decompiler_data = DecompilerData()
    to_registers1 = ""
    separation = to_registers.find(":")
    if separation != -1:
        to_registers1 = "s" + to_registers[separation + 1:-1]
        to_registers = "s" + to_registers[2:separation]
    if offset == "0x0":
        state.registers[to_registers] = Register(to_registers, Type.general_setup, Integrity.entire)
        decompiler_data.make_version(state, to_registers)
    elif offset == "0x4":
        state.registers["s0"] = Register("get_local_size(0)", Type.local_size_x, Integrity.entire)
        decompiler_data.make_version(state, "s0")
        state.registers["s1"] = Register("get_local_size(2)", Type.local_size_z, Integrity.entire)
        decompiler_data.make_version(state, "s1")
        state.registers["s2"] = Register("get_global_size(0)", Type.global_size_x, Integrity.entire)
        decompiler_data.make_version(state, "s2")
        state.registers["s3"] = Register("get_global_size(1)", Type.global_size_y, Integrity.entire)
        decompiler_data.make_version(state, "s2")
    elif offset == "0xc":
        state.registers[to_registers] = Register("get_global_size(0)", Type.global_size_x, Integrity.entire)
        decompiler_data.make_version(state, to_registers)
        if to_registers1 != "":
            state.registers[to_registers1] = Register("get_global_size(1)", Type.global_size_y, Integrity.entire)
            decompiler_data.make_version(state, to_registers1)
    elif offset == "0x10":
        state.registers[to_registers] = Register("get_global_size(1)", Type.global_size_y, Integrity.entire)
        decompiler_data.make_version(state, to_registers)
        if to_registers1 != "":
            state.registers[to_registers1] = Register("get_global_size(2)", Type.global_size_z, Integrity.entire)
            decompiler_data.make_version(state, to_registers1)
    elif offset == "0x14":
        state.registers[to_registers] = Register("get_global_size(2)", Type.global_size_z, Integrity.entire)
        decompiler_data.make_version(state, to_registers)


def upload(state, to_registers, from_registers, offset, kernel_params):
    decompiler_data = DecompilerData()
    first_to, last_to, name_of_to, name_of_from, first_from, _ \
        = find_first_last_num_to_from(to_registers, from_registers)
    from_registers = name_of_from + str(first_from)
    to_registers = name_of_to + str(first_to)
    if state.registers[from_registers].type == Type.arguments_pointer:
        if offset == "0x0":
            state.registers[to_registers] = Register("get_global_offset(0)", Type.global_offset_x, Integrity.entire)
            decompiler_data.make_version(state, to_registers)
            state.registers[name_of_to + str(first_to + 1)] = Register("get_global_offset(0)",
                                                                       Type.global_offset_x, Integrity.entire)
            decompiler_data.make_version(state, name_of_to + str(first_to + 1))
            if last_to - first_to > 1:
                state.registers[name_of_to + str(last_to - 1)] = \
                    Register("get_global_offset(1)", Type.global_offset_y, Integrity.entire)
                decompiler_data.make_version(state, name_of_to + str(last_to - 1))
                state.registers[name_of_to + str(last_to)] = \
                    Register("get_global_offset(1)", Type.global_offset_y, Integrity.entire)
                decompiler_data.make_version(state, name_of_to + str(last_to))
        elif offset == "0x8":
            state.registers[to_registers] = Register("get_global_offset(1)", Type.global_offset_y, Integrity.entire)
            decompiler_data.make_version(state, to_registers)
            state.registers[name_of_to + str(first_to + 1)] = \
                Register("get_global_offset(1)", Type.global_offset_y, Integrity.entire)
            decompiler_data.make_version(state, name_of_to + str(first_to + 1))
            if last_to - first_to > 1:
                state.registers[name_of_to + str(last_to - 1)] = \
                    Register("get_global_offset(2)", Type.global_offset_z, Integrity.entire)
                decompiler_data.make_version(state, name_of_to + str(last_to - 1))
                state.registers[name_of_to + str(last_to)] = \
                    Register("get_global_offset(2)", Type.global_offset_z, Integrity.entire)
                decompiler_data.make_version(state, name_of_to + str(last_to))
        elif offset == "0x10":
            state.registers[to_registers] = Register("get_global_offset(2)", Type.global_offset_z, Integrity.entire)
            decompiler_data.make_version(state, to_registers)
            state.registers[name_of_to + str(first_to + 1)] = Register("get_global_offset(2)",
                                                                       Type.global_offset_z, Integrity.entire)
            decompiler_data.make_version(state, name_of_to + str(first_to + 1))
        else:
            for (reg, val) in kernel_params[offset]:
                value_for_type = val
                if value_for_type.find(".") != -1:
                    value_for_type = value_for_type[:value_for_type.find(".")]
                type_of_data = make_suffix(decompiler_data.type_params[value_for_type])
                if val[0] == "*":
                    type_param = Type.paramA
                    val = val[1:]
                else:
                    type_param = Type.param
                state.registers[reg] = Register(val, type_param, Integrity.entire)
                state.registers[reg].type_of_data = type_of_data
                decompiler_data.make_version(state, reg)
    elif state.registers[from_registers].type == Type.global_data_pointer:
        new_val = state.registers[from_registers].val
        state.registers[to_registers] = \
            Register(new_val, Type.global_data_pointer, Integrity.entire)
        decompiler_data.make_version(state, to_registers)
    else:
        for i in range(first_to, last_to + 1):
            to_registers = name_of_to + str(i)
            val = state.registers[from_registers].val + '[' + offset + ']'
            type_reg = state.registers[from_registers].type
            state.registers[to_registers] = Register(val, type_reg, Integrity.entire)
