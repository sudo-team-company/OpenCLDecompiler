import re


def get_global_data_bytes(row, set_of_global_data_bytes):
    line_of_bytes = row.split()
    if line_of_bytes.pop(0) == ".fill":
        amount = line_of_bytes[0][:-1]
        value = line_of_bytes[2]
        expand_list = [value for _ in range(int(amount))]
        set_of_global_data_bytes += expand_list
    else:
        for i, elem in enumerate(line_of_bytes):
            line_of_bytes[i] = re.sub(",", "", elem)
        set_of_global_data_bytes += line_of_bytes
    return set_of_global_data_bytes


def parse_kernel(text):
    status_of_parse = "start"
    set_of_instructions = []
    set_of_global_data_instruction = []
    set_of_config = []
    set_of_global_data_bytes = []
    name_of_program = ""
    for row in text:
        row = re.sub(r"/\*(.*?)\*/", "", row)
        row = row.strip()
        if ".kernel " in row:
            if status_of_parse == "instruction":
                status_of_parse = "kernel"
                yield (name_of_program, set_of_config, set_of_instructions,
                       set_of_global_data_bytes, set_of_global_data_instruction)
                set_of_instructions = []
                set_of_config = []
            name_of_program = row.split()[1]
        if row == ".config":
            status_of_parse = "config"
        elif row == ".text":
            status_of_parse = "instruction"
        elif row == ".gdata:":
            status_of_parse = "global_data"
        elif status_of_parse == "instruction":
            if ".gdata" in row:
                set_of_global_data_instruction.append(row)
            set_of_instructions.append(row)
        elif status_of_parse == "config":
            set_of_config.append(row)
        elif status_of_parse == "global_data":
            set_of_global_data_bytes = \
                get_global_data_bytes(row, set_of_global_data_bytes)
    yield name_of_program, set_of_config, set_of_instructions, \
          set_of_global_data_bytes, set_of_global_data_instruction
