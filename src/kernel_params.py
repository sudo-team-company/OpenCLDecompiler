from src.decompiler_data import DecompilerData


def get_current_offset_for_not_first_param(offset_num, last_name, name_of_param, num_of_param):
    decompiler_data = DecompilerData()
    last_offset = sorted(offset_num.keys())[-1]
    # TODO: добавить и проверку на long, когда решится вопрос с векторным типом
    if last_name[0] == '*':
        curr_offset = hex(int(last_offset, 16) + 8)
    else:
        if name_of_param[0] == "*" \
                or 'long' in decompiler_data.type_params.get(decompiler_data.params["param" + num_of_param]):
            if last_offset[-1] < '8':
                curr_offset = last_offset[:-1] + '8'
            else:
                curr_offset = hex(int(last_offset, 16) + 8) if last_offset[-1] == '8' else hex(int(last_offset, 16) + 4)
        else:
            curr_offset = hex(int(last_offset, 16) + 4)
    return curr_offset


def get_offsets_to_regs():
    decompiler_data = DecompilerData()
    offset_num = {}
    data_of_param = []
    for num_of_param in range(len(decompiler_data.params)):
        num_of_param = str(num_of_param)
        name_of_param = decompiler_data.params["param" + num_of_param]
        type_of_param = decompiler_data.type_params.get(name_of_param)
        if type_of_param[-1].isdigit() and name_of_param[0] != '*':
            for i in range(int(type_of_param[-1])):
                data_of_param.append([num_of_param, name_of_param + '___s' + str(i), type_of_param])
        else:
            data_of_param.append([num_of_param, name_of_param, type_of_param])
    visited = False
    curr_offset = "0x0"
    for num_of_param, name_of_param, type_of_param in data_of_param:
        while curr_offset in decompiler_data.config_data.setup_params_offsets:
            curr_offset = hex(int(curr_offset, 16) + 8)
        if num_of_param == '0' and not visited:
            offset_num[curr_offset] = name_of_param
            visited = True
        else:
            # according to the algorithm first call to get_current_offset_for_not_first_param does not use last_name
            # noinspection PyUnboundLocalVariable
            curr_offset = get_current_offset_for_not_first_param(offset_num, last_name, name_of_param, num_of_param)
            offset_num[curr_offset] = name_of_param
        last_name = name_of_param
    return offset_num


def get_kernel_params(offsets_of_kernel_params, offset_num):
    decompiler_data = DecompilerData()
    for key in sorted(offsets_of_kernel_params.keys()):
        instr = offsets_of_kernel_params[key][0]
        registers = offsets_of_kernel_params[key][1]
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
            decompiler_data.add_to_kernel_params(key, (name_of_reg + str(first_num_of_reg + curr_reg), name_of_param))
            curr_reg += 1
            if name_of_param[0] == "*" or (decompiler_data.type_params.get(name_of_param)
                                           and 'long' in decompiler_data.type_params.get(name_of_param)):
                decompiler_data.add_to_kernel_params(key,
                                                     (name_of_reg + str(first_num_of_reg + curr_reg), name_of_param))
                curr_reg += 1
            curr_num_offset += 1


def process_kernel_params(set_of_instructions):
    decompiler_data = DecompilerData()
    param_ptr = "s[6:7]" if decompiler_data.config_data.usesetup else "s[4:5]"
    offsets_of_kernel_params = {}
    for instruction in set_of_instructions:
        list_instruction = instruction.strip().replace(',', ' ').split()
        if "s_load_dword" in list_instruction[0] and \
                list_instruction[2] == param_ptr and \
                list_instruction[3] not in decompiler_data.config_data.setup_params_offsets:
            offsets_of_kernel_params[list_instruction[3]] = list_instruction
    offset_num = get_offsets_to_regs()
    get_kernel_params(offsets_of_kernel_params, offset_num)
