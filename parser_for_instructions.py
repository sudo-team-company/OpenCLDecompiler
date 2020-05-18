from enum import Enum, auto
import copy


class Type(Enum):
    unknown = auto()
    global_id_x = auto()
    global_id_y = auto()
    global_id_z = auto()
    work_group_id_x = auto()
    work_group_id_y = auto()
    work_group_id_z = auto()
    work_item_id_x = auto()
    work_item_id_y = auto()
    work_item_id_z = auto()
    global_offset_x = auto()
    global_offset_y = auto()
    global_offset_z = auto()
    arguments_pointer = auto()
    work_group_id_x_local_size = auto()
    work_group_id_y_local_size = auto()
    work_group_id_z_local_size = auto()
    work_group_id_x_local_size_offset = auto()
    work_group_id_y_local_size_offset = auto()
    work_group_id_z_local_size_offset = auto()
    param_global_id_x = auto()
    param_global_id_y = auto()
    param_global_id_z = auto()
    param = auto()
    int32 = auto()


class Integrity(Enum):
    integer = auto()
    low_part = auto()
    high_part = auto()


class Register:
    def __init__(self, val, type_of_elem, integrity):
        self.val = val
        self.type: Type = type_of_elem
        self.integrity: Integrity = integrity


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
                "v0": None,
                "v1": None,
                "v2": None,
                "v3": None,
                "v4": None,
                "v5": None,
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

    def upload(self, to_registers, from_registers, offset, parameter_of_kernel):
        first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
            = self.find_first_last_num_to_from(to_registers, from_registers)
        if self.registers[from_registers].type == Type.arguments_pointer:
            if offset == "0x0":
                self.registers[to_registers] = Register("get_global_offset(0)", Type.global_offset_x, Integrity.integer)
                self.registers[name_of_register + str(first_to + 1)] = Register("get_global_offset(0)",
                                                                                Type.global_offset_x, Integrity.integer)
                if last_to - first_to > 1:
                    self.registers[name_of_register + str(last_to - 1)] = \
                        Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                    self.registers[name_of_register + str(last_to)] = \
                        Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
            if offset == "0x8":
                self.registers[to_registers] = Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                self.registers[name_of_register + str(first_to + 1)] = \
                    Register("get_global_offset(1)", Type.global_offset_y, Integrity.integer)
                if last_to - first_to > 1:
                    self.registers[name_of_register + str(last_to - 1)] = \
                        Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
                    self.registers[name_of_register + str(last_to)] = \
                        Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
            if offset == "0x10":
                self.registers[to_registers] = Register("get_global_offset(2)", Type.global_offset_z, Integrity.integer)
                self.registers[name_of_register + str(first_to + 1)] = Register("get_global_offset(2)",
                                                                                Type.global_offset_z, Integrity.integer)
            if offset == "0x30":
                val_of_register = parameter_of_kernel["param0"]
                if num_of_registers > 1:
                    self.registers[to_registers] = Register(val_of_register, Type.param, Integrity.low_part)
                    self.registers[name_of_register + str(last_to)] = \
                        Register(val_of_register, Type.param, Integrity.high_part)
                else:
                    self.registers[to_registers] = Register(val_of_register, Type.param, Integrity.integer)
            if offset == "0x38":
                val_of_register = parameter_of_kernel["param1"]
                if num_of_registers > 1:
                    self.registers[to_registers] = Register(val_of_register, Type.param, Integrity.low_part)
                    self.registers[name_of_register + str(last_to)] = \
                        Register(val_of_register, Type.param, Integrity.high_part)
                else:
                    self.registers[to_registers] = Register(val_of_register, Type.param, Integrity.integer)


class Node:
    def __init__(self, instruction, state):
        self.instruction = instruction
        self.children = []
        self.state = state

    def add_child(self, child):
        self.children.append(child)


class Decompiler:
    def __init__(self):
        self.cfg = None
        # self.last_node = None
        self.number_of_temp = 0
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
        self.initial_state = State()
        self.sgprsnum = 0
        self.vgprsnum = 0
        self.params = {}

    def process_config(self, set_of_config, f, name_of_program):
        dimentions = set_of_config[0][6:]
        if len(dimentions) > 0:
            self.initial_state.registers["s6"] = Register("s6", Type.work_group_id_x, Integrity.integer)
            self.initial_state.registers["v0"] = Register("v0", Type.work_item_id_x, Integrity.integer)
        if len(dimentions) > 1:
            self.initial_state.registers["s7"] = Register("s7", Type.work_group_id_y, Integrity.integer)
            self.initial_state.registers["v1"] = Register("v1", Type.work_item_id_y, Integrity.integer)
        if len(dimentions) > 2:
            self.initial_state.registers["s8"] = Register("s8", Type.work_group_id_z, Integrity.integer)
            self.initial_state.registers["v2"] = Register("v2", Type.work_item_id_z, Integrity.integer)

        size_of_work_groups = set_of_config[1].replace(',', ' ').split()
        f.write("__kernel __attribute__((reqd_work_group_size(" + size_of_work_groups[1] + ", " + size_of_work_groups[2] + ", " + size_of_work_groups[3] + ")))\n")
        self.sgprsnum = int(set_of_config[2][10:])
        self.vgprsnum = int(set_of_config[3][10:])
        self.initial_state.registers["s4"] = Register("s4", Type.arguments_pointer, Integrity.low_part)
        self.initial_state.registers["s5"] = Register("s5", Type.arguments_pointer, Integrity.high_part)
        parameters = set_of_config[17:]
        f.write("void " + name_of_program + "(")
        num_of_param = 0
        flag_start = False
        for param in parameters:
            if not flag_start:
                flag_start = True
            else:
                f.write(", ")
            set_of_param = param.strip().replace(',', ' ').split()
            name_param = set_of_param[1]
            type_param = set_of_param[3]
            flag_param = ""
            if len(set_of_param) > 4:
                flag_param = "__" + set_of_param[4] + " "
            self.params["param" + str(num_of_param)] = set_of_param[1]
            if type_param[-1] == "*":
                name_param = "*" + name_param
                type_param = type_param[:-1]
            f.write(flag_param + type_param + " " + name_param)
            num_of_param += 1
        f.write(")\n")

    def process_src(self, f):
        with open('experiments\\train.asm', 'r') as file:
            body_of_file = file.read().splitlines()
        flag_config = False
        flag_instructions = False
        set_of_instructions = []
        set_of_config = []
        name_of_program = ""
        for row in body_of_file:
            row = row.strip()
            if row.find(".kernel ") != -1:
                name_of_program = row.split()[1]
            if row == ".config":
                flag_config = True
                flag_instructions = False
            elif row == ".text":
                flag_instructions = True
            elif flag_instructions:
                set_of_instructions.append(row)
            elif flag_config:
                set_of_config.append(row)
            else:
                continue

        self.process_config(set_of_config, f, name_of_program)
        last_node = Node("", self.initial_state)  # root
        last_node_state = self.initial_state
        self.cfg = last_node
        for row in set_of_instructions:
            # instruction = row.strip().replace(',', ' ').split()

            curr_node = self.make_cfg_node(row, last_node_state, f)
            last_node_state = copy.deepcopy(curr_node.state)
            last_node.add_child(curr_node)
            last_node = curr_node
        curr_node = self.cfg
        f.write("{\n")
        while curr_node.children:
            self.to_openCL(curr_node.children[0], f, False, curr_node)
            curr_node = curr_node.children[0]

    def make_cfg_node(self, instruction, last_node_state, f):
        return self.to_openCL(Node(instruction, last_node_state), f, True, Node("", last_node_state))

    def to_openCL(self, node, f, flag_of_status, prev_node):
        tab = "    "
        instruction = node.instruction.strip().replace(',', ' ').split()
        operation = instruction[0]
        parts_of_operation = operation.split('_')
        prefix = parts_of_operation[0]
        suffix = parts_of_operation[-1]
        root = parts_of_operation[1]
        if prefix == "ds":
            if root == "bpermute":
                if suffix == "b32":
                    tmp = "tmp" + str(self.number_of_tmp)
                    dst = instruction[1]
                    addr = instruction[2]
                    src = instruction[3]
                    offset = instruction[4][7:]
                    f.write("uint64 " + tmp + "\n")  # именно массив
                    f.write("for (short i = 0; i < 64; i++)\n")
                    f.write("{\n")
                    f.write(tab + "uint lane_id = " + addr + "[(i + (" + offset + " >> 2)) & 63]\n")
                    f.write(tab + tmp + "[i] = exec & (1ULL << lane_id) != 0) ? " + src + "[lane_id] : 0\n")
                    f.write("}\n")
                    f.write("for (short i = 0; i < 64; i++)\n")
                    f.write(tab + "if (exec & (1ULL << i) != 0)\n")
                    f.write(tab + tab + dst + "[i] = " + tmp + "[i]\n")
                    self.number_of_tmp += 1

            elif root == "read":
                if suffix == "b32":
                    vdst = instruction[1]
                    addr = instruction[2]
                    offset = instruction[3][7:]
                    f.write(vdst + " = *(uint)(ds + ((" + addr + " + " + offset + ") & ~3)\n")

                elif suffix == "b64":
                    vdst = instruction[1]
                    addr = instruction[2]
                    offset = instruction[3][7:]
                    f.write(vdst + " = *(ulong)(ds + ((" + addr + " + " + offset + ") & ~7)\n")

            elif root == "read2":
                if suffix == "b64":
                    v0 = "v0" + str(self.number_of_v0)
                    v1 = "v1" + str(self.number_of_v1)
                    vdst = instruction[1]
                    addr = instruction[2]
                    offset0 = instruction[3][8:]
                    offset1 = instruction[4][8:]
                    f.write("ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7)\n")
                    f.write("ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
                    f.write(vdst + " = *" + v0 + " | (ulonglong(*" + v1 + ") << 64)\n")  # uint128????
                    self.number_of_v0 += 1
                    self.number_of_v1 += 1

            elif root == "write":
                if suffix == "b32":
                    v = "v" + str(self.number_of_v)
                    addr = instruction[1]
                    vdata0 = instruction[2]
                    offset = instruction[3][7:]
                    f.write("uint* " + v + "\n")
                    f.write(v + " = (uint*)(ds + ((" + addr + " + " + offset + ") & ~3))\n")
                    f.write("*" + v + " = " + vdata0 + "\n")
                    self.number_of_v += 1

                elif suffix == "b64":
                    v = "v" + str(self.number_of_v)
                    addr = instruction[1]
                    vdata0 = instruction[2]
                    offset = instruction[3][7:]
                    f.write("ulong* " + v + "\n")
                    f.write(v + " = (ulong*)(ds + ((" + addr + " + " + offset + ") & ~3))\n")
                    f.write("*" + v + " = " + vdata0 + "\n")
                    self.number_of_v += 1

            elif root == "write2":
                if suffix == "b64":
                    v0 = "v0" + str(self.number_of_v0)
                    v1 = "v1" + str(self.number_of_v1)
                    addr = instruction[1]
                    vdata0 = instruction[2]
                    vdata1 = instruction[3]
                    offset0 = instruction[4][8:]
                    offset1 = instruction[5][8:]
                    f.write("ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7)\n")
                    f.write("ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
                    f.write("*" + v0 + " = " + vdata0 + "\n")
                    f.write("*" + v1 + " = " + vdata1 + "\n")
                    self.number_of_v0 += 1
                    self.number_of_v1 += 1


        elif prefix == "flat":  # не очень понятное описание, особенно про inst_offset
            if root == "atomic_add":
                vdst = instruction[1]
                vaddr = instruction[2]
                vdata = instruction[3]
                vm = "vm" + str(self.number_of_vm)
                p = "p" + str(self.number_of_p)
                inst_offset = instruction[4]  # не очень понятно, должно ли это быть в виде INST_OFFSET:OFFSET
                f.write("uint* " + vm + " = (uint*)(" + vaddr + " + " + inst_offset + ")\n")
                f.write("uint " + p + " = *" + vm + "; *" + vm + " = *" + vm + " + " + vdata + "; "
                        + vdst + " = (glc) ? " + p + " : " + vdst + '\n')
                self.number_of_vm += 1
                self.number_of_p += 1

            elif root == "load":
                if suffix == "dword":
                    vdst = instruction[1]
                    vaddr = instruction[2]
                    inst_offset = instruction[3]
                    f.write(vdst + " = *(uint)(" + vaddr + " + " + inst_offset + "\n")

                elif suffix == "dwordx4":
                    vdst = instruction[1]
                    vaddr = instruction[2]
                    inst_offset = instruction[3]
                    vm = "vm" + str(self.number_of_vm)
                    f.write("short* " + vm + " = (" + vaddr + " + " + inst_offset + ")\n")
                    f.write(vdst + "[0] = *(uint*)" + vm + "\n")
                    f.write(vdst + "[1] = *(uint*)(" + vm + " + 4)\n")
                    f.write(vdst + "[2] = *(uint*)(" + vm + " + 8)\n")
                    f.write(vdst + "[3] = *(uint*)(" + vm + " + 12)\n")
                    self.number_of_vm += 1

            elif root == "store":
                if suffix == "dword":
                    vaddr = instruction[1]
                    vdata = instruction[2]
                    inst_offset = "0" if len(instruction) < 4 else instruction[3]
                    first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                        = node.state.find_first_last_num_to_from(vaddr, vdata)
                    if flag_of_status:
                        if first_to == last_to:
                            node.state.registers[to_registers] = \
                                Register(node.state.registers[vdata].val, node.state.registers[from_registers].type, Integrity.integer)
                        else:
                            node.state.registers[to_registers] = \
                                Register(node.state.registers[vdata].val, node.state.registers[from_registers].type, Integrity.low_part)
                            to_now = name_of_register + str(first_to + 1)
                            node.state.registers[to_now] = \
                                Register(node.state.registers[vdata].val, node.state.registers[from_registers].type, Integrity.high_part)
                        return node
                    if inst_offset != "0":
                        f.write("*(uint*)(" + prev_node.state.registers[to_registers].val + " + " + inst_offset + ") = " + node.state.registers[name_of_register + str(first_to)].val + "\n")
                    else:
                        f.write(tab + prev_node.state.registers[to_registers].val + " = " + node.state.registers[name_of_register + str(first_to)].val + "\n")
                    # f.write("*(uint*)(" + vaddr + " + " + inst_offset + ") = " + vdata + "\n")  # нужен ли номер...

                elif suffix == "dwordx4":
                    vaddr = instruction[1]
                    vdata = instruction[2]
                    inst_offset = instruction[3]
                    vm = "vm" + str(self.number_of_vm)
                    f.write("short* " + vm + " = (" + vaddr + " + " + inst_offset + ")\n")
                    f.write("*(uint*)(" + vm + ") = " + vdata + "[0]\n")
                    f.write("*(uint*)(" + vm + " + 4) = " + vdata + "[1]\n")
                    f.write("*(uint*)(" + vm + " + 8) = " + vdata + "[2]\n")
                    f.write("*(uint*)(" + vm + " + 12) = " + vdata + "[3]\n")
                    self.number_of_vm += 1

        elif prefix == 'global':  # offset - опциональная часть?
            if root == "load":
                if suffix == "dword":
                    vdst = instruction[1]
                    vaddr = instruction[2]
                    saddr = "0" if instruction[3] == "off" else instruction[3]
                    inst_offset = "0" if len(instruction) == 4 else instruction[4]
                    f.write(vdst + " = *(uint*)(" + vaddr + " + " + saddr + " + " + inst_offset + ")\n")

                elif suffix == "dwordx2":
                    vdst = instruction[1]
                    vaddr = instruction[2]
                    saddr = "0" if instruction[3] == "off" else instruction[3]
                    inst_offset = "0" if len(instruction) == 4 else instruction[4]
                    f.write(vdst + " = *(ulong*)(" + vaddr + " + " + saddr + " + " + inst_offset + ")\n")

            elif root == "store":
                if suffix == "dword":
                    vaddr = instruction[1]
                    vdata = instruction[2]
                    saddr = 0 if instruction[3] == "off" else instruction[3]
                    inst_offset = 0 if len(instruction) == 4 else instruction[4]
                    f.write("*(uint*)(" + vaddr + " + " + saddr + " + " + inst_offset + ") = " + vdata + "\n")

                elif suffix == "dwordx2":
                    vaddr = instruction[1]
                    vdata = instruction[2]
                    saddr = 0 if instruction[3] == "off" else instruction[3]
                    inst_offset = 0 if len(instruction) == 4 else instruction[4]
                    f.write("*(ulong*)(" + vaddr + " + " + saddr + " + " + inst_offset + ") = " + vdata + "\n")

        elif prefix == 's':
            if root == 'add':
                if suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    new_val = "(ulong)" + ssrc0 + " + (ulong)" + ssrc1
                    if flag_of_status:
                        if node.state.registers[ssrc0].type == Type.work_group_id_x_local_size \
                                and node.state.registers[ssrc1].type == Type.global_offset_x:
                            node.state.registers[sdst] = \
                                Register(new_val, Type.work_group_id_x_local_size_offset, Integrity.integer)
                        elif node.state.registers[ssrc0].type == Type.work_group_id_y_local_size \
                                and node.state.registers[ssrc1].type == Type.global_offset_y:
                            node.state.registers[sdst] = \
                                Register(new_val, Type.work_group_id_y_local_size_offset, Integrity.integer)
                        elif node.state.registers[ssrc0].type == Type.work_group_id_z_local_size \
                                and node.state.registers[ssrc1].type == Type.global_offset_z:
                            node.state.registers[sdst] = \
                                Register(new_val, Type.work_group_id_z_local_size_offset, Integrity.integer)
                        return node

                    # temp = "temp" + str(self.number_of_temp)
                    # f.write("ulong " + temp + " = " + new_val + "\n")
                    # f.write(sdst + " = " + temp + "\n")
                    # f.write("scc = " + temp + " >> 32\n")
                    # self.number_of_temp += 1

            elif root == 'addc':
                if suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = " temp" + str(self.number_of_temp)
                    f.write("ulong " + temp + " = (ulong)" + ssrc0 + " + (ulong)" + ssrc1 + " scc\n")
                    f.write(sdst + " = " + temp + "\n")
                    f.write("scc = " + temp + " >> 32\n")
                    self.number_of_temp += 1

            elif root == 'and':
                if suffix == 'b32' or suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = " + ssrc0 + " & " + ssrc1 + "\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'and_saveexec':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    f.write(sdst + " = " + "exec\n")
                    f.write("exec = ~" + ssrc0 + " & exec\n")
                    f.write("scc = exec != 0\n")

            elif root == 'andn2':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = " + ssrc0 + " & ~" + ssrc1 + "\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'ashr':
                if suffix == 'i32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = (int)" + ssrc0 + " >> (" + ssrc1 + " & 31)\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'barrier':
                f.write("barrier(CLK_LOCAL_MEM_FENCE);\n")

            elif root == 'bfe':
                if suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    shift = "shift" + str(self.number_of_shift)
                    length = "length" + str(self.number_of_length)
                    f.write("uchar " + shift + " = " + ssrc1 + " & 31\n")
                    f.write("uchar " + length + " = (" + ssrc0 + " >> 16) & 0x7f\n")
                    f.write("if (" + length + " == 0)\n")
                    f.write(tab + sdst + " = 0\n")
                    f.write("if (" + shift + " + " + length + " < 32)\n")
                    f.write(tab + sdst + " = " + ssrc0 + " << (32 - " + shift + " - " + length + ") >> (32 - "
                            + length + "\n")
                    f.write("else\n")
                    f.write(tab + sdst + " = " + instruction[2] + " >> " + shift + "\n")
                    f.write("scc = " + ssrc0 + " != 0\n")
                    self.number_of_length += 1
                    self.number_of_shift += 1

            elif root == 'branch':
                reladdr = instruction[1]
                f.write("pc = " + reladdr + "\n")

            elif root == 'cbranch_execz':
                reladdr = instruction[1]
                f.write("pc = exec == 0 ? " + reladdr + " : pc + 4\n")

            elif root == 'cbranch_scc0':
                reladdr = instruction[1]
                f.write("pc = scc0 == 0 ? " + reladdr + " : pc + 4\n")

            elif root == 'cbranch_scc1':
                reladdr = instruction[1]
                f.write("pc = scc1 == 0 ? " + reladdr + " : pc + 4\n")

            elif root == 'cbranch_vccnz':
                reladdr = instruction[1]
                f.write("pc = vcc != 0 ? " + reladdr + " : pc + 4")

            elif root == 'cmp_eq':
                if suffix == 'i32' or suffix == 'u32':
                    ssrc0 = instruction[1]
                    ssrc1 = instruction[2]
                    f.write("scc = " + ssrc0 + " == " + ssrc1 + "\n")

            elif root == 'cmp_ge':
                if suffix == 'i32':
                    ssrc0 = instruction[1]
                    ssrc1 = instruction[2]
                    f.write("scc = (int)" + ssrc0 + " >= (int)" + ssrc1 + "\n")

                elif suffix == 'u32':
                    ssrc0 = instruction[1]
                    ssrc1 = instruction[2]
                    f.write("scc = " + ssrc0 + " >= " + ssrc1 + "\n")

            elif root == 'cmp_lt':
                if suffix == 'i32':
                    ssrc0 = instruction[1]
                    ssrc1 = instruction[2]
                    f.write("scc = (int)" + ssrc0 + " < (int)" + ssrc1 + "\n")

            elif root == 'cselect':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = scc ? " + ssrc0 + " : " + ssrc1 + "\n")

            elif root == 'endpgm':
                if flag_of_status:
                    return node
                f.write("}\n")
            # здесь должна будет быть закрывающаяся скобка
            elif root == 'getpc':
                if suffix == 'b64':
                    sdst = instruction[1]
                    f.write(sdst + " = pc + 4\n")

            elif root == 'load':
                if suffix == 'dword':
                    sdata = instruction[1]
                    sbase = instruction[2]
                    offset = instruction[3]
                    first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                        = node.state.find_first_last_num_to_from(sdata, sbase)
                    if flag_of_status:
                        node.state.upload(sdata, sbase, offset, self.params)
                        return node
                    # f.write(sdata + " = *(uint*)(smem + (" + offset + " & ~3))\n")

                elif suffix == 'dwordx2':
                    sdata = instruction[1]
                    sbase = instruction[2]
                    offset = instruction[3]
                    first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                        = node.state.find_first_last_num_to_from(sdata, sbase)
                    if flag_of_status:
                        node.state.upload(sdata, sbase, offset, self.params)
                        return node
                    #f.write(sdata + " = " + node.state.registers[to_registers].val + "\n")
                        # f.write(sdata + " = *(ulong*)(smem + (" + offset + " & ~3))\n")  # smem??? как и dc..

                elif suffix == 'dwordx4' or suffix == 'dwordx8':
                    sdata = instruction[1]
                    sbase = instruction[2]
                    offset = instruction[3]
                    first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                        = node.state.find_first_last_num_to_from(sdata, sbase)
                    if flag_of_status:
                        node.state.upload(sdata, sbase, offset, self.params)
                        return node
                    # f.write("for (short i = 0; i < " + suffix[-1] + "; i++)\n")
                    # f.write(tab + sdata + " = *(uint*)(smem + i * 4 + (" + offset + " & ~3))\n")

            elif root == 'lshl':
                if suffix == 'b32' or suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    if flag_of_status:
                        if node.state.registers[ssrc0].type == Type.work_group_id_x:
                            node.state.registers[sdst] = Register(ssrc0 + " * " + str(pow(2, int(ssrc1))),
                                                                  Type.work_group_id_x_local_size, Integrity.integer)
                            node.state.registers["scc"] = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                            return node
                        elif node.state.registers[ssrc0].type == Type.work_group_id_y:
                            node.state.registers[sdst] = Register(ssrc0 + " * " + str(pow(2, int(ssrc1))),
                                                                  Type.work_group_id_y_local_size, Integrity.integer)
                            node.state.registers["scc"].type = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                            return node
                        elif node.state.registers[ssrc0].type == Type.work_group_id_z:
                            node.state.registers[sdst] = Register(ssrc0 + " * " + str(pow(2, int(ssrc1))),
                                                                  Type.work_group_id_z_local_size, Integrity.integer)
                            node.state.registers["scc"] = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                            return node
                        return node
                    # f.write(sdst + " = " + node.state.registers[sdst].val + "\n")
                    # f.write("scc = " + sdst + " != 0\n")
                        # f.write(sdst + " = " + ssrc0 + " << (" + ssrc1 + " & " + str(int(suffix[1:]) - 1) + ")\n")

            elif root == 'mov':
                if suffix == 'b32' or suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    if flag_of_status:
                        if node.state.registers.get(ssrc0) is not None:
                            node.state.registers[sdst] = Register(ssrc0, node.state.registers[ssrc0].type, Integrity.integer)
                        else:
                            node.state.registers[sdst] = Register(ssrc0, Type.int32, Integrity.integer)
                        return node
                    # f.write(sdst + " = " + ssrc0 + "\n")

            elif root == 'movk':
                if suffix == 'i32':
                    sdst = instruction[1]
                    simm16 = instruction[2]
                    f.write(sdst + " = " + simm16 + "\n")

            elif root == 'mul':
                if suffix == 'i32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = " + ssrc0 + " * " + ssrc1 + "\n")

            elif root == 'mulk':
                if suffix == 'i32':
                    sdst = instruction[1]
                    simm16 = instruction[2]
                    f.write(sdst + " = " + sdst + " * " + simm16 + "\n")

            elif root == 'not':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    f.write(sdst + " = ~" + ssrc0 + "\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'set_gpr_idx_on':
                ssrc0 = instruction[1]
                imm8 = instruction[2]
                f.write("mode = (mode & ~(1U << 27)) | (1U << 27)\n")
                f.write("m0 = (m0 & 0xffff0f00) | ((" + imm8 + " & 15) << 12) | (" + ssrc0 + " & 0xff)\n")

            elif root == 'set_gpr_idx_off':
                f.write("mode = (mode & ~(1U << 27))\n")

            elif root == 'setpc':
                if suffix == 'b64':
                    ssrc0 = instruction[1]
                    f.write("pc = " + ssrc0 + "\n")

            elif root == 'setreg':  # возможно это неправда
                if suffix == 'b32':
                    hwreg = instruction[1]
                    hwregname = instruction[2]
                    bitoffset = instruction[3]
                    bitsize = instruction[4]
                    sdst = instruction[5]
                    mask = "mask" + str(self.number_of_mask)
                    f.write("uint " + mask + " = (1U << " + bitsize + ") - 1U) << " + bitoffset + "\n")
                    f.write(hwreg + " = (" + hwreg + "& ~" + mask + ") | ((" + sdst + " << " + bitoffset + ") & " + mask
                            + ")\n")
                    self.number_of_mask += 1

            elif root == 'sub':
                if suffix == 'i32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = "temp" + str(self.number_of_temp)
                    f.write(sdst + " = " + ssrc0 + " - " + ssrc1 + "\n")
                    f.write("long " + temp + " = (long)" + ssrc0 + " - (long)" + ssrc1 + "\n")  # SEXT64 - long?
                    f.write("scc = " + temp + " > ((1LL << 31) - 1) || " + temp + " < (-1LL << 31)\n")
                    self.number_of_temp += 1

                elif suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = "temp" + str(self.number_of_temp)
                    f.write("ulong " + temp + " = (ulong)" + ssrc0 + " - (ulong)" + ssrc1 + "\n")
                    f.write(sdst + " = " + temp + "\n")
                    f.write("scc = (" + temp + " >> 32) != 0\n")
                    self.number_of_temp += 1

            elif root == 'subb':
                if suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = "temp" + str(self.number_of_temp)
                    f.write("ulong " + temp + " = (ulong)" + ssrc0 + " - (ulong)" + ssrc1 + " - scc\n")
                    f.write(sdst + " = " + temp + "\n")
                    f.write("scc = (" + temp + " >> 32) & 1\n")
                    self.number_of_temp += 1

            elif root == 'swappc':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    f.write(sdst + " = pc + 4\n")
                    f.write("pc = " + ssrc0 + "\n")

            elif root == 'waitcnt':
                if flag_of_status:
                    return node
                #f.write("Not resolve yet. Maybe you lose.\n")

        elif prefix == 'v':
            # if root == "add_co":
            #     if suffix == "u32":
            # не 1.2
            if root == "add":
                if suffix == "u32":
                    vdst = instruction[1]
                    sdst = instruction[2]
                    src0 = instruction[3]
                    src1 = instruction[4]
                    new_val = "(ulong)" + src0 + " + (ulong)" + src1
                    if flag_of_status:
                        if node.state.registers[src0].type == Type.work_group_id_x_local_size_offset and \
                                node.state.registers[src1].type == Type.work_item_id_x:
                            new_integrity = node.state.registers[src1].integrity
                            node.state.registers[vdst] = Register("get_global_id(0)", Type.global_id_x, new_integrity)
                        elif node.state.registers[src0].type == Type.work_group_id_y_local_size_offset and \
                                node.state.registers[src1].type == Type.work_item_id_y:
                            new_integrity = node.state.registers[src1].integrity
                            node.state.registers[vdst] = Register("get_global_id(1)", Type.global_id_y, new_integrity)
                        elif node.state.registers[src0].type == Type.work_group_id_z_local_size_offset and \
                                node.state.registers[src1].type == Type.work_item_id_z:
                            new_integrity = node.state.registers[src1].integrity
                            node.state.registers[vdst] = Register("get_global_id(2)", Type.global_id_z, new_integrity)
                        elif node.state.registers[src0].type == Type.param \
                                and node.state.registers[src1].type in [Type.global_id_x, Type.global_id_y, Type.global_id_z, Type.unknown]:
                            new_integrity = node.state.registers[src1].integrity
                            node.state.registers[vdst] = \
                                Register(node.state.registers[src0].val + "[" + node.state.registers[src1].val + "]",
                                         Type.param_global_id_x, new_integrity)
                        elif node.state.registers[src0].type == Type.global_id_y and node.state.registers[src1].type == Type.global_id_z\
                                or node.state.registers[src0].type == Type.global_id_z and node.state.registers[src1].type == Type.global_id_y:
                            new_integrity = node.state.registers[src1].integrity
                            node.state.registers[vdst] = \
                                Register(node.state.registers[src0].val + " + " + node.state.registers[src1].val,
                                         Type.unknown, new_integrity)
                        elif node.state.registers[src0].type == Type.work_group_id_x_local_size and node.state.registers[src1].type == Type.work_item_id_x:
                            new_integrity = node.state.registers[src1].integrity
                            node.state.registers[vdst] = \
                                Register("get_global_id(0) - get_global_offset(0)", Type.unknown, new_integrity)
                        # не хватает описания sdst
                        return node
                    # if node.state.registers[vdst].integrity == Integrity.integer:
                    #     new_val = node.state.registers[vdst].val
                    #     temp = "temp" + str(self.number_of_temp)
                    #     mask = "mask" + str(self.number_of_mask)
                    #     f.write("ulong " + temp + " = " + new_val + "\n")
                    #     f.write(vdst + " = clamp ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
                    #     f.write(sdst + " = 0\n")
                    #     f.write("ulong " + mask + " = (1ULL << laneid)\n")
                    #     f.write(sdst + " = (" + sdst + " & ~" + mask + ") | ((" + temp + " >> 32) ? " + mask + " : 0\n")
                    #     self.number_of_temp += 1
                    #     self.number_of_mask += 1

            # elif root == "add3":
            #     if suffix == "u32":
            #
            # elif root == "addc_co":
            #     if suffix == "u32":
            # не 1.2

            elif root == "addc":
                if suffix == "u32":
                    vdst = instruction[1]
                    sdst = instruction[2]
                    src0 = instruction[3]
                    src1 = instruction[4]
                    ssrc2 = instruction[5]
                    new_val = " = (ulong)" + src0 + " + (ulong)" + src1
                    if flag_of_status:
                        if node.state.registers[src0].type == Type.param and node.state.registers[src1].type == Type.global_id_x:
                            new_integrity = node.state.registers[src1].integrity
                            node.state.registers[vdst] = Register(node.state.registers[src0].val + "[get_global_id(0)]", Type.param_global_id_x, new_integrity)
                        return node
                    # if node.state.registers[vdst].integrity == Integrity.integer:
                    #     new_val = node.state.registers[vdst].val
                    #     temp = "temp" + str(self.number_of_temp)
                    #     mask = "mask" + str(self.number_of_mask)
                    #     cc = "cc" + str(self.number_of_cc)
                    #     f.write("ulong " + mask + " = (1ULL << laneid)\n")
                    #     f.write("uchar " + cc + " = ((" + ssrc2 + " & " + mask + ") ? 1 : 0)\n")
                    #     f.write("ulong " + temp + " = " + new_val + " + " + cc + "\n")
                    #     f.write(sdst + " = 0\n")
                    #     f.write(vdst + " = clamp ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
                    #     f.write(sdst + " = (" + sdst + " & ~" + mask + ") | ((" + temp + " >> 32) ? " + mask + " : 0)\n")
                    #     self.number_of_temp += 1
                    #     self.number_of_mask += 1
                    #     self.number_of_mask += 1

            elif root == "alignbit":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(vdst + " = (((ulong)" + src0 + ") << 32) | " + src1 + ") >> (" + src2 + " & 31)\n")

            elif root == "alignbyte":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(vdst + " = (((ulong)" + src0 + ") << 32) | " + src1 + ") >> ((" + src2 + " & 3) * 8)\n")

            elif root == "and":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = " + src0 + " & " + src1 + "\n")

            elif root == "and_or":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(vdst + " = (" + src0 + " & " + src1 + ") | " + src2 + "\n")

            elif root == "bfi":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(vdst + " = (" + src0 + " & " + src1 + ") | (~" + src0 + " & " + src2 + ")\n")

            elif root == "cmp_eq":
                if suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " == (uint)" + src1 + "\n")

            elif root == "cmp_ge":
                if suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " >= (uint)" + src1 + "\n")

            elif root == "cmp_gt":
                if suffix == "u64":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (ulong)" + src0 + " > (uint)" + src1 + "\n")

            elif root == "cmp_lg":
                if suffix == "i32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (int)" + src0 + " != (int)" + src1 + "\n")

                elif suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " != (uint)" + src1 + "\n")

            elif root == "cmp_lt":
                if suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " < (uint)" + src1 + "\n")

            elif root == "cmpx_class":  # постоянно пишут про sdst(lane) зачем...
                if suffix == "f64":
                    f.write("Not resolve yet. Maybe you lose.\n")

            elif root == "cmpx_eq":
                if suffix == "f64":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = as_double(" + src0 + ") == as_double(" + src1 + ")\n")
                    f.write("exec = " + sdst + "\n")

            elif root == "cmpx_le":
                if suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " <= (uint)" + src1 + "\n")
                    f.write("exec = " + " = " + sdst + "\n")

            elif root == "cndmask":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    ssrc2 = instruction[4]
                    f.write(vdst + " = " + ssrc2 + " & (1ULL << laneid) ? " + src1 + " : " + src0 + "\n")

            elif root == "cvt":
                if suffix == "f32_u32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    f.write(vdst + " = (float)" + src0 + "\n")

                elif suffix == "f64_i32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    f.write(vdst + " = (double)(int)" + src0 + "\n")

                elif suffix == "u32_f32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    f.write(instruction[1] + " = 0\n")
                    f.write("if (!isnan(as_float(" + src0 + ")))\n")
                    f.write(tab + vdst + " = (int)min(convert_int_rtz(as_float(" + src0 + ")), 4294967295.0)\n")

            elif root == "div_fixup":
                if suffix == "f64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    sf0 = "sf0" + str(self.number_of_sf0)
                    sf1 = "sf1" + str(self.number_of_sf1)
                    sf2 = "sf2" + str(self.number_of_sf2)
                    f.write("double " + sf0 + " = as_double(" + src0 + ")\n")
                    f.write("double " + sf1 + " = as_double(" + src1 + ")\n")
                    f.write("double " + sf2 + " = as_double(" + src2 + ")\n")
                    f.write("if (isnan(" + sf1 + ") && !isnan(" + sf2 + "))\n")
                    f.write(tab + vdst + " = nan(" + sf1 + ")\n")
                    f.write("else if (abs(" + sf2 + "))\n")
                    f.write(tab + vdst + " = nan(" + sf2 + ")\n")  # nan не может принимать что-то нецелое
                    f.write("else if (" + sf1 + " == 0.0 && " + sf2 + " == 0.0)\n")
                    f.write(tab + vdst + " = NAN\n")
                    f.write("else if (abs(" + sf1 + ") == INFINITY)\n")
                    f.write(tab + vdst + " = -NAN\n")
                    f.write("else if (" + sf1 + " == 0.0)\n")
                    f.write(tab + vdst + " = INFINITY * sign(" + sf1 + ") * sign(" + sf2 + ")\n")
                    f.write("else if (abs(" + sf1 + ") == INFINITY)\n")
                    f.write(tab + vdst + " = sign(" + sf1 + ") * sign(" + sf2 + ") >= 0 ? 0.0 : -0.0\n")
                    f.write("else if (isnan(" + sf0 + "))\n")
                    f.write(tab + vdst + " = sign(" + sf1 + ") * sign(" + sf2 + ") * INFINITY\n")
                    f.write("else\n")
                    f.write(tab + vdst + " = " + sf0 + "\n")

            elif root == "fma":
                if suffix == "f64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(
                        vdst + " = " + "as_double(" + src0 + ") * as_double(" + src1 + ") + as_double(" + src2 + ")\n")

            elif root == "lshlrev":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = " + src1 + " << (" + src0 + " & 31)\n")

                elif suffix == "b64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                        = node.state.find_first_last_num_to_from(vdst, src1)
                    if flag_of_status:
                        to_registers_1 = name_of_register + str(last_to)
                        from_registers_1 = name_of_from + str(first_from + 1)
                        if node.state.registers[from_registers].type == Type.global_id_x \
                                and node.state.registers[name_of_register + str(first_from + 1)].val == "0":
                            # node.state.registers[to_registers] = \
                            #     Register(from_registers + " * " + str(pow(2, int(src0))), Type.global_id_x, Integrity.low_part)
                            # node.state.registers[to_registers_1] = \
                            #     Register(from_registers_1 + " * " + str(pow(2, int(src0))), Type.global_id_x, Integrity.high_part)
                            node.state.registers[to_registers] = \
                                Register(node.state.registers[from_registers].val, Type.global_id_x,
                                         Integrity.low_part)
                            node.state.registers[to_registers_1] = \
                                Register(node.state.registers[from_registers_1].val, Type.global_id_x,
                                         Integrity.high_part)
                        # нет описания под y и z
                        return node
                    #f.write(vdst + " = " + node.state.registers[to_registers].val + " + " + node.state.registers[name_of_register + str(last_to)].val + "\n") #понять, что хочу выводить
                        #f.write(vdst + " = " + src1 + " << (" + src0 + " & 63)\n")

            elif root == "lshrrev":
                if suffix == "b64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = " + src1 + " >> (" + src0 + " & 63)\n")

            elif root == "min":
                if suffix == "u32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = min(" + src0 + ", " + src1 + ")\n")

            elif root == "mul":
                if suffix == "f64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = as_double(" + src0 + ") * as_double(" + src1 + ")\n")

            elif root == "mov":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    if flag_of_status:
                        if node.state.registers.get(src0) is not None:
                            node.state.registers[vdst] = \
                                Register(node.state.registers[src0].val, node.state.registers[src0].type, Integrity.integer)
                        else:
                            node.state.registers[vdst] = Register(src0, Type.int32, Integrity.integer)
                        return node
                    #f.write(vdst + " = " + node.state.registers[vdst].val + "\n")
                    # f.write(vdst + " = " + src0 + "\n")
        else:
            f.write("Not resolve yet. Maybe you lose.\n")
    # нет таких инструкций


def main():
    f = open('experiments\\train_OpenCL.txt', 'w')
    decompiler = Decompiler()
    decompiler.process_src(f)
    f.close()


if __name__ == "__main__":
    main()
