from src.decompiler_data import DecompilerData
from src.opencl_types import evaluate_size, make_asm_type
from src.register import is_vector_type


def get_basic_param_type(num_of_param):
    type_name = DecompilerData().config_data.arguments[num_of_param].type_name
    if is_vector_type(type_name):
        type_name = type_name[:-1]
    return type_name


def get_param_size(name_of_param, param_type):
    if name_of_param[0] == "*":
        param_size = 8
    else:
        param_size, _ = evaluate_size(make_asm_type(param_type))
    return param_size


def get_bfe_offset(name_of_param, num_of_param, curr_offset, offset_num):
    decompiler_data = DecompilerData()
    param_type = get_basic_param_type(num_of_param)
    param_size = get_param_size(name_of_param, param_type)
    if "char" in param_type or "short" in param_type:
        load_offset = hex(int(curr_offset, 16) - int(curr_offset, 16) % 4)
        param_size_bit = hex(param_size * 8)
        offset_in_reg = hex((int(curr_offset, 16) - int(load_offset, 16)) * 8)
        bfe_offset = param_size_bit + ''.rjust(4 - len(offset_in_reg[2:]), '0') + offset_in_reg[2:]
        if offset_num.get(load_offset):
            decompiler_data.bfe_offsets[(offset_num[load_offset], bfe_offset)] = name_of_param
        else:
            decompiler_data.bfe_offsets[(name_of_param, bfe_offset)] = name_of_param


def get_current_offset(name_of_param, num_of_param, probably_offset):
    param_type = get_basic_param_type(num_of_param)
    param_size = get_param_size(name_of_param, param_type)
    probably_offset = hex(int(probably_offset, 16) + (param_size - int(probably_offset, 16) % param_size) % param_size)
    curr_offset = probably_offset
    probably_offset = hex(int(probably_offset, 16) + param_size)
    return curr_offset, probably_offset


def get_offsets_to_regs():
    decompiler_data = DecompilerData()
    data_of_param = []
    for num_of_param, arg in enumerate(decompiler_data.config_data.arguments):
        if arg.hidden:
            continue
        if arg.type_name[-1].isdigit() and arg.name[0] != '*':
            for i in range(int(arg.type_name[-1])):
                data_of_param.append([num_of_param, arg.name + '___s' + str(i), arg.type_name])
        else:
            data_of_param.append([num_of_param, arg.name, arg.type_name])

    offset_num = {}
    probably_offset = "0x0"
    for num_of_param, name_of_param, type_of_param in data_of_param:
        while probably_offset in decompiler_data.config_data.setup_params_offsets:
            probably_offset = hex(int(probably_offset, 16) + 8)
        # according to the algorithm first call to get_current_offset_for_not_first_param does not use last_name
        # noinspection PyUnboundLocalVariable
        curr_offset, probably_offset = get_current_offset(name_of_param, num_of_param, probably_offset)
        if int(curr_offset, 16) % 4 == 0:
            offset_num[curr_offset] = name_of_param

        if "short" in type_of_param or "char" in type_of_param:
            get_bfe_offset(name_of_param, num_of_param, curr_offset, offset_num)
    return offset_num


def get_kernel_params(offsets_of_kernel_params, offset_num):
    decompiler_data = DecompilerData()
    for key in sorted(offsets_of_kernel_params.keys()):
        for list_instruction in offsets_of_kernel_params[key]:
            instr = list_instruction[0]
            registers = list_instruction[1]
            if decompiler_data.is_rdna3:
                num_output_regs = int(instr.split("_")[-1][1:]) // 32
                first_num_of_reg = int(registers[1:].strip("[]").split(":")[0])

            else:
                if instr[-1] == 'd':
                    num_output_regs = 1
                    first_num_of_reg = int(registers[1:])
                else:
                    num_output_regs = int(instr[-1])
                    first_num_of_reg = int(registers[2:registers.find(':')])
            curr_reg = 0
            name_of_reg = registers[0]
            offset_num_keys = sorted(offset_num.keys())
            if key in decompiler_data.config_data.setup_params_offsets:
                continue
            curr_num_offset = offset_num_keys.index(key)
            while curr_reg < num_output_regs:
                curr_offset = offset_num_keys[curr_num_offset]
                name_of_param = offset_num[curr_offset]
                decompiler_data.add_to_kernel_params(
                    key,
                    (
                        name_of_reg + str(first_num_of_reg + curr_reg),
                        name_of_param,
                    ),
                )
                curr_reg += 1
                if name_of_param[0] == "*" or (decompiler_data.type_params.get(name_of_param)
                                               and 'long' in decompiler_data.type_params.get(name_of_param)):
                    decompiler_data.add_to_kernel_params(key,
                                                         (name_of_reg + str(first_num_of_reg + curr_reg),
                                                          name_of_param))
                    curr_reg += 1
                curr_num_offset += 1


def process_kernel_params(set_of_instructions):
    decompiler_data = DecompilerData()

    if decompiler_data.is_rdna3:
        return

    param_ptr = "s[6:7]" if decompiler_data.config_data.usesetup else "s[4:5]"
    offsets_of_kernel_params = {}
    for instruction in set_of_instructions:
        list_instruction = instruction.strip().replace(',', ' ').split()
        if "s_load_dword" in list_instruction[0] and \
                list_instruction[2] == param_ptr and \
                list_instruction[3] not in decompiler_data.config_data.setup_params_offsets:
            if offsets_of_kernel_params.get(list_instruction[3]) is None:
                offsets_of_kernel_params[list_instruction[3]] = []
            offsets_of_kernel_params[list_instruction[3]] += [list_instruction]
    offset_num = get_offsets_to_regs()
    get_kernel_params(offsets_of_kernel_params, offset_num)
