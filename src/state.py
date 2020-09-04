from register import Register
from integrity import Integrity
from type_of_reg import Type
import copy


class State:
    def __init__(self):
        self.registers = \
            {
                "s0": None,
                "s1": None,
                "s2": None,
                "s3": None,
                "s4": None,
                "s5": None,
                "s6": None,
                "s7": None,
                "s8": None,
                "s9": None,
                "s10": None,
                "s11": None,
                "s12": None,
                "s13": None,
                "s14": None,
                "s15": None,
                "s16": None,
                "s17": None,
                "s18": None,
                "s19": None,
                "s20": None,
                "s21": None,
                "s22": None,
                "v0": None,
                "v1": None,
                "v2": None,
                "v3": None,
                "v4": None,
                "v5": None,
                "v6": None,
                "v7": None,
                "v8": None,
                "v9": None,
                "v10": None,
                "v11": None,
                "v12": None,
                "v13": None,
                "v14": None,
                "v15": None,
                "v16": None,
                "v17": None,
                "v18": None,
                "v19": None,
                "v20": None,
                "pc": None,
                "scc": None,
                "vcc": None,
                "exec": None
            }

    def find_first_last_num_to_from(self, to_registers, from_registers):
        left_board_from = from_registers.find("[")
        last_to = 0
        first_to = 0
        first_from = 0
        name_of_register = ""
        name_of_from = ""
        num_of_registers = 0
        if left_board_from != -1:
            separation_from = from_registers.index(":")
            right_board_from = from_registers.index("]")
            first_from = int(from_registers[(left_board_from + 1):separation_from])
            last_from = int(from_registers[(separation_from + 1):right_board_from])
            num_of_registers = last_from - first_from + 1
            name_of_from = from_registers[:left_board_from]
            from_registers = name_of_from + str(first_from)
        else:
            num_of_registers = 1
        left_board_to = to_registers.find("[")
        if left_board_to != -1:
            separation_to = to_registers.index(":")
            right_board_to = to_registers.index("]")
            first_to = int(to_registers[(left_board_to + 1):separation_to])
            last_to = int(to_registers[(separation_to + 1):right_board_to])
            name_of_register = to_registers[:left_board_to]
            to_registers = name_of_register + str(first_to)
        return first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from

    def make_version(self, parent, reg):
        # prev_reg = parent.state.registers
        # self.registers[reg].add_version(reg + "_0" if prev_reg.get(reg) is None or prev_reg[reg].version is None else prev_reg[reg].version)
        par = copy.deepcopy(parent)
        self.registers[reg].add_version(reg, par[reg])
        parent[reg] += 1

    def upload_usesetup(self, to_registers, from_registers, offset, parameter_of_kernel, parent):
        to_registers1 = ""
        if to_registers.find(":") != -1:
            to_registers1 = "s" + to_registers[to_registers.find(":") + 1:-1]
            to_registers = "s" + to_registers[2:to_registers.find(":")]
        if offset == "0x0":
            self.registers[to_registers] = Register(to_registers, Type.general_setup, Integrity.integer)
            self.make_version(parent, to_registers)
        elif offset == "0x4":
            self.registers["s0"] = Register("get_local_size(0)", Type.local_size_x, Integrity.integer)
            self.make_version(parent, "s0")
            self.registers["s1"] = Register("get_local_size(2)", Type.local_size_z, Integrity.integer)
            self.make_version(parent, "s1")
            self.registers["s2"] = Register("get_global_size(0)", Type.global_size_x, Integrity.integer)
            self.make_version(parent, "s2")
            self.registers["s3"] = Register("get_global_size(1)", Type.global_size_y, Integrity.integer)
            self.make_version(parent, "s2")
        elif offset == "0xc":
            self.registers[to_registers] = Register("get_global_size(0)", Type.global_size_x, Integrity.integer)
            self.make_version(parent, to_registers)
            if to_registers1 != "":
                self.registers[to_registers1] = Register("get_global_size(1)", Type.global_size_y, Integrity.integer)
                self.make_version(parent, to_registers1)
        elif offset == "0x10":
            self.registers[to_registers] = Register("get_global_size(1)", Type.global_size_y, Integrity.integer)
            self.make_version(parent, to_registers)
            if to_registers1 != "":
                self.registers[to_registers1] = Register("get_global_size(2)", Type.global_size_z, Integrity.integer)
                self.make_version(parent, to_registers1)
        elif offset == "0x14":
            self.registers[to_registers] = Register("get_global_size(2)", Type.global_size_z, Integrity.integer)
            self.make_version(parent, to_registers)

    def upload(self, to_registers, from_registers, offset, parameter_of_kernel, parent):
        first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
            = self.find_first_last_num_to_from(to_registers, from_registers)
        # prev_regs = parent.state.registers
        if self.registers[from_registers].type == Type.arguments_pointer:
            if offset == "0x0":
                self.registers[to_registers] = Register("get_global_offset(0)", Type.global_offset_x, Integrity.integer)
                self.make_version(parent, to_registers)
                self.registers[name_of_register + str(first_to + 1)] = Register("get_global_offset(0)",
                                                                                Type.global_offset_x, Integrity.integer)
                self.make_version(parent, name_of_register + str(first_to + 1))
                if last_to - first_to > 1:
                    self.registers[name_of_register + str(last_to - 1)] = \
                        Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                    self.make_version(parent, name_of_register + str(last_to - 1))
                    self.registers[name_of_register + str(last_to)] = \
                        Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                    self.make_version(parent, name_of_register + str(last_to))
            if offset == "0x8":
                self.registers[to_registers] = Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                self.make_version(parent, to_registers)
                self.registers[name_of_register + str(first_to + 1)] = \
                    Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                self.make_version(parent, name_of_register + str(first_to + 1))
                if last_to - first_to > 1:
                    self.registers[name_of_register + str(last_to - 1)] = \
                        Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
                    self.make_version(parent, name_of_register + str(last_to - 1))
                    self.registers[name_of_register + str(last_to)] = \
                        Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
                    self.make_version(parent, name_of_register + str(last_to))
            if offset == "0x10":
                self.registers[to_registers] = Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
                self.make_version(parent, to_registers)
                self.registers[name_of_register + str(first_to + 1)] = Register("get_global_offset(2)",
                                                                                Type.global_offset_z, Integrity.integer)
                self.make_version(parent, name_of_register + str(first_to + 1))
            if offset == "0x30":
                val_of_register = parameter_of_kernel["param0"]
                if val_of_register[0] == "*":
                    type_param = Type.paramA
                    val_of_register = val_of_register[1:]
                else:
                    type_param = Type.param
                if last_to - first_to >= 1:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.low_part)
                    self.make_version(parent, to_registers)
                    self.registers[name_of_register + str(first_to + 1)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(first_to + 1))
                else:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.integer)
                    self.make_version(parent, to_registers)
                if last_to - first_to > 2:
                    val_of_register = parameter_of_kernel["param1"]
                    if val_of_register[0] == "*":
                        type_param = Type.paramA
                        val_of_register = val_of_register[1:]
                    else:
                        type_param = Type.param
                    self.registers[name_of_register + str(last_to - 1)] = Register(val_of_register, type_param,
                                                                                   Integrity.low_part)
                    self.make_version(parent, name_of_register + str(last_to - 1))
                    self.registers[name_of_register + str(last_to)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(last_to))
            if offset == "0x38":
                val_of_register = parameter_of_kernel["param1"]
                if val_of_register[0] == "*":
                    type_param = Type.paramA
                    val_of_register = val_of_register[1:]
                else:
                    type_param = Type.param
                if last_to - first_to >= 1:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.low_part)
                    self.make_version(parent, to_registers)
                    self.registers[name_of_register + str(last_to)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(last_to))
                else:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.integer)
                    self.make_version(parent, to_registers)
            if offset == "0x3c":
                val_of_register = parameter_of_kernel["param2"]
                if val_of_register[0] == "*":
                    type_param = Type.paramA
                    val_of_register = val_of_register[1:]
                else:
                    type_param = Type.param
                if last_to - first_to >= 1:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.low_part)
                    self.make_version(parent, to_registers)
                    self.registers[name_of_register + str(last_to)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(last_to))
                else:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.integer)
                    self.make_version(parent, to_registers)
            if offset == "0x40":
                val_of_register = parameter_of_kernel["param3"] \
                    if parameter_of_kernel["param1"][0] != "*" and parameter_of_kernel["param2"][0] != "*" else \
                    parameter_of_kernel["param2"]
                if val_of_register[0] == "*":
                    type_param = Type.paramA
                    val_of_register = val_of_register[1:]
                else:
                    type_param = Type.param
                if last_to - first_to >= 1:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.low_part)
                    self.make_version(parent, to_registers)
                    self.registers[name_of_register + str(last_to)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(last_to))
                else:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.integer)
                    self.make_version(parent, to_registers)
            if offset == "0x44":
                val_of_register = parameter_of_kernel["param4"]
                if val_of_register[0] == "*":
                    type_param = Type.paramA
                    val_of_register = val_of_register[1:]
                else:
                    type_param = Type.param
                if last_to - first_to >= 1:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.low_part)
                    self.make_version(parent, to_registers)
                    self.registers[name_of_register + str(last_to)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(last_to))
                else:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.integer)
                    self.make_version(parent, to_registers)
            if offset == "0x48":
                val_of_register = parameter_of_kernel["param4"] \
                    if parameter_of_kernel["param1"][0] != "*" and parameter_of_kernel["param2"][0] != "*" else \
                    parameter_of_kernel["param3"]
                if val_of_register[0] == "*":
                    type_param = Type.paramA
                    val_of_register = val_of_register[1:]
                else:
                    type_param = Type.param
                if last_to - first_to >= 1:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.low_part)
                    self.make_version(parent, to_registers)
                    self.registers[name_of_register + str(first_to + 1)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(first_to + 1))
                else:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.integer)
                    self.make_version(parent, to_registers)
                if last_to - first_to > 2:
                    val_of_register = parameter_of_kernel["param5"] \
                        if parameter_of_kernel["param1"][0] != "*" and parameter_of_kernel["param2"][0] != "*" else \
                        parameter_of_kernel[
                            "param4"]
                    if val_of_register[0] == "*":
                        type_param = Type.paramA
                        val_of_register = val_of_register[1:]
                    else:
                        type_param = Type.param
                    self.registers[name_of_register + str(last_to - 1)] = Register(val_of_register, type_param,
                                                                                   Integrity.low_part)
                    self.make_version(parent, name_of_register + str(last_to - 1))
                    self.registers[name_of_register + str(last_to)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(last_to))
            if offset == "0x50":
                val_of_register = parameter_of_kernel["param5"] \
                    if parameter_of_kernel["param2"][0] != "*" and parameter_of_kernel["param3"][0] != "*" else \
                    parameter_of_kernel[
                        "param4"]
                if val_of_register[0] == "*":
                    type_param = Type.paramA
                    val_of_register = val_of_register[1:]
                else:
                    type_param = Type.param
                if last_to - first_to >= 1:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.low_part)
                    self.make_version(parent, to_registers)
                    self.registers[name_of_register + str(first_to + 1)] = \
                        Register(val_of_register, type_param, Integrity.high_part)
                    self.make_version(parent, name_of_register + str(first_to + 1))
                else:
                    self.registers[to_registers] = Register(val_of_register, type_param, Integrity.integer)
                    self.make_version(parent, to_registers)
