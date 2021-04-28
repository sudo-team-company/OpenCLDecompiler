from src.decompiler_data import DecompilerData


def get_gdata_offset(instruction):
    position = instruction.find("(.gdata+")
    if position == -1:
        return 0
    else:
        end_position = instruction.find(")", position)
        return int(instruction[position + 8:end_position])


def get_gdata_number(instruction):
    position = instruction.find("gdata")
    if position == -1:
        return 0
    else:
        end_position = instruction.find("[", position)
        return int(instruction[position + 5:end_position])


def process_global_data(set_of_global_data_instruction, set_of_global_data_bytes):
    decompiler_data = DecompilerData()
    indexes = set()
    for instruction in sorted(set_of_global_data_instruction):
        if ".gdata" not in instruction:
            continue
        else:
            indexes.add(get_gdata_offset(instruction))
    # decompiler_data.process_initial_gdata()
    list_of_indexes = []
    for index in sorted(indexes):
        decompiler_data.type_gdata["gdata" + str(index)] = 'undefined_type'
        list_of_indexes.append(index)
    for index in range(len(list_of_indexes)):
        if index == len(list_of_indexes) - 1:
            decompiler_data.global_data["gdata" + str(list_of_indexes[index])] = \
                set_of_global_data_bytes[list_of_indexes[index]:]
        else:
            decompiler_data.global_data["gdata" + str(list_of_indexes[index])] = \
                set_of_global_data_bytes[list_of_indexes[index]:list_of_indexes[index + 1]]
