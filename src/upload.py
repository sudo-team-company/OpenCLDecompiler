from src.decompiler_data import DecompilerData, make_elem_from_addr
from src.integrity import Integrity
from src.opencl_types import make_asm_type
from src.register import Register, check_and_split_regs, get_next_reg
from src.register_type import RegisterType


def upload_usesetup_offset_0x0(state, to_registers):
    decompiler_data = DecompilerData()
    state.registers[to_registers] = Register(to_registers, RegisterType.GENERAL_SETUP, Integrity.ENTIRE)
    decompiler_data.make_version(state, to_registers)


def upload_usesetup_offset_0x4(state):
    decompiler_data = DecompilerData()
    state.registers["s0"] = Register("get_local_size(0)", RegisterType.LOCAL_SIZE_X, Integrity.ENTIRE)
    decompiler_data.make_version(state, "s0")
    state.registers["s1"] = Register("get_local_size(2)", RegisterType.LOCAL_SIZE_Z, Integrity.ENTIRE)
    decompiler_data.make_version(state, "s1")
    state.registers["s2"] = Register("get_global_size(0)", RegisterType.GLOBAL_SIZE_X, Integrity.ENTIRE)
    decompiler_data.make_version(state, "s2")
    state.registers["s3"] = Register("get_global_size(1)", RegisterType.GLOBAL_SIZE_Y, Integrity.ENTIRE)
    decompiler_data.make_version(state, "s2")


def upload_usesetup_offset_0xc(state, to_registers, to_registers1):
    decompiler_data = DecompilerData()
    state.registers[to_registers] = Register("get_global_size(0)", RegisterType.GLOBAL_SIZE_X, Integrity.ENTIRE)
    decompiler_data.make_version(state, to_registers)
    if to_registers1 != "":
        state.registers[to_registers1] = Register("get_global_size(1)", RegisterType.GLOBAL_SIZE_Y, Integrity.ENTIRE)
        decompiler_data.make_version(state, to_registers1)


def upload_usesetup_offset_0x10(state, to_registers, to_registers1):
    decompiler_data = DecompilerData()
    state.registers[to_registers] = Register("get_global_size(1)", RegisterType.GLOBAL_SIZE_Y, Integrity.ENTIRE)
    decompiler_data.make_version(state, to_registers)
    if to_registers1 != "":
        state.registers[to_registers1] = Register("get_global_size(2)", RegisterType.GLOBAL_SIZE_Z, Integrity.ENTIRE)
        decompiler_data.make_version(state, to_registers1)


def upload_usesetup_offset_0x14(state, to_registers):
    decompiler_data = DecompilerData()
    state.registers[to_registers] = Register("get_global_size(2)", RegisterType.GLOBAL_SIZE_Z, Integrity.ENTIRE)
    decompiler_data.make_version(state, to_registers)


def upload_usesetup(state, to_registers, offset):
    to_registers1 = ""
    separation = to_registers.find(":")
    if separation != -1:
        to_registers1 = "s" + to_registers[separation + 1:-1]
        to_registers = "s" + to_registers[2:separation]
    if offset == "0x0":
        upload_usesetup_offset_0x0(state, to_registers)
    elif offset == "0x4":
        upload_usesetup_offset_0x4(state)
    elif offset == "0xc":
        upload_usesetup_offset_0xc(state, to_registers, to_registers1)
    elif offset == "0x10":
        upload_usesetup_offset_0x10(state, to_registers, to_registers1)
    elif offset == "0x14":
        upload_usesetup_offset_0x14(state, to_registers)


def upload_offset_0x0(state, to_registers):
    # Подразумевается, что to_registers это не единичный регистр
    decompiler_data = DecompilerData()
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    curr_to_register = start_to_register
    state.registers[curr_to_register] = Register("get_global_offset(0)", RegisterType.GLOBAL_OFFSET_X, Integrity.ENTIRE)
    decompiler_data.make_version(state, curr_to_register)
    curr_to_register = get_next_reg(curr_to_register)
    state.registers[curr_to_register] = Register("get_global_offset(0)", RegisterType.GLOBAL_OFFSET_X, Integrity.ENTIRE)
    decompiler_data.make_version(state, curr_to_register)
    if curr_to_register != end_to_register:  # может лучше цикл?
        curr_to_register = get_next_reg(curr_to_register)
        state.registers[curr_to_register] = \
            Register("get_global_offset(1)", RegisterType.GLOBAL_OFFSET_Y, Integrity.ENTIRE)
        decompiler_data.make_version(state, curr_to_register)
        curr_to_register = get_next_reg(curr_to_register)
        state.registers[curr_to_register] = \
            Register("get_global_offset(1)", RegisterType.GLOBAL_OFFSET_Y, Integrity.ENTIRE)
        decompiler_data.make_version(state, curr_to_register)


def upload_offset_0x8(state, to_registers):
    # Подразумевается, что to_registers это не единичный регистр
    decompiler_data = DecompilerData()
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    curr_to_register = start_to_register
    state.registers[curr_to_register] = Register("get_global_offset(1)", RegisterType.GLOBAL_OFFSET_Y, Integrity.ENTIRE)
    decompiler_data.make_version(state, curr_to_register)
    curr_to_register = get_next_reg(curr_to_register)
    state.registers[curr_to_register] = Register("get_global_offset(1)", RegisterType.GLOBAL_OFFSET_Y, Integrity.ENTIRE)
    decompiler_data.make_version(state, curr_to_register)
    if curr_to_register != end_to_register:
        curr_to_register = get_next_reg(curr_to_register)
        state.registers[curr_to_register] = \
            Register("get_global_offset(2)", RegisterType.GLOBAL_OFFSET_Z, Integrity.ENTIRE)
        decompiler_data.make_version(state, curr_to_register)
        curr_to_register = get_next_reg(curr_to_register)
        state.registers[curr_to_register] = \
            Register("get_global_offset(2)", RegisterType.GLOBAL_OFFSET_Z, Integrity.ENTIRE)
        decompiler_data.make_version(state, curr_to_register)


def upload_offset_0x10(state, to_registers):
    decompiler_data = DecompilerData()
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    state.registers[start_to_register] = \
        Register("get_global_offset(2)", RegisterType.GLOBAL_OFFSET_Z, Integrity.ENTIRE)
    decompiler_data.make_version(state, start_to_register)
    state.registers[end_to_register] = Register("get_global_offset(2)", RegisterType.GLOBAL_OFFSET_Z, Integrity.ENTIRE)
    decompiler_data.make_version(state, end_to_register)


def upload_kernel_param(state, offset, kernel_params):
    decompiler_data = DecompilerData()
    for (reg, val) in kernel_params[offset]:
        value_for_type = val
        if value_for_type.find(".") != -1:
            value_for_type = value_for_type[:value_for_type.find(".")]
        data_type = make_asm_type(decompiler_data.type_params[value_for_type])
        if val[0] == "*":
            type_param = RegisterType.ADDRESS_KERNEL_ARGUMENT
            val = val[1:]
        else:
            type_param = RegisterType.KERNEL_ARGUMENT_VALUE
        state.registers[reg] = Register(val, type_param, Integrity.ENTIRE)
        state.registers[reg].data_type = data_type
        decompiler_data.make_version(state, reg)


def upload_global_data_pointer(state, to_registers, from_registers):
    decompiler_data = DecompilerData()
    start_to_register, _ = check_and_split_regs(to_registers)
    start_from_register, _ = check_and_split_regs(from_registers)
    data_type = state.registers[start_from_register].data_type
    new_val = make_elem_from_addr(state.registers[start_from_register].val)
    state.registers[start_to_register] = Register(new_val, RegisterType.GLOBAL_DATA_POINTER, Integrity.ENTIRE)
    state.registers[start_to_register].data_type = data_type
    decompiler_data.make_version(state, start_to_register)


def upload(state, to_registers, from_registers, offset, kernel_params):
    start_from_register, _ = check_and_split_regs(from_registers)
    if state.registers[start_from_register].type == RegisterType.ARGUMENTS_POINTER:
        if offset == "0x0":
            upload_offset_0x0(state, to_registers)
        elif offset == "0x8":
            upload_offset_0x8(state, to_registers)
        elif offset == "0x10":
            upload_offset_0x10(state, to_registers)
        else:
            upload_kernel_param(state, offset, kernel_params)
    elif state.registers[start_from_register].type == RegisterType.GLOBAL_DATA_POINTER:
        upload_global_data_pointer(state, to_registers, from_registers)
    # TODO: Проанализировать на других программах может ли выполняться этот кусок, сейчас тесты работают
    # else:
    #     for i in range(first_to, last_to + 1):
    #         to_registers = name_of_to + str(i)
    #         val = state.registers[from_registers].val + '[' + offset + ']'
    #         type_reg = state.registers[from_registers].type
    #         state.registers[to_registers] = Register(val, type_reg, Integrity.ENTIRE)
