from src.decompiler_data import DecompilerData
from src.opencl_types import evaluate_size, make_asm_type
from src.register import is_vector_type


def get_bfe_offset(name_of_param, type_name, offset, offset_num):
    param_type = type_name[:-1] if is_vector_type(type_name) else type_name
    param_size = 8 if name_of_param.startswith('*') else evaluate_size(make_asm_type(param_type))[0]
    load_offset = hex(offset - offset % 4)
    param_size_bit = hex(param_size * 8)
    offset_in_reg = hex((offset - int(load_offset, 16)) * 8)
    bfe_offset = param_size_bit + ''.rjust(4 - len(offset_in_reg[2:]), '0') + offset_in_reg[2:]
    DecompilerData().bfe_offsets[(offset_num.get(load_offset, name_of_param), bfe_offset)] = name_of_param


def process_arg(offset_num: dict[str, str], name_of_param, offset: int, arg):
    if offset % 4 == 0:
        offset_num[hex(offset)] = name_of_param
    if "short" in arg.type_name or "char" in arg.type_name:
        get_bfe_offset(name_of_param, arg.type_name, offset, offset_num)


def get_offsets_to_regs():
    offset_num = {}
    for arg in DecompilerData().config_data.arguments:
        if arg.hidden:
            continue
        if arg.type_name[-1].isdigit() and arg.name[0] != '*':
            length = int(arg.type_name[-1])
            param_size = arg.size // length
            for i in range(length):
                name_of_param = arg.name + '___s' + str(i)
                offset = arg.offset + param_size * i
                process_arg(offset_num, name_of_param, offset, arg)
        else:
            process_arg(offset_num, arg.name, arg.offset, arg)
    return offset_num


def get_kernel_params(offsets_of_kernel_params, offset_num):
    decompiler_data = DecompilerData()
    for key in sorted(offsets_of_kernel_params.keys()):
        for list_instruction in offsets_of_kernel_params[key]:
            instr = list_instruction[0]
            registers = list_instruction[1]
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
