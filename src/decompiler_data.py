import binascii
import struct
from typing import Optional

import sympy

from src.flag_type import FlagType
from src.integrity import Integrity
from src.register import Register, is_reg, is_range, check_and_split_regs
from src.register_type import RegisterType
from src.state import State
from src.utils import ConfigData, DriverFormat


def set_reg_value(node, new_value, to_reg, from_regs, data_type,
                  reg_type=RegisterType.UNKNOWN, reg_entire=Integrity.ENTIRE):
    decompiler_data = DecompilerData()
    node.state.registers[to_reg] = Register(new_value, reg_type, reg_entire)
    decompiler_data.make_version(node.state, to_reg)
    if to_reg in from_regs:
        node.state.registers[to_reg].make_prev()
    node.state.registers[to_reg].data_type = data_type
    return node


def make_elem_from_addr(var):
    separator_pos = var.find(" + ")
    param_name = var[:separator_pos]
    index = var[separator_pos + 3:]
    var = param_name + "[" + index + "]"
    return var


# TODO: Проанализировать, может ли не быть "g" (или другого модификатора)
def make_new_type_without_modifier(node, register):
    if "g" in node.state.registers[register].data_type:
        new_from_reg_type = node.state.registers[register].data_type[1:]
    else:
        new_from_reg_type = node.state.registers[register].data_type
    return new_from_reg_type


def compare_values(node, to_reg, from_reg0, from_reg1, type0, type1, operation, suffix):
    new_value = make_op(node, from_reg0, from_reg1, operation, type0, type1)
    set_reg_value(node, new_value, to_reg, [from_reg0, from_reg1], suffix)
    return node


def simplify_opencl_statement(opencl_line):
    decompiler_data = DecompilerData()
    start_open = 0
    start_close = 0
    new_line = ""
    while True:
        open_bracket_position = opencl_line.find('[', start_open + 1)
        close_bracket_position = opencl_line.find(']', start_close + 1)
        if open_bracket_position == -1:
            break
        substring = opencl_line[open_bracket_position + 1:close_bracket_position]
        current_type_conversion = {}
        for key, data_type in decompiler_data.type_conversion.items():
            if data_type + key in substring:
                current_type_conversion[key] = data_type
        for key, data_type in current_type_conversion.items():
            substring = substring.replace(data_type, '')
        if substring != '':
            substring = sympy.simplify(substring)
            substring = sympy.sstr(substring)
        # doesn't recover type (int)A in case (int)(A + B) - B
        for key, data_type in current_type_conversion.items():
            if key in substring:
                substring = substring.replace(key, data_type + key)
        # recover all left symbols from [
        if start_close == 0:
            new_line += opencl_line[start_close:open_bracket_position + 1]
        else:
            new_line += opencl_line[start_close + 1:open_bracket_position + 1]
        new_line += substring + ']'
        start_open = open_bracket_position
        start_close = close_bracket_position
    if start_close != 0:
        new_line += opencl_line[start_close + 1:]
    else:
        new_line = opencl_line
    return new_line


# gdata0[get_local_id(0)] -> gdata0
def get_name(key):
    position_gdata = key.find('gdata')
    previous_position = position_gdata
    while position_gdata + 5 < len(key) and '0' <= key[position_gdata + 5] <= '9':
        position_gdata += 1
    return key[previous_position:position_gdata + 5]


def optimize_names_of_vars():
    decompiler_data = DecompilerData()
    new_names_of_vars = {}
    # remove gdata element access (gdata[...] -> gdata)
    for key, val in decompiler_data.names_of_vars.items():
        if 'gdata' in key:
            name = get_name(key)
            new_names_of_vars[name] = val
        elif 'var' in key:
            new_names_of_vars[key] = val
    decompiler_data.names_of_vars = new_names_of_vars
    for key, val in decompiler_data.var_value.items():
        if 'gdata' in val:
            new_val = get_name(val)
            decompiler_data.var_value[key] = new_val


# TODO: разобраться, как перейти к общему случаю
def check_big_values(node, start_register, end_register):
    if node.state.registers[start_register].val == '0xa2000000' \
            and node.state.registers[end_register].val == '0x426d1a94':
        return True, "1e12"
    return False, 0


def check_reg_for_val(node, register):
    if is_reg(register) or is_range(register):  # TODO: Выяснить зачем нужен range
        if node.state.registers.get(register):
            new_val = node.state.registers[register].val
        else:
            if is_range(register):
                start_register, end_register = check_and_split_regs(register)
                flag_big_value, value = check_big_values(node, start_register, end_register)
                if flag_big_value:
                    new_val = value
                else:
                    new_val = node.state.registers[start_register].val
            else:
                raise NotImplementedError
    else:
        new_val = register
    return new_val


def change_vals_for_make_op(node, register, reg_type, operation):
    decompiler_data = DecompilerData()
    new_val = check_reg_for_val(node, register)
    if (operation != " + " or reg_type) and ("-" in new_val or "+" in new_val or "*" in new_val or "/" in new_val):
        new_val = "(" + new_val + ")"
    if reg_type != '':
        decompiler_data.type_conversion[new_val] = reg_type
    new_val = reg_type + new_val
    if len(reg_type) > 0 and ')' not in reg_type:
        new_val += ')'
    return new_val


def make_op(node, register0, register1, operation, type0='', type1=''):
    new_val0 = change_vals_for_make_op(node, register0, type0, operation)
    new_val1 = change_vals_for_make_op(node, register1, type1, operation)
    new_val = new_val0 + operation + new_val1
    return new_val


def evaluate_from_hex(global_data, size, flag):
    typed_global_data = []
    for element in range(int(len(global_data) / size)):
        array_of_bytes = global_data[element * size: element * size + size]
        string_of_bytes = ''.join(elem[2:] + '' for elem in array_of_bytes)
        # output binascii.unhexlify is byteset from string; struct.unpack encode byte to value.
        value = struct.unpack(flag, binascii.unhexlify(string_of_bytes))[0]
        typed_global_data.append(str(value))
    return typed_global_data


class Singleton(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            instance = super().__call__(*args, **kwargs)
            cls._instances[cls] = instance
        return cls._instances[cls]


class DecompilerData(metaclass=Singleton):
    def __init__(self):
        self.name_of_program = None
        self.config_data: Optional[ConfigData] = None
        self.driver_format: DriverFormat = DriverFormat.UNKNOWN
        self.output_file = None
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
        self.number_of_qword = 0
        self.number_of_choice = 0
        self.number_of_result = 0
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
        self.var_value = {}  # var -> value
        self.type_conversion = {}  # expression -> type_conversion (get_global_id(0) -> (ulong))
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
        self.lds_vars = {}
        self.lds_var_number = 0
        self.num_of_var = 0
        self.num_of_label = 0
        self.wait_labels = []
        self.loops = []
        self.back_edges = []
        self.loops_variables = {}
        self.loops_nodes_for_variables = {}
        self.flag_for_decompilation = None
        self.address_params = set()
        self.bfe_offsets = {}

    def reset(self, name_of_program):
        self.name_of_program = name_of_program
        self.config_data = None
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
        self.number_of_qword = 0
        self.number_of_choice = 0
        self.number_of_result = 0
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
        self.var_value = {}
        self.type_conversion = {}
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
        self.lds_vars = {}
        self.lds_var_number = 0
        self.num_of_var = 0
        self.num_of_label = 0
        self.wait_labels = []
        self.loops = []
        self.back_edges = []
        self.loops_variables = {}
        self.loops_nodes_for_variables = {}
        self.address_params = set()
        self.bfe_offsets = {}

    def write(self, output):
        # noinspection PyUnresolvedReferences
        if self.flag_for_decompilation != FlagType.ONLY_CLRX and "Not resolved yet. " not in output:
            output = simplify_opencl_statement(output)
            output = output.replace("___", ".")
        self.output_file.write(output)

    def make_version(self, state, reg):
        if reg not in self.versions:
            self.versions[reg] = 0
        state.registers[reg].add_version(reg, self.versions[reg])
        self.versions[reg] += 1

    def init_work_group(self):
        dimensions = self.config_data.dimensions
        g_id = ["s8", "s9", "s10"] if self.config_data.usesetup else ["s6", "s7", "s8"]
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
        lp, hp = ("s6", "s7") if self.config_data.usesetup else ("s4", "s5")
        self.initial_state.registers[lp] = Register("0", RegisterType.ARGUMENTS_POINTER, Integrity.LOW_PART)
        self.make_version(self.initial_state, lp)
        self.initial_state.registers[hp] = Register("0", RegisterType.ARGUMENTS_POINTER, Integrity.HIGH_PART)
        self.make_version(self.initial_state, hp)
        if self.config_data.usesetup:
            self.initial_state.registers["s4"] = Register("0", RegisterType.DISPATCH_POINTER, Integrity.LOW_PART)
            self.make_version(self.initial_state, "s4")
            self.initial_state.registers["s5"] = Register("0", RegisterType.DISPATCH_POINTER, Integrity.HIGH_PART)
            self.make_version(self.initial_state, "s5")

    def make_params(self, num_of_param, name_param, type_param):
        self.params["param" + str(num_of_param)] = name_param
        self.type_params[name_param] = type_param

    def set_config_data(self, config_data: ConfigData):
        self.config_data = config_data
        self.init_work_group()
        self.process_initial_state()
        for num_of_param, (type_param, name_param) in enumerate(self.config_data.params):
            self.make_params(num_of_param, name_param, type_param)

    def get_function_definition(self) -> str:
        definition: str = "__kernel "

        if self.config_data.size_of_work_groups:
            size_of_work_groups = ", ".join(map(str, self.config_data.size_of_work_groups))
            definition += f"__attribute__((reqd_work_group_size({size_of_work_groups})))\n"

        params = ", ".join([f"{ptype} {pname}" for ptype, pname in self.config_data.params])
        definition += f"void {self.name_of_program}({params})\n"

        return definition

    def remove_unusable_versions(self):
        keys = []
        for key, variable in self.variables.items():
            if variable not in self.names_of_vars:
                keys.append(key)
        for key in keys:
            self.variables.pop(key)

    def update_reg_version(self, prev_versions_of_reg, variable, curr_node, reg, max_version):
        self.num_of_var += 1
        for prev_version in prev_versions_of_reg:
            self.variables[prev_version] = variable
        self.checked_variables[curr_node.state.registers[reg].version] = variable
        self.versions[reg] = max_version + 1

    def set_name_of_vars(self, var_name, data_type):
        self.names_of_vars[var_name] = data_type

    def check_lds_vars(self, offset, suffix):
        if self.lds_vars.get(offset) is None:
            self.lds_vars[offset] = ["lds" + str(self.lds_var_number), "u" + suffix[1:]]
            self.lds_var_number += 1

    def make_var(self, register_version, variable, data_type):
        self.num_of_var += 1
        self.variables[register_version] = variable
        self.names_of_vars[variable] = data_type

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

    def change_cfg_for_else_structure(self, instruction, curr_node, from_node):
        self.from_node[instruction[1]].remove(curr_node)
        if self.from_node.get(from_node) is None:
            self.from_node[from_node] = []
        for parents_of_label in self.parents_of_label:
            if parents_of_label != self.parents_of_label[1]:
                self.from_node[from_node].append(parents_of_label)
        self.flag_of_else = False

    def to_fill_branch_node(self, node, instruction):
        reladdr = instruction[1]
        if self.to_node.get(reladdr) is not None:
            node.add_child(self.to_node[reladdr])
            self.to_node[reladdr].add_parent(node)
            self.loops.append(self.to_node[reladdr])
            self.back_edges.append(node)
        else:
            if self.from_node.get(reladdr) is None:
                self.from_node[reladdr] = [node]
            else:
                self.from_node[reladdr].append(node)
        return node
