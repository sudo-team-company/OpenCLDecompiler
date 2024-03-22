# pylint: disable=R0401

import binascii
import struct
import re
from typing import Optional, Union

import sympy

from src.combined_register_content import CombinedRegisterContent
from src import utils
from src.flag_type import FlagType
from src.integrity import Integrity
from src.logical_variable import ExecCondition
from src.register import Register, is_reg, is_range, check_and_split_regs, split_range
from src.register_content import RegisterContent, RegisterSignType
from src.register_type import RegisterType
from src.state import State
from src.utils import ConfigData, DriverFormat, Singleton
from src.operation_register_content import OperationType, OperationRegisterContent


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
        node.state.registers[to_reg] = Register(
            integrity=integrity,
            register_content=RegisterContent(
                value=new_value,
                type_=reg_type,
                sign=sign,
                data_type=data_type,
            ),
        )
        node.state.registers[to_reg].try_simplify()
    elif register_content_type == CombinedRegisterContent:
        node.state.registers[to_reg] = Register(
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
            node.state.registers[to_reg] = Register(
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
                node.state.registers[to_reg] = Register(
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
                node.state.registers[to_reg] = Register(
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

    node.state.registers[to_reg].try_simplify()
    decompiler_data.make_version(node.state, to_reg)
    if to_reg in from_regs:
        node.state.registers[to_reg].make_prev()
    node.state.registers[to_reg].exec_condition = exec_condition
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
    if "g" in node.state.registers[register].data_type:
        new_from_reg_type = node.state.registers[register].data_type[1:]
    else:
        new_from_reg_type = node.state.registers[register].data_type
    return new_from_reg_type


def compare_values(node, to_reg, from_reg0, from_reg1, type0, type1, operation, suffix):
    new_value = make_op(node, from_reg0, from_reg1, operation, type0, type1)
    from_regs = [from_reg0, from_reg1]
    if re.fullmatch(r"[sv]\[\d+:\d+]", to_reg):
        low, high = split_range(to_reg)
        set_reg_value(node, new_value, low, from_regs, suffix, integrity=Integrity.LOW_PART)
        set_reg_value(node, new_value, high, from_regs, suffix, integrity=Integrity.HIGH_PART)
    else:
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
            new_val = node.state.registers[register].get_value()
        else:
            if is_range(register):
                start_register, end_register = check_and_split_regs(register)
                flag_big_value, value = check_big_values(node, start_register, end_register)
                if flag_big_value:
                    new_val = value
                else:
                    new_val = node.state.registers[start_register].get_value()
            else:
                raise NotImplementedError
    else:
        new_val = register
    return new_val


def try_get_reg(node, register):
    if register in node.state.registers:
        return node.state.registers[register]
    if is_range(register):
        start_register, end_register = check_and_split_regs(register)
        if start_register in node.state.registers:
            return node.state.registers[start_register]
        if end_register in node.state.registers:
            return node.state.registers[end_register]
    raise NotImplementedError


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



class DecompilerData(metaclass=Singleton):  # pylint: disable=R0904, R0902
    def __init__(self):
        self.pragram_id = utils.generate_uuid()
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
        self.exec_registers = {"exec": ExecCondition.default()}
        self.is_rdna3: bool = False
        self.initial_offsets: dict[str, RegisterContent] = {}

    def init(self):
        if self.is_rdna3:
            self.initial_offsets = {
                '0x10': RegisterContent("get_num_groups(0)", RegisterType.NUM_GROUPS_X, 32),
                '0x14': RegisterContent("get_num_groups(1)", RegisterType.NUM_GROUPS_Y, 32),
                '0x18': RegisterContent("get_num_groups(2)", RegisterType.NUM_GROUPS_Z, 32),
                '0x1c': RegisterContent("get_local_size(0)", RegisterType.LOCAL_SIZE_X, 16),
                '0x1e': RegisterContent("get_local_size(1)", RegisterType.LOCAL_SIZE_Y, 16),
                '0x20': RegisterContent("get_local_size(2)", RegisterType.LOCAL_SIZE_Z, 16),
                '0x22': RegisterContent("get_group_id(0) * get_local_size(0)", RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE,
                                        16),
                '0x24': RegisterContent("get_group_id(1) * get_local_size(1)", RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE,
                                        16),
                '0x26': RegisterContent("get_group_id(2) * get_local_size(2)", RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE,
                                        16),
                '0x38': RegisterContent("get_global_offset(0)", RegisterType.GLOBAL_OFFSET_X, 64),
                '0x40': RegisterContent("get_global_offset(1)", RegisterType.GLOBAL_OFFSET_Y, 64),
                '0x48': RegisterContent("get_global_offset(2)", RegisterType.GLOBAL_OFFSET_Z, 64),
                '0x50': RegisterContent("get_work_dim()", RegisterType.WORK_DIM, 16),
            }
        else:
            self.initial_offsets = {
                '0x0': RegisterContent("get_global_offset(0)", RegisterType.GLOBAL_OFFSET_X, 64),
                '0x8': RegisterContent("get_global_offset(1)", RegisterType.GLOBAL_OFFSET_Y, 64),
                '0x10': RegisterContent("get_global_offset(2)", RegisterType.GLOBAL_OFFSET_Z, 64)
            }

    def set_offset_content(self, offset: str, content: RegisterContent):
        self.initial_offsets[offset] = content

    @property
    def setup_argument_dict(self) -> dict[str, RegisterContent]:
        """
        Returns dict of offset to register content based on gpu version
        """

        return self.initial_offsets

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
        self.exec_registers = {"exec": ExecCondition.default()}
        self.is_rdna3 = False
        self.initial_offsets: dict[str, RegisterContent] = {}

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
        state.registers[reg].add_version(reg, self.versions[reg])
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
            self.initial_state.init_work_group(
                dim,
                g_id_dim,
                self.versions[g_id_dim],
                self.versions[v_dim],
                self.is_rdna3,
            )
            self.versions[g_id_dim] += 1
            self.versions[v_dim] += 1
        self.initial_state.init_exec(self.versions["exec"])
        self.versions["exec"] += 1

    def process_initial_state(self):
        lp, hp = ("s6", "s7") if self.config_data.usesetup else ("s4", "s5")
        if self.is_rdna3:
            lp, hp = ("s0", "s1")
        self.initial_state.registers[lp] = Register(
            integrity=Integrity.LOW_PART,
            register_content=RegisterContent(
                value="0",
                type_=RegisterType.ARGUMENTS_POINTER,
            ),
        )
        self.make_version(self.initial_state, lp)
        self.initial_state.registers[hp] = Register(
            integrity=Integrity.HIGH_PART,
            register_content=RegisterContent(
                value="0",
                type_=RegisterType.ARGUMENTS_POINTER,
            ),
        )
        self.make_version(self.initial_state, hp)
        if self.config_data.usesetup:
            self.initial_state.registers["s4"] = Register(
                integrity=Integrity.LOW_PART,
                register_content=RegisterContent(
                    value="0",
                    type_=RegisterType.DISPATCH_POINTER,
                ),
            )
            self.make_version(self.initial_state, "s4")
            self.initial_state.registers["s5"] = Register(
                integrity=Integrity.HIGH_PART,
                register_content=RegisterContent(
                    value="0",
                    type_=RegisterType.DISPATCH_POINTER,
                ),
            )
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
