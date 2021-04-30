from src.decompiler_data import DecompilerData


def get_gdata_offset(instruction):
    position = instruction.find("(.gdata+")
    if position == -1:
        return 0
    end_position = instruction.find(")", position)
    return int(instruction[position + 8:end_position])


def process_global_data(set_of_global_data_instruction, set_of_global_data_bytes):
    decompiler_data = DecompilerData()
    indexes = set()
    for instruction in sorted(set_of_global_data_instruction):
        offset = get_gdata_offset(instruction)
        indexes.add(offset)
        decompiler_data.type_gdata["gdata" + str(offset)] = 'undefined_type'
    list_of_indexes = list(sorted(indexes))
    list_of_indexes.append(-1)
    for index in range(len(list_of_indexes) - 1):
        decompiler_data.global_data["gdata" + str(list_of_indexes[index])] = \
            set_of_global_data_bytes[list_of_indexes[index]:list_of_indexes[index + 1]]
