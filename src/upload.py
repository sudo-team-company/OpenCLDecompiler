from src.decompiler_data import DecompilerData, make_elem_from_addr
from src.integrity import Integrity
from src.opencl_types import make_asm_type
from src.register import Register, check_and_split_regs, get_next_reg
from src.register_type import RegisterType

usesetup_dict = {
    '0x0': Register("", RegisterType.GENERAL_SETUP, Integrity.ENTIRE),
    #  TODO: Подумать, как лучше вписать, что здесь и LOCAL_SIZE_X, и LOCAL_SIZE_Y
    '0x4': Register("get_local_size(0)", RegisterType.LOCAL_SIZE_X, Integrity.ENTIRE),
    '0x8': Register("get_local_size(2)", RegisterType.LOCAL_SIZE_Z, Integrity.ENTIRE),
    '0xc': Register("get_global_size(0)", RegisterType.GLOBAL_SIZE_X, Integrity.ENTIRE),
    '0x10': Register("get_global_size(1)", RegisterType.GLOBAL_SIZE_Y, Integrity.ENTIRE),
    '0x14': Register("get_global_size(2)", RegisterType.GLOBAL_SIZE_Z, Integrity.ENTIRE),
    '0x18': Register("", RegisterType.UNKNOWN, Integrity.ENTIRE),
}


def upload_usesetup(state, to_registers, offset):
    decompiler_data = DecompilerData()
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    curr_to_register = start_to_register
    while True:
        state.registers[curr_to_register] = usesetup_dict[offset]
        decompiler_data.make_version(state, curr_to_register)
        offset = hex(int(offset, 16) + 4)
        if curr_to_register == end_to_register:
            break
        curr_to_register = get_next_reg(curr_to_register)


def upload_kernel_param(state, offset, kernel_params, to_registers):
    decompiler_data = DecompilerData()
    to_registers = check_and_split_regs(to_registers)
    for (reg, val) in kernel_params[offset]:
        if reg not in to_registers:
            continue
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


setup_argument_dict = {
    '0x0': Register("get_global_offset(0)", RegisterType.GLOBAL_OFFSET_X, Integrity.ENTIRE),
    '0x8': Register("get_global_offset(1)", RegisterType.GLOBAL_OFFSET_Y, Integrity.ENTIRE),
    '0x10': Register("get_global_offset(2)", RegisterType.GLOBAL_OFFSET_Z, Integrity.ENTIRE)
}


def upload_setup_argument(state, to_registers, offset):
    decompiler_data = DecompilerData()
    offset = hex(decompiler_data.config_data.setup_params_offsets.index(offset) * 8)
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    curr_to_register = start_to_register
    while True:
        # TODO: Учитывать размер - 64 или 32
        state.registers[curr_to_register] = setup_argument_dict[offset]
        decompiler_data.make_version(state, curr_to_register)
        if curr_to_register == end_to_register:
            break
        curr_to_register = get_next_reg(curr_to_register)
        state.registers[curr_to_register] = setup_argument_dict[offset]
        decompiler_data.make_version(state, curr_to_register)
        offset = hex(int(offset, 16) + 8)
        if curr_to_register == end_to_register:
            break
        curr_to_register = get_next_reg(curr_to_register)


def upload(state, to_registers, from_registers, offset, kernel_params):
    start_from_register, _ = check_and_split_regs(from_registers)
    if state.registers[start_from_register].type == RegisterType.ARGUMENTS_POINTER:
        if offset in DecompilerData().config_data.setup_params_offsets:
            upload_setup_argument(state, to_registers, offset)
        else:
            upload_kernel_param(state, offset, kernel_params, to_registers)
    elif state.registers[start_from_register].type == RegisterType.GLOBAL_DATA_POINTER:
        upload_global_data_pointer(state, to_registers, from_registers)
