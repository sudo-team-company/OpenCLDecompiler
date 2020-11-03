from src.register import Register
from src.integrity import Integrity
from src.type_of_reg import Type


def extract_from_regs(registers, left_board):
    last = 0
    first = 0
    name = registers
    if left_board != -1:
        separation = registers.index(":")
        right_board = registers.index("]")
        first = int(registers[(left_board + 1):separation])
        last = int(registers[(separation + 1):right_board])
        name = registers[:left_board]
    else:
        if "s" in registers or "v" in registers:
            name = registers[0]
            first = int(registers[1:])
            last = first
    return first, last, name


def find_first_last_num_to_from(to_registers, from_registers):
    left_board_from = from_registers.find("[")
    first_from, last_from, name_of_from = extract_from_regs(from_registers, left_board_from)
    left_board_to = to_registers.find("[")
    first_to, last_to, name_of_to = extract_from_regs(to_registers, left_board_to)
    return first_to, last_to, name_of_to, name_of_from, first_from, last_from


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

    def make_version(self, parent, reg):
        self.registers[reg].add_version(reg, parent[reg])
        parent[reg] += 1

    def upload_usesetup(self, to_registers, offset, parent):
        to_registers1 = ""
        separation = to_registers.find(":")
        if separation != -1:
            to_registers1 = "s" + to_registers[separation + 1:-1]
            to_registers = "s" + to_registers[2:separation]
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

    def upload(self, to_registers, from_registers, offset, kernel_params, parent):
        first_to, last_to, name_of_to, name_of_from, first_from, _ \
            = find_first_last_num_to_from(to_registers, from_registers)
        from_registers = name_of_from + str(first_from)
        to_registers = name_of_to + str(first_to)
        if self.registers[from_registers].type == Type.arguments_pointer:
            if offset == "0x0":
                self.registers[to_registers] = Register("get_global_offset(0)", Type.global_offset_x, Integrity.integer)
                self.make_version(parent, to_registers)
                self.registers[name_of_to + str(first_to + 1)] = Register("get_global_offset(0)",
                                                                          Type.global_offset_x, Integrity.integer)
                self.make_version(parent, name_of_to + str(first_to + 1))
                if last_to - first_to > 1:
                    self.registers[name_of_to + str(last_to - 1)] = \
                        Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                    self.make_version(parent, name_of_to + str(last_to - 1))
                    self.registers[name_of_to + str(last_to)] = \
                        Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                    self.make_version(parent, name_of_to + str(last_to))
            elif offset == "0x8":
                self.registers[to_registers] = Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                self.make_version(parent, to_registers)
                self.registers[name_of_to + str(first_to + 1)] = \
                    Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                self.make_version(parent, name_of_to + str(first_to + 1))
                if last_to - first_to > 1:
                    self.registers[name_of_to + str(last_to - 1)] = \
                        Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
                    self.make_version(parent, name_of_to + str(last_to - 1))
                    self.registers[name_of_to + str(last_to)] = \
                        Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
                    self.make_version(parent, name_of_to + str(last_to))
            elif offset == "0x10":
                self.registers[to_registers] = Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
                self.make_version(parent, to_registers)
                self.registers[name_of_to + str(first_to + 1)] = Register("get_global_offset(2)",
                                                                          Type.global_offset_z, Integrity.integer)
                self.make_version(parent, name_of_to + str(first_to + 1))
            else:
                for (reg, val) in kernel_params[offset]:
                    if val[0] == "*":
                        type_param = Type.paramA
                        val = val[1:]
                    else:
                        type_param = Type.param
                    self.registers[reg] = Register(val, type_param, Integrity.integer)
                    self.make_version(parent, reg)
