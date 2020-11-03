from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.decompiler_data import DecompilerData


def process_dimensions(set_of_config):
    decompiler_data = DecompilerData()
    dimensions = set_of_config[0][6:]
    g_id = ["s6", "s7", "s8"]
    if ".usesetup" in set_of_config:
        g_id = ["s8", "s9", "s10"]
        decompiler_data.usesetup = True
    if len(dimensions) > 0:
        decompiler_data.initial_state.registers[g_id[0]] = Register("get_group_id(0)", Type.work_group_id_x,
                                                                    Integrity.integer)
        decompiler_data.initial_state.registers[g_id[0]].add_version(g_id[0],
                                                                     decompiler_data.versions[g_id[0]])
        decompiler_data.versions[g_id[0]] += 1
        decompiler_data.initial_state.registers["v0"] = Register("get_local_id(0)", Type.work_item_id_x,
                                                                 Integrity.integer)
        decompiler_data.initial_state.registers["v0"].add_version("v0", decompiler_data.versions["v0"])
        decompiler_data.versions["v0"] += 1
    if len(dimensions) > 1:
        decompiler_data.initial_state.registers[g_id[1]] = Register("get_group_id(1)", Type.work_group_id_y,
                                                                    Integrity.integer)
        decompiler_data.initial_state.registers[g_id[1]].add_version(g_id[1],
                                                                     decompiler_data.versions[g_id[1]])
        decompiler_data.versions[g_id[1]] += 1
        decompiler_data.initial_state.registers["v1"] = Register("get_local_id(1)", Type.work_item_id_y,
                                                                 Integrity.integer)
        decompiler_data.initial_state.registers["v1"].add_version("v1", decompiler_data.versions["v1"])
        decompiler_data.versions["v1"] += 1
    if len(dimensions) > 2:
        decompiler_data.initial_state.registers[g_id[2]] = Register("get_group_id(2)", Type.work_group_id_z,
                                                                    Integrity.integer)
        decompiler_data.initial_state.registers[g_id[2]].add_version(g_id[2],
                                                                     decompiler_data.versions[g_id[2]])
        decompiler_data.versions[g_id[2]] += 1
        decompiler_data.initial_state.registers["v2"] = Register("get_local_id(2)", Type.work_item_id_z,
                                                                 Integrity.integer)
        decompiler_data.initial_state.registers["v2"].add_version("v2", decompiler_data.versions["v2"])
        decompiler_data.versions["v2"] += 1


def process_initial_state():
    decompiler_data = DecompilerData()
    if not decompiler_data.usesetup:
        decompiler_data.initial_state.registers["s4"] = Register("s4", Type.arguments_pointer, Integrity.low_part)
        decompiler_data.initial_state.registers["s4"].add_version("s4", decompiler_data.versions["s4"])
        decompiler_data.versions["s4"] += 1
        decompiler_data.initial_state.registers["s5"] = Register("s5", Type.arguments_pointer, Integrity.high_part)
        decompiler_data.initial_state.registers["s5"].add_version("s5", decompiler_data.versions["s5"])
        decompiler_data.versions["s5"] += 1
    else:
        decompiler_data.initial_state.registers["s6"] = Register("s6", Type.arguments_pointer, Integrity.low_part)
        decompiler_data.initial_state.registers["s6"].add_version("s6", decompiler_data.versions["s6"])
        decompiler_data.versions["s6"] += 1
        decompiler_data.initial_state.registers["s7"] = Register("s7", Type.arguments_pointer, Integrity.high_part)
        decompiler_data.initial_state.registers["s7"].add_version("s7", decompiler_data.versions["s7"])
        decompiler_data.versions["s7"] += 1


def process_params(set_of_config, name_of_program):
    decompiler_data = DecompilerData()
    parameters = set_of_config[17:]
    for num_of_setting in list(range(len(set_of_config))):
        if ".arg" in set_of_config[num_of_setting] and "_." not in set_of_config[num_of_setting]:
            parameters = set_of_config[num_of_setting:]
            break
    decompiler_data.output_file.write("void " + name_of_program + "(")
    num_of_param = 0
    flag_start = False
    for param in parameters:
        if not flag_start:
            flag_start = True
        else:
            decompiler_data.output_file.write(", ")
        set_of_param = param.strip().replace(',', ' ').split()
        name_param = set_of_param[1]
        type_param = set_of_param[3]
        flag_param = ""
        if len(set_of_param) > 4:
            flag_param = "__" + set_of_param[4] + " "
        if type_param[-1] == "*":
            name_param = "*" + name_param
            type_param = type_param[:-1]
        decompiler_data.params["param" + str(num_of_param)] = name_param
        decompiler_data.type_params[name_param] = type_param
        decompiler_data.output_file.write(flag_param + type_param + " " + name_param)
        num_of_param += 1
    decompiler_data.output_file.write(")\n")


def process_size_of_work_groups(set_of_config):
    decompiler_data = DecompilerData()
    if ".cws" in set_of_config[1]:
        decompiler_data.size_of_work_groups = set_of_config[1].replace(',', ' ').split()[1:]
        decompiler_data.output_file.write(
            "__kernel __attribute__((reqd_work_group_size(" + decompiler_data.size_of_work_groups[0] + ", "
            + decompiler_data.size_of_work_groups[1] + ", " + decompiler_data.size_of_work_groups[2] + ")))\n")
    else:
        decompiler_data.output_file.write("__kernel ")


def process_local_size(set_of_config):
    decompiler_data = DecompilerData()
    if "localsize" in set_of_config[4]:
        decompiler_data.localsize = int(set_of_config[4][11:])


def process_config(set_of_config, name_of_program):
    process_dimensions(set_of_config)
    process_size_of_work_groups(set_of_config)
    # decompiler_data.sgprsnum = int(set_of_config[2][10:])
    # decompiler_data.vgprsnum = int(set_of_config[3][10:])
    process_local_size(set_of_config)
    process_initial_state()
    process_params(set_of_config, name_of_program)
