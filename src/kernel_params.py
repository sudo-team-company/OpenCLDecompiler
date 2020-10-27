from src.decompiler_data import DecompilerData


def process_two_regs(num_of_param, first_reg, second_reg):
    decompiler_data = DecompilerData()
    changes_registers = []
    if decompiler_data.params["param" + str(num_of_param)][0] != '*':
        changes_registers.append((first_reg, decompiler_data.params["param" + str(num_of_param)]))
        changes_registers.append((second_reg, decompiler_data.params["param" + str(num_of_param + 1)]))
        add_num = 2
    else:
        changes_registers.append((first_reg, decompiler_data.params["param" + str(num_of_param)]))
        changes_registers.append((second_reg, decompiler_data.params["param" + str(num_of_param)]))
        add_num = 1
    return changes_registers, add_num


def process_dwordx2(list_instruction, num_of_param):
    registers = list_instruction[1]
    name_of_register = registers[0]
    num_of_first_reg = int(registers[2:registers.find(':')])
    first_reg = name_of_register + str(num_of_first_reg)
    second_reg = name_of_register + str(num_of_first_reg + 1)
    changes_registers, add_num = process_two_regs(num_of_param, first_reg, second_reg)
    return changes_registers, add_num


def process_dwordx4(list_instruction, num_of_param):
    registers = list_instruction[1]
    name_of_register = registers[0]
    num_of_first_reg = int(registers[2:registers.find(':')])
    first_reg = name_of_register + str(num_of_first_reg)
    second_reg = name_of_register + str(num_of_first_reg + 1)
    changes_registers, add_num_1 = process_two_regs(num_of_param, first_reg, second_reg)
    third_reg = name_of_register + str(num_of_first_reg + 2)
    fourth_reg = name_of_register + str(num_of_first_reg + 3)
    add_changes, add_num_2 = process_two_regs(num_of_param + 2, third_reg, fourth_reg)
    changes_registers.extend(add_changes)
    add_num = add_num_1 + add_num_2
    return changes_registers, add_num


def get_offsets_to_regs():
    decompiler_data = DecompilerData()
    offset_num = {}
    for param in sorted(decompiler_data.params.keys()):
        num_of_param = param[5:]
        if num_of_param == '0':
            offset_num['0x30'] = num_of_param
        else:
            last_offset = sorted(offset_num.keys())[-1]
            last_num = offset_num[last_offset]
            last_name = decompiler_data.params["param" + last_num]
            if last_name[0] == '*':
                if last_offset[-1] == '0':
                    offset_num[last_offset[:-1] + '8'] = num_of_param
                elif last_offset[-1] == '8':
                    curr_offset = '0x' + str(int(last_offset[2:]) + 2)
                    offset_num[curr_offset] = num_of_param
            else:
                curr_name = decompiler_data.params["param" + num_of_param]
                if curr_name[0] == "*":
                    if last_offset[-1] < '8':
                        offset_num[last_offset[:-1] + '8'] = num_of_param
                    else:
                        curr_offset = '0x' + str(int(last_offset[2:]) + 2)
                        offset_num[curr_offset] = num_of_param
                else:
                    if last_offset[-1] == '0':
                        offset_num[last_offset[:-1] + '4'] = num_of_param
                    elif last_offset[-1] == '4':
                        offset_num[last_offset[:-1] + '8'] = num_of_param
                    elif last_offset[-1] == '8':
                        offset_num[last_offset[:-1] + 'c'] = num_of_param
                    elif last_offset[-1] == 'c':
                        curr_offset = '0x' + str(int(last_offset[2:]) + 2)
                        offset_num[curr_offset] = num_of_param
    return offset_num


def process_kernel_params(set_of_instructions):
    decompiler_data = DecompilerData()
    offsets_of_kernel_params = {}
    for instruction in set_of_instructions:
        list_instruction = instruction.strip().replace(',', ' ').split()
        if list_instruction[0].find("s_load_dword") != -1 and len(list_instruction[3]) == 4 \
                and list_instruction[3] >= '0x30':
            offsets_of_kernel_params[list_instruction[3]] = list_instruction
    offset_num = get_offsets_to_regs()
    for key in sorted(offsets_of_kernel_params.keys()):
        offset = offsets_of_kernel_params[key][3]
        instr = offsets_of_kernel_params[key][0]
        if instr[-1] == 'd':
            decompiler_data.kernel_params[offset] = [(offsets_of_kernel_params[key][1],
                                                      decompiler_data.params["param" + offset_num[offset]])]

        elif instr[-1] == '2':
            decompiler_data.kernel_params[offset], _ = \
                process_dwordx2(offsets_of_kernel_params[key], offset_num[offset])

        elif instr[-1] == '4':
            decompiler_data.kernel_params[offset], _ = \
                process_dwordx4(offsets_of_kernel_params[key], offset_num[offset])
