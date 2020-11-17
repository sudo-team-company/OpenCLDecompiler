from src.decompiler_data import DecompilerData


def process_dimensions(set_of_config):
    decompiler_data = DecompilerData()
    dimensions = set_of_config[0][6:]
    usesetup = ".usesetup" in set_of_config
    decompiler_data.init_work_group(dimensions, usesetup)


def process_params(set_of_config, name_of_program):
    decompiler_data = DecompilerData()
    parameters = set_of_config[17:]
    for num_of_setting, set_of_config_num in enumerate(set_of_config):
        if ".arg" in set_of_config_num and "_." not in set_of_config_num:
            parameters = set_of_config[num_of_setting:]
            break
    decompiler_data.write("void " + name_of_program + "(")
    num_of_param = 0
    flag_start = False
    for param in parameters:
        if not flag_start:
            flag_start = True
        else:
            decompiler_data.write(", ")
        set_of_param = param.strip().replace(',', ' ').split()
        name_param = set_of_param[1]
        type_param = set_of_param[3]
        flag_param = ""
        if len(set_of_param) > 4:
            flag_param = "__" + set_of_param[4] + " "
        if type_param[-1] == "*":
            name_param = "*" + name_param
            type_param = type_param[:-1]
        decompiler_data.make_params(num_of_param, name_param, type_param)
        decompiler_data.write(flag_param + type_param + " " + name_param)
        num_of_param += 1
    decompiler_data.write(")\n")


def process_size_of_work_groups(set_of_config):
    decompiler_data = DecompilerData()
    cws = ".cws" in set_of_config[1]
    decompiler_data.process_size_of_work_groups(cws, set_of_config[1])


def process_local_size(set_of_config):
    decompiler_data = DecompilerData()
    localsize = "localsize" in set_of_config[4]
    decompiler_data.process_local_size(localsize, set_of_config[4])


def process_config(set_of_config, name_of_program):
    decompiler_data = DecompilerData()
    process_dimensions(set_of_config)
    process_size_of_work_groups(set_of_config)
    # decompiler_data.sgprsnum = int(set_of_config[2][10:])
    # decompiler_data.vgprsnum = int(set_of_config[3][10:])
    process_local_size(set_of_config)
    decompiler_data.process_initial_state()
    process_params(set_of_config, name_of_program)
