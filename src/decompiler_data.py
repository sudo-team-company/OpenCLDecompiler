# pylint: disable=R0401

import binascii
import re
import struct
from typing import Optional, Union

import sympy

from src import utils
from src.combined_register_content import CombinedRegisterContent
from src.flag_type import FlagType
from src.integrity import Integrity
from src.logical_variable import ExecCondition
from src.node import Node
from src.opencl_types import evaluate_size, make_asm_type, make_opencl_type, vector_type_dict
from src.operation_register_content import OperationType, OperationRegisterContent
from src.register import Register, is_reg, is_range, check_and_split_regs, split_range
from src.register_content import RegisterContent, RegisterSignType
from src.register_type import RegisterType
from src.state import KernelState
from src.utils import ConfigData, Singleton


def set_reg_value(  # pylint: disable=R0913
        node,
        new_value,
        to_reg,
        from_regs,
        data_type,
        exec_condition=None,
        reg_type=RegisterType.UNKNOWN,
        integrity=Integrity.ENTIRE,
        register_content_type=RegisterContent,
        sign: Union[RegisterSignType, list[RegisterSignType]] = RegisterSignType.POSITIVE,
        operation: Optional[OperationType] = None,
        size: Optional[list[int]] = None,
):
    decompiler_data = DecompilerData()
    if register_content_type == RegisterContent:
        node.state[to_reg] = Register(
            integrity=integrity,
            register_content=RegisterContent(
                value=new_value,
                type_=reg_type,
                sign=sign,
                data_type=data_type,
            ),
        )
        node.state[to_reg].try_simplify()
    elif register_content_type == CombinedRegisterContent:
        node.state[to_reg] = Register(
            integrity=integrity,
            register_content=CombinedRegisterContent(
                register_contents=[
                    RegisterContent(
                        value=value,
                        type_=type_,
                        sign=sign_,
                        data_type=data_type_,
                        size=size_,
                    )
                    for value, type_, sign_, data_type_, size_ in zip(new_value, reg_type, sign, data_type, size)
                ]
            )
        )
    elif register_content_type == OperationRegisterContent:
        if not isinstance(sign, list):
            node.state[to_reg] = Register(
                integrity=integrity,
                register_content=OperationRegisterContent(
                    operation=operation,
                    register_contents=[
                        RegisterContent(
                            value=value,
                            type_=type_,
                            data_type=data_type,
                        )
                        for value, type_ in zip(new_value, reg_type)
                    ]
                ),
            )
        else:
            if isinstance(data_type, list):
                node.state[to_reg] = Register(
                    integrity=integrity,
                    register_content=OperationRegisterContent(
                        operation=operation,
                        register_contents=[
                            RegisterContent(
                                value=value,
                                type_=type_,
                                sign=sign_,
                                data_type=data_type_,
                            )
                            for value, type_, sign_, data_type_ in zip(new_value, reg_type, sign, data_type)
                        ]
                    ),
                )
            else:
                node.state[to_reg] = Register(
                    integrity=integrity,
                    register_content=OperationRegisterContent(
                        operation=operation,
                        register_contents=[
                            RegisterContent(
                                value=value,
                                type_=type_,
                                sign=sign_,
                                data_type=data_type,
                            )
                            for value, type_, sign_ in zip(new_value, reg_type, sign)
                        ]
                    ),
                )
    else:
        raise NotImplementedError()

    node.state[to_reg].try_simplify()
    decompiler_data.make_version(node.state, to_reg)
    if to_reg in from_regs:
        node.state[to_reg].make_prev()
    node.state[to_reg].exec_condition = exec_condition
    return node


def set_reg(
        node,
        to_reg: str,
        from_regs: list[str],
        reg: Register,
):
    return set_reg_value(
        node=node,
        new_value=reg.register_content._value,  # pylint: disable=W0212
        to_reg=to_reg,
        from_regs=from_regs,
        data_type=reg.register_content._data_type,  # pylint: disable=W0212
        reg_type=reg.register_content._type,  # pylint: disable=W0212
        integrity=reg.integrity,
        sign=reg.register_content._sign,  # pylint: disable=W0212
        register_content_type=type(reg.register_content),
        operation=reg.register_content._operation if isinstance(reg.register_content,  # pylint: disable=W0212
                                                                OperationRegisterContent) else None,
        size=reg.register_content._size,  # pylint: disable=W0212
    )


def make_elem_from_addr(var):
    separator_pos = var.find(" + ")
    param_name = var[:separator_pos]
    index = var[separator_pos + 3:]
    var = param_name + "[" + index + "]"
    return var


# TODO: Проанализировать, может ли не быть "g" (или другого модификатора)
def make_new_type_without_modifier(node, register):
    if "g" in node.state[register].data_type:
        new_from_reg_type = node.state[register].data_type[1:]
    else:
        new_from_reg_type = node.state[register].data_type
    return new_from_reg_type


def compare_values(node: Node, to_reg: str, from_reg0: str, from_reg1: str, operation: str, suffix: str) -> Node:
    datatype = make_opencl_type(suffix)
    datatype = f'({datatype})' if datatype != 'unknown type' else ''
    new_value = make_op(node, from_reg0, from_reg1, operation, datatype, datatype, suffix=suffix)
    from_regs = [from_reg0, from_reg1]
    if is_range(to_reg):
        low, high = split_range(to_reg)
        set_reg_value(node, new_value, low, from_regs, suffix, integrity=Integrity.LOW_PART)
        set_reg_value(node, new_value, high, from_regs, suffix, integrity=Integrity.HIGH_PART)
    else:
        set_reg_value(node, new_value, to_reg, from_regs, suffix)
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
    if node.state[start_register].val == '0xa2000000' \
            and node.state[end_register].val == '0x426d1a94':
        return True, "1e12"
    return False, 0


def get_raw_asm_type(data_type):
    if data_type.startswith("g"):
        data_type = data_type.removeprefix("g")
    if data_type in vector_type_dict:
        data_type = make_asm_type(data_type[:-1])
    additional_convertions = {
        "char" : "i8",
        "uchar" : "u8",
        "short" : "i16",
        "ushort" : "u16",
        "half" : "f16"
    }
    if data_type in additional_convertions:
        data_type = additional_convertions[data_type]
    return data_type


def get_type_info(data_type) -> tuple[str, int, int, bool]:
    components_count = 1
    is_global_type = data_type.startswith("g")
    if data_type in vector_type_dict:
        components_count = int(data_type[-1])
        data_type = make_asm_type(data_type[:-1])
    data_type_size = evaluate_size(data_type)[0]
    raw_data_type = get_raw_asm_type(data_type)
    return (raw_data_type, data_type_size, components_count, is_global_type)


def is_type_signed(t) -> bool:
    return re.fullmatch("i[0-9]+", t) is not None


def is_type_unsigned(t) -> bool:
    return re.fullmatch("[u,b][0-9]+", t) is not None


def is_type_float(t) -> bool:
    return re.fullmatch("f[0-9]+", t) is not None


def check_value_needs_cast(value, from_type, to_type) -> bool:
    if from_type == to_type:
        return False
    if from_type == "" or to_type == "" or from_type is None or to_type is None:
        if re.fullmatch("-?[0-9]+((\\.|,)[0-9]+)?", value) is not None:
            return value[0] == "-" and re.fullmatch("g?[u,b][0-9]+", from_type) is not None
        return re.fullmatch("0x[0-9,a,b,c,d,e,f]+", value) is None and\
                re.fullmatch("-?[0-9,.]+((e|E)(\\+|-)?[0-9]+)?", value) is None
    from_type, from_type_size, from_type_component_count, is_global_from_type = get_type_info(from_type)
    to_type, to_type_size, to_type_component_count, is_global_to_type = get_type_info(to_type)
    # strange case, but still
    if (is_global_from_type and not is_global_to_type) or\
        (not is_global_from_type and is_global_to_type):
        return True
    needs_casting = True
    # same type, different size
    if (is_type_signed(from_type) and is_type_signed(to_type)) or\
        (is_type_unsigned(from_type) and is_type_unsigned(to_type)) or\
        (is_type_float(from_type) and is_type_float(to_type)):
        needs_casting = (from_type_size > to_type_size) or (from_type_component_count != to_type_component_count)
    # from unsigned type to signed or from signed type to unsigned
    if is_type_unsigned(from_type) and is_type_signed(to_type) or\
        is_type_signed(from_type) and is_type_unsigned(to_type):
        needs_casting = ((value[0] == '-' and value[1:].isnumeric()) or\
                        re.fullmatch("[0-9]+", value) is None or\
                        re.fullmatch("0x[0-9,a,b,c,d,e,f]+", value) is None) or\
                        (from_type_size > to_type_size) or (from_type_component_count != to_type_component_count)
    # from float to unsigned
    if is_type_float(from_type) and is_type_unsigned(to_type):
        try:
            float_value = float(value)
            needs_casting = (float_value != int(float_value)) or\
                (float_value < 0) or\
                (from_type_size > to_type_size) or\
                (from_type_component_count != to_type_component_count)
        except ValueError:
            return True
    # from float to signed
    if is_type_float(from_type) and is_type_signed(to_type):
        try:
            float_value = float(value)
            needs_casting = (float_value != int(float_value)) or\
                (from_type_size > to_type_size) or\
                (from_type_component_count != to_type_component_count)
        except ValueError:
            return True
    return needs_casting

def check_reg_for_val(node, register, suffix=''):
    data_type = ""
    if is_reg(register) or is_range(register):  # TODO: Выяснить зачем нужен range
        if register in node.state:
            new_val = node.state[register].get_value()
            data_type = node.state[register].data_type
        else:
            if is_range(register):
                start_register, end_register = check_and_split_regs(register)
                flag_big_value, value = check_big_values(node, start_register, end_register)
                if flag_big_value:
                    new_val = value
                else:
                    new_val = node.state[start_register].get_value()
                    data_type = node.state[start_register].data_type
            else:
                raise NotImplementedError
    else:
        new_val = register
    needs_casting = check_value_needs_cast(new_val, data_type, suffix)
    return (new_val, needs_casting)


def try_get_reg(node, register):
    if register in node.state:
        return node.state[register]
    if is_range(register):
        start_register, end_register = check_and_split_regs(register)
        if start_register in node.state:
            return node.state[start_register]
        if end_register in node.state:
            return node.state[end_register]
    raise NotImplementedError

def change_vals_for_make_op(node, register, reg_type, operation, suffix):
    decompiler_data = DecompilerData()
    new_val, needs_cast = check_reg_for_val(node, register, suffix)
    if (operation != "+" or reg_type) and ("-" in new_val or "+" in new_val or "*" in new_val or "/" in new_val):
        new_val = f'({new_val})'
    if reg_type != '':
        decompiler_data.type_conversion[new_val] = reg_type
    if needs_cast:
        new_val = reg_type + new_val
    if len(reg_type) > 0 and ')' not in reg_type:
        new_val += ')'
    return new_val


def make_op(node, register0, register1, operation, type0='', type1='', suffix=''):
    new_val0 = change_vals_for_make_op(node, register0, type0, operation, suffix)
    new_val1 = change_vals_for_make_op(node, register1, type1, operation, suffix)
    return f'{new_val0} {operation} {new_val1}'


def evaluate_from_hex(global_data, size, flag):
    typed_global_data = []
    for element in range(int(len(global_data) / size)):
        array_of_bytes = global_data[element * size: element * size + size]
        string_of_bytes = ''.join(elem[2:] + '' for elem in array_of_bytes)
        # output binascii.unhexlify is byteset from string; struct.unpack encode byte to value.
        value = struct.unpack(flag, binascii.unhexlify(string_of_bytes))[0]
        typed_global_data.append(str(value))
    return typed_global_data


class DecompilerData(metaclass=Singleton):  # pylint: disable=R0904, R0902
    def __init__(self):
        self.pragram_id = utils.generate_uuid()
        self.name_of_program = None
        self.config_data: Optional[ConfigData] = None
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
        self.initial_state = KernelState()  # start state of registers (начальное состояние регистров)
        self.sgprsnum = 0  # number of s registers used by system (количество s регистров, используемых системой)
        self.vgprsnum = 0  # number of v registers used by system (количество v регистров, используемых системой)
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
        self.global_data = {}
        self.var_value = {}  # var -> value
        self.type_conversion = {}  # expression -> type_conversion (get_global_id(0) -> (ulong))
        self.versions: dict[str, int] = {}
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
        self.exec_registers = {"exec": ExecCondition.default()}
        self.is_rdna3: bool = False
        self.gpu: str | None = None
        self.unrolling_limit = 16

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
        self.initial_state = KernelState()  # start state of registers (начальное состояние регистров)
        self.sgprsnum = 0  # number of s registers used by system (количество s регистров, используемых системой)
        self.vgprsnum = 0  # number of v registers used by system (количество v регистров, используемых системой)
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
        self.global_data = {}
        self.var_value = {}
        self.type_conversion = {}
        self.versions = {}
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
        self.exec_registers = {"exec": ExecCondition.default()}
        self.is_rdna3 = False

    def write(self, output):
        # noinspection PyUnresolvedReferences
        if self.flag_for_decompilation != FlagType.ONLY_CLRX and "Not resolved yet. " not in output:
            output = simplify_opencl_statement(output)
            output = output.replace("___", ".")
        self.output_file.write(output)
        self.output_file.flush()

    def make_version(self, state, reg):
        if reg not in self.versions:
            self.versions[reg] = 0
        state[reg].add_version(reg, self.versions[reg])
        self.versions[reg] += 1

    def init_work_group(self):
        dimensions = self.config_data.dimensions
        g_id = ["s8", "s9", "s10"] if self.config_data.usesetup else ["s6", "s7", "s8"]
        if self.is_rdna3:
            g_id = ["s2", "s3", "s4"]
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
            self.initial_state.init_work_group(dim, g_id_dim, self.is_rdna3)
            self.versions[g_id_dim] = 1
            self.versions[v_dim] = 1
        self.initial_state.init_exec()
        self.versions["exec"] = 1

    def process_initial_state(self):
        lp, hp = ("s6", "s7") if self.config_data.usesetup else ("s4", "s5")
        if self.is_rdna3:
            lp, hp = ("s0", "s1")
        self.initial_state[lp] = Register(
            integrity=Integrity.LOW_PART,
            register_content=RegisterContent(
                value="0",
                type_=RegisterType.ARGUMENTS_POINTER,
            ),
        )
        self.make_version(self.initial_state, lp)
        self.initial_state[hp] = Register(
            integrity=Integrity.HIGH_PART,
            register_content=RegisterContent(
                value="0",
                type_=RegisterType.ARGUMENTS_POINTER,
            ),
        )
        self.make_version(self.initial_state, hp)
        if self.config_data.usesetup:
            self.initial_state["s4"] = Register(
                integrity=Integrity.LOW_PART,
                register_content=RegisterContent(
                    value="0",
                    type_=RegisterType.DISPATCH_POINTER,
                ),
            )
            self.make_version(self.initial_state, "s4")
            self.initial_state["s5"] = Register(
                integrity=Integrity.HIGH_PART,
                register_content=RegisterContent(
                    value="0",
                    type_=RegisterType.DISPATCH_POINTER,
                ),
            )
            self.make_version(self.initial_state, "s5")

    def set_config_data(self, config_data: ConfigData):
        self.config_data = config_data
        self.init_work_group()
        self.process_initial_state()
        for arg in self.config_data.arguments:
            self.type_params[arg.name] = arg.type_name

    def get_function_definition(self) -> str:
        definition: str = "__kernel "

        if self.config_data.size_of_work_groups:
            size_of_work_groups = ", ".join(map(str, self.config_data.size_of_work_groups))
            definition += f"__attribute__((reqd_work_group_size({size_of_work_groups})))\n"

        params = ", ".join([f"{arg}" for arg in self.config_data.arguments if not arg.hidden])
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
        self.checked_variables[curr_node.state[reg].version] = variable
        self.versions[reg] = max_version + 1

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

    def set_cfg(self, node):
        self.cfg = node

    def set_to_node(self, label, node):
        self.to_node[label] = node

    def to_fill_branch_node(self, node, instruction):
        label = instruction[1]
        to_node = self.to_node.get(label)
        if to_node is not None:
            node.add_child(to_node)
            to_node.add_parent(node)
            self.loops.append(to_node)
            self.back_edges.append(node)
        else:
            if self.from_node.get(label) is None:
                self.from_node[label] = []
            self.from_node[label].append(node)
        return node
