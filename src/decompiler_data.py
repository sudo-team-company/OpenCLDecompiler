from src.state import State
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.type_of_flag import TypeOfFlag
from src.opencl_types import make_type


def check_reg_for_val(node, register):
    register_flag = True
    if "s" in register or "v" in register:
        new_val = node.state.registers[register].val
    else:
        new_val = register
        register_flag = False
    return new_val, register_flag


def make_op(node, register0, register1, operation, type0, type1):
    new_val0, register0_flag = check_reg_for_val(node, register0)
    new_val1, register1_flag = check_reg_for_val(node, register1)
    if "-" in new_val0 or "+" in new_val0 or "*" in new_val0 or "/" in new_val0:
        new_val0 = "(" + new_val0 + ")"
    if "-" in new_val1 or "+" in new_val1 or "*" in new_val1 or "/" in new_val1:
        new_val1 = "(" + new_val1 + ")"
    new_val0 = type0 + new_val0
    new_val1 = type1 + new_val1
    if len(type0) > 0 and ')' not in type0:
        new_val0 += ')'
    if len(type1) > 0 and ')' not in type1:
        new_val1 += ')'
    new_val = new_val0 + operation + new_val1
    return new_val, register0_flag, register1_flag


class Singleton(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            instance = super().__call__(*args, **kwargs)
            cls._instances[cls] = instance
        return cls._instances[cls]


class DecompilerData(metaclass=Singleton):
    def __init__(self):
        self.output_file = ""
        self.usesetup = False
        self.size_of_work_groups = []
        self.cfg = None
        self.improve_cfg = None
        self.number_of_temp = 0
        # versions for asm code if decompilation is not success
        # (версии для ассемблерного кода в случае отсутствия перевода)
        self.number_of_shift = 0
        self.number_of_length = 0
        self.number_of_mask = 0
        self.number_of_cc = 0
        self.number_of_sf0 = 0
        self.number_of_sf1 = 0
        self.number_of_sf2 = 0
        self.number_of_tmp = 0
        self.number_of_v0 = 0
        self.number_of_v1 = 0
        self.number_of_v = 0
        self.number_of_vm = 0
        self.number_of_p = 0
        self.initial_state = State()  # start state of registers (начальное состояние регистров)
        self.sgprsnum = 0  # number of s registers used by system (количество s регистров, используемых системой)
        self.vgprsnum = 0  # number of v registers used by system (количество v регистров, используемых системой)
        self.params = {}
        self.to_node = {}  # the label at which the block starts -> node (метка, с которой начинается блок -> вершина)
        self.from_node = {}
        # the label the vertex is expecting -> node (метка, которую ожидает вершина -> вершина ("лист ожидания"))
        self.starts_regions = {}  # Node or Region -> Region
        self.ends_regions = {}  # Node or Region -> Region
        self.label = None
        self.parents_of_label = []
        self.flag_of_else = False
        self.version_wait = None
        self.type_params = {}
        self.type_gdata = {}
        self.variables = {}
        self.checked_variables = {}
        self.kernel_params = {}
        self.global_data = {}
        self.versions = {
            "s0": 0,
            "s1": 0,
            "s2": 0,
            "s3": 0,
            "s4": 0,
            "s5": 0,
            "s6": 0,
            "s7": 0,
            "s8": 0,
            "s9": 0,
            "s10": 0,
            "s11": 0,
            "s12": 0,
            "s13": 0,
            "s14": 0,
            "s15": 0,
            "s16": 0,
            "s17": 0,
            "s18": 0,
            "s19": 0,
            "s20": 0,
            "s21": 0,
            "s22": 0,
            "v0": 0,
            "v1": 0,
            "v2": 0,
            "v3": 0,
            "v4": 0,
            "v5": 0,
            "v6": 0,
            "v7": 0,
            "v8": 0,
            "v9": 0,
            "v10": 0,
            "v11": 0,
            "v12": 0,
            "v13": 0,
            "v14": 0,
            "v15": 0,
            "v16": 0,
            "v17": 0,
            "v18": 0,
            "v19": 0,
            "v20": 0,
            "pc": 0,
            "scc": 0,
            "vcc": 0,
            "exec": 0
        }
        self.names_of_vars = {}
        self.localsize = 0
        self.lds_vars = {}
        self.lds_var_number = 0
        self.num_of_var = 0
        self.num_of_label = 0
        self.wait_labels = []
        self.circles = []
        self.back_edges = []
        self.circles_variables = {}
        self.circles_nodes_for_variables = {}
        self.configuration_output = ""
        self.flag_for_decompilation = None

    def reset(self, output_file, flag_for_decompilation):
        self.output_file = output_file
        self.usesetup = False
        self.size_of_work_groups = []
        self.cfg = None
        self.improve_cfg = None
        self.number_of_temp = 0
        # versions for asm code if decompilation is not success
        # (версии для ассемблерного кода в случае отсутствия перевода)
        self.number_of_shift = 0
        self.number_of_length = 0
        self.number_of_mask = 0
        self.number_of_cc = 0
        self.number_of_sf0 = 0
        self.number_of_sf1 = 0
        self.number_of_sf2 = 0
        self.number_of_tmp = 0
        self.number_of_v0 = 0
        self.number_of_v1 = 0
        self.number_of_v = 0
        self.number_of_vm = 0
        self.number_of_p = 0
        self.initial_state = State()  # start state of registers (начальное состояние регистров)
        self.sgprsnum = 0  # number of s registers used by system (количество s регистров, используемых системой)
        self.vgprsnum = 0  # number of v registers used by system (количество v регистров, используемых системой)
        self.params = {}
        self.to_node = {}  # the label at which the block starts -> node (метка, с которой начинается блок -> вершина)
        self.from_node = {}
        # the label the vertex is expecting -> node (метка, которую ожидает вершина -> вершина ("лист ожидания"))
        self.starts_regions = {}  # Node or Region -> Region
        self.ends_regions = {}  # Node or Region -> Region
        self.label = None
        self.parents_of_label = []
        self.flag_of_else = False
        self.version_wait = None
        self.type_params = {}
        self.type_gdata = {}
        self.variables = {}
        self.checked_variables = {}
        self.kernel_params = {}
        self.global_data = {}
        self.versions = {
            "s0": 0,
            "s1": 0,
            "s2": 0,
            "s3": 0,
            "s4": 0,
            "s5": 0,
            "s6": 0,
            "s7": 0,
            "s8": 0,
            "s9": 0,
            "s10": 0,
            "s11": 0,
            "s12": 0,
            "s13": 0,
            "s14": 0,
            "s15": 0,
            "s16": 0,
            "s17": 0,
            "s18": 0,
            "s19": 0,
            "s20": 0,
            "s21": 0,
            "s22": 0,
            "v0": 0,
            "v1": 0,
            "v2": 0,
            "v3": 0,
            "v4": 0,
            "v5": 0,
            "v6": 0,
            "v7": 0,
            "v8": 0,
            "v9": 0,
            "v10": 0,
            "v11": 0,
            "v12": 0,
            "v13": 0,
            "v14": 0,
            "v15": 0,
            "v16": 0,
            "v17": 0,
            "v18": 0,
            "v19": 0,
            "v20": 0,
            "pc": 0,
            "scc": 0,
            "vcc": 0,
            "exec": 0
        }
        self.names_of_vars = {}
        self.localsize = 0
        self.lds_vars = {}
        self.lds_var_number = 0
        self.num_of_var = 0
        self.num_of_label = 0
        self.wait_labels = []
        self.circles = []
        self.back_edges = []
        self.circles_variables = {}
        self.circles_nodes_for_variables = {}
        self.configuration_output = ""
        if flag_for_decompilation == "auto_decompilation":
            self.flag_for_decompilation = TypeOfFlag.auto_decompilation
        elif flag_for_decompilation == "only_opencl":
            self.flag_for_decompilation = TypeOfFlag.only_opencl
        else:
            self.flag_for_decompilation = TypeOfFlag.only_clrx

    def write(self, output):
        # noinspection PyUnresolvedReferences
        self.output_file.write(output)

    def evaluate_from_hex(self, global_data, size):
        typed_global_data = []
        for element in range(int(len(global_data) / size)):
            array_of_bytes = global_data[element * size: element * size + size]
            string_of_bytes = ''.join(elem[2:] + ' ' for elem in array_of_bytes)
            value = int("".join(string_of_bytes.split()[::-1]), 16)
            typed_global_data.append(value)
        return typed_global_data

    def write_global_data(self):
        for key, var in self.type_gdata.items():
            if var == 'uint' or var == 'int':
                list_of_gdata_values = self.evaluate_from_hex(self.global_data[key], 4)
            else:
                list_of_gdata_values = self.evaluate_from_hex(self.global_data[key], 8)
            self.write("__constant " + var + " " + key + "[] = {")
            for index, element in enumerate(list_of_gdata_values):
                if index:
                    self.write(', ' + str(element))
                else:
                    self.write(str(element))
            self.write("};\n")

    def make_version(self, state, reg):
        if reg not in self.versions:
            self.versions[reg] = 0
        state.registers[reg].add_version(reg, self.versions[reg])
        self.versions[reg] += 1

    def init_work_group(self, dimensions, usesetup):
        self.usesetup = usesetup
        if usesetup:
            g_id = ["s8", "s9", "s10"]
        else:
            g_id = ["s6", "s7", "s8"]
        if ',' in dimensions:
            dimensions = dimensions.split(',')
            max_dim = dimensions[0]
            for dim in dimensions:
                if len(dim) > len(max_dim):
                    max_dim = dim
            dimensions = max_dim
        for dim in range(len(dimensions)):
            g_id_dim = g_id[dim]
            v_dim = "v" + str(dim)
            self.initial_state.init_work_group(dim, g_id_dim, self.versions[g_id_dim], self.versions[v_dim])
            self.versions[g_id_dim] += 1
            self.versions[v_dim] += 1

    def process_initial_state(self):
        if self.usesetup:
            self.initial_state.registers["s6"] = Register("s6", Type.arguments_pointer, Integrity.low_part)
            self.initial_state.registers["s6"].add_version("s6", self.versions["s6"])
            self.versions["s6"] += 1
            self.initial_state.registers["s7"] = Register("s7", Type.arguments_pointer, Integrity.high_part)
            self.initial_state.registers["s7"].add_version("s7", self.versions["s7"])
            self.versions["s7"] += 1
        else:
            self.initial_state.registers["s4"] = Register("s4", Type.arguments_pointer, Integrity.low_part)
            self.initial_state.registers["s4"].add_version("s4", self.versions["s4"])
            self.versions["s4"] += 1
            self.initial_state.registers["s5"] = Register("s5", Type.arguments_pointer, Integrity.high_part)
            self.initial_state.registers["s5"].add_version("s5", self.versions["s5"])
            self.versions["s5"] += 1

    def make_params(self, num_of_param, name_param, type_param):
        self.params["param" + str(num_of_param)] = name_param
        self.type_params[name_param] = type_param

    def process_size_of_work_groups(self, cws, set_of_config_1):
        if cws:
            self.size_of_work_groups = set_of_config_1.replace(',', ' ').split()[1:]
            self.configuration_output += "__kernel __attribute__((reqd_work_group_size(" \
                + self.size_of_work_groups[0] + ", " + self.size_of_work_groups[1] \
                + ", " + self.size_of_work_groups[2] + ")))\n"
        else:
            self.configuration_output += "__kernel "

    def process_local_size(self, localsize, set_of_config_4):
        if localsize:
            self.localsize = int(set_of_config_4[11:])

    def remove_unusable_versions(self):
        keys = []
        for key in self.variables:
            if self.variables[key] not in self.names_of_vars:
                keys.append(key)
        for key in keys:
            self.variables.pop(key)

    def update_reg_version(self, prev_versions_of_reg, variable, curr_node, reg, max_version):
        self.num_of_var += 1
        for prev_version in prev_versions_of_reg:
            self.variables[prev_version] = variable
        self.checked_variables[curr_node.state.registers[reg].version] = variable
        self.versions[reg] = max_version + 1

    def set_name_of_vars(self, var_name, type_of_var):
        self.names_of_vars[var_name] = type_of_var

    def check_lds_vars(self, offset, suffix):
        if self.lds_vars.get(offset) is None:
            self.lds_vars[offset] = ["lds" + str(self.lds_var_number), "u" + suffix[1:]]
            self.lds_var_number += 1

    def make_var(self, register_version, variable, type_of_data):
        self.num_of_var += 1
        self.variables[register_version] = variable
        self.names_of_vars[variable] = type_of_data

    def set_starts_regions(self, node, region):
        self.starts_regions[node] = region

    def set_ends_regions(self, node, region):
        self.ends_regions[node] = region

    def set_parent_for_starts_regions(self, child, region):
        self.starts_regions[child].add_parent(region)

    def set_flag_of_else(self, flag):
        self.flag_of_else = flag

    def set_cfg(self, node):
        self.cfg = node

    def set_to_node(self, label, node):
        self.to_node[label] = node

    def add_to_kernel_params(self, key, val):
        if self.kernel_params.get(key) is None:
            self.kernel_params[key] = []
        self.kernel_params[key].append(val)

    def increase_num_of_label(self):
        self.num_of_label += 1

    def make_label(self, node):
        self.label = node
        self.parents_of_label = node.parent
        self.flag_of_else = True

    def change_cfg_for_else_structure(self, instruction, curr_node, from_node):
        self.from_node[instruction[1]].remove(curr_node)
        if self.from_node.get(from_node) is None:
            self.from_node[from_node] = []
        for parents_of_label in self.parents_of_label:
            if parents_of_label != self.parents_of_label[1]:
                self.from_node[from_node].append(parents_of_label)
        self.flag_of_else = False

    def to_fill_node(self, node, instruction):
        reladdr = instruction[1]
        if self.to_node.get(reladdr) is not None:
            node.add_child(self.to_node[reladdr])
            self.to_node[reladdr].add_parent(node)
            self.circles.append(self.to_node[reladdr])
            self.back_edges.append(node)
        else:
            if self.from_node.get(reladdr) is None:
                self.from_node[reladdr] = [node]
            else:
                self.from_node[reladdr].append(node)
        return node
