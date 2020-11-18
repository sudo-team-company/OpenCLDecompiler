from src.decompiler_data import DecompilerData


def change_to_normal_offset(offset):
    changed_to_letter = {10: 'a', 11: 'b', 12: 'c', 13: 'd', 14: 'e', 15: 'f'}
    if len(offset[2:]) > 2:
        offset = '0x' + changed_to_letter[int(offset[2:-1])] + offset[-1]
    return offset


def helper_for_get_offset(last_offset):
    if 'a' <= last_offset[2:-1] <= 'z':
        return '0x' + chr(ord(last_offset[2:-1]) + 1) + '0'
    return '0x' + str(int(last_offset[2:-1]) + 1) + '0'


def get_current_offset_for_not_first_param(offset_num, last_name, name_of_param, num_of_param):
    decompiler_data = DecompilerData()
    last_offset = sorted(offset_num.keys())[-1]
    if last_name[0] == '*':
        if last_offset[-1] == '0':
            curr_offset = change_to_normal_offset(last_offset[:-1] + '8')
        else:  # last_offset[-1] == '8':
            curr_offset = change_to_normal_offset(helper_for_get_offset(last_offset))

    else:
        if name_of_param[0] == "*" \
                or 'long' in decompiler_data.type_params.get(decompiler_data.params["param" + num_of_param]):
            if last_offset[-1] < '8':
                curr_offset = last_offset[:-1] + '8'
            else:
                curr_offset = change_to_normal_offset(helper_for_get_offset(last_offset))
        else:
            if last_offset[-1] == '0':
                curr_offset = change_to_normal_offset(last_offset[:-1] + '4')
            elif last_offset[-1] == '4':
                curr_offset = change_to_normal_offset(last_offset[:-1] + '8')
            elif last_offset[-1] == '8':
                curr_offset = change_to_normal_offset(last_offset[:-1] + 'c')
            else:  # if last_offset[-1] == 'c':
                curr_offset = change_to_normal_offset(helper_for_get_offset(last_offset))
    return curr_offset


def get_offsets_to_regs():
    decompiler_data = DecompilerData()
    offset_num = {}
    data_of_param = []
    for num_of_param in range(len(decompiler_data.params)):
        num_of_param = str(num_of_param)
        name_of_param = decompiler_data.params["param" + num_of_param]
        type_of_param = decompiler_data.type_params.get(name_of_param)
        if type_of_param[-1] == '8':
            for i in range(8):
                data_of_param.append([num_of_param, name_of_param + '.s' + str(i), type_of_param])
        else:
            data_of_param.append([num_of_param, name_of_param, type_of_param])
    visited = False
    for num_of_param, name_of_param, type_of_param in data_of_param:
        if num_of_param == '0' and not visited:
            offset_num['0x30'] = name_of_param
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
    offsets_of_kernel_params = {}
    for instruction in set_of_instructions:
        list_instruction = instruction.strip().replace(',', ' ').split()
        if "s_load_dword" in list_instruction[0] and len(list_instruction[3]) == 4 \
                and list_instruction[3] >= '0x30':
            offsets_of_kernel_params[list_instruction[3]] = list_instruction
    offset_num = get_offsets_to_regs()
    get_kernel_params(offsets_of_kernel_params, offset_num)
