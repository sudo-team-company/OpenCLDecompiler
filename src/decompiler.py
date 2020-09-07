import copy
from collections import deque
from integrity import Integrity
from node import Node
from region import Region
from register import Register
from state import State
from type_of_node import TypeNode
from type_of_reg import Type


class Decompiler:
    def __init__(self, output_file):
        self.output_file = output_file
        self.usesetup = False
        self.size_of_work_groups = []
        self.cfg = None
        self.improve_cfg = None
        # self.last_node = None
        self.number_of_temp = 0  # versions for asm code if decompilation is not success (версии для ассемблерного кода в случае отсутствия перевода)
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
        self.from_node = {}  # the label the vertex is expecting -> node (метка, которую ожидает вершина -> вершина ("лист ожидания"))
        self.starts_regions = {}  # Node or Region -> Region
        self.ends_regions = {}  # Node or Region -> Region
        self.label = None
        self.parents_of_label = []
        self.flag_of_else = False
        self.version_wait = None
        self.type_params = {}
        self.variables = {}
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

    def process_config(self, set_of_config, name_of_program):
        dimensions = set_of_config[0][6:]
        g_id = ["s6", "s7", "s8"]
        if ".usesetup" in set_of_config:
            g_id = ["s8", "s9", "s10"]
            self.usesetup = True
        if len(dimensions) > 0:
            self.initial_state.registers[g_id[0]] = Register("get_group_id(0)", Type.work_group_id_x, Integrity.integer)
            self.initial_state.registers[g_id[0]].add_version(g_id[0], self.versions[g_id[0]])
            self.versions[g_id[0]] += 1
            self.initial_state.registers["v0"] = Register("get_local_id(0)", Type.work_item_id_x, Integrity.integer)
            self.initial_state.registers["v0"].add_version("v0", self.versions["v0"])
            self.versions["v0"] += 1
        if len(dimensions) > 1:
            self.initial_state.registers[g_id[1]] = Register("get_group_id(1)", Type.work_group_id_y, Integrity.integer)
            self.initial_state.registers[g_id[1]].add_version(g_id[1], self.versions[g_id[1]])
            self.versions[g_id[1]] += 1
            self.initial_state.registers["v1"] = Register("get_local_id(1)", Type.work_item_id_y, Integrity.integer)
            self.initial_state.registers["v1"].add_version("v1", self.versions["v1"])
            self.versions["v1"] += 1
        if len(dimensions) > 2:
            self.initial_state.registers[g_id[2]] = Register("get_group_id(2)", Type.work_group_id_z, Integrity.integer)
            self.initial_state.registers[g_id[2]].add_version(g_id[2], self.versions[g_id[2]])
            self.versions[g_id[2]] += 1
            self.initial_state.registers["v2"] = Register("get_local_id(2)", Type.work_item_id_z, Integrity.integer)
            self.initial_state.registers["v2"].add_version("v2", self.versions["v2"])
            self.versions["v2"] += 1
        if set_of_config[1].find(".cws") != "-1":
            self.size_of_work_groups = set_of_config[1].replace(',', ' ').split()[1:]
            self.output_file.write("__kernel __attribute__((reqd_work_group_size(" + self.size_of_work_groups[0] + ", "
                                   + self.size_of_work_groups[1] + ", " + self.size_of_work_groups[2] + ")))\n")
        else:
            self.output_file.write("__kernel ")
        self.sgprsnum = int(set_of_config[2][10:])
        self.vgprsnum = int(set_of_config[3][10:])
        if not self.usesetup:
            self.initial_state.registers["s4"] = Register("s4", Type.arguments_pointer, Integrity.low_part)
            self.initial_state.registers["s4"].add_version("s4", self.versions["s4"])
            self.versions["s4"] += 1
            self.initial_state.registers["s5"] = Register("s5", Type.arguments_pointer, Integrity.high_part)
            self.initial_state.registers["s5"].add_version("s5", self.versions["s5"])
            self.versions["s5"] += 1
        else:
            self.initial_state.registers["s6"] = Register("s6", Type.arguments_pointer, Integrity.low_part)
            self.initial_state.registers["s6"].add_version("s6", self.versions["s6"])
            self.versions["s6"] += 1
            self.initial_state.registers["s7"] = Register("s7", Type.arguments_pointer, Integrity.high_part)
            self.initial_state.registers["s7"].add_version("s7", self.versions["s7"])
            self.versions["s7"] += 1
        parameters = set_of_config[17:]
        if set_of_config[4].find("localsize") != -1:
            self.localsize = int(set_of_config[4][11:])
        for num_of_setting in list(range(0, len(set_of_config))):
            if set_of_config[num_of_setting].find(".arg") != -1 and set_of_config[num_of_setting].find("_.") == -1:
                parameters = set_of_config[num_of_setting:]
                break
        self.output_file.write("void " + name_of_program + "(")
        num_of_param = 0
        flag_start = False
        for param in parameters:
            if not flag_start:
                flag_start = True
            else:
                self.output_file.write(", ")
            set_of_param = param.strip().replace(',', ' ').split()
            name_param = set_of_param[1]
            type_param = set_of_param[3]
            flag_param = ""
            if len(set_of_param) > 4:
                flag_param = "__" + set_of_param[4] + " "
            if type_param[-1] == "*":
                name_param = "*" + name_param
                type_param = type_param[:-1]
            self.params["param" + str(num_of_param)] = name_param
            self.type_params[name_param] = type_param
            self.output_file.write(flag_param + type_param + " " + name_param)
            num_of_param += 1
        self.output_file.write(")\n")

    def change_cfg_for_else_structure(self, curr_node, instruction):
        self.parents_of_label[0].children.remove(self.label)
        self.parents_of_label[1].children.remove(self.label)
        last_node = self.parents_of_label[1]
        last_node_state = copy.deepcopy(self.parents_of_label[1].state)
        if curr_node.parent[0].instruction[0].find("v_mov") != -1:
            last_node_state.registers[curr_node.parent[0].instruction[1]] \
                = curr_node.state.registers[curr_node.parent[0].instruction[1]]
        self.from_node[instruction[1]].remove(curr_node)
        if self.from_node.get(instruction[1], None) is None:
            self.from_node[instruction[1]] = [self.parents_of_label[0]]
        else:
            self.from_node[instruction[1]].append(self.parents_of_label[0])
        self.flag_of_else = False
        return last_node, last_node_state

    def update_reg_version(self, reg, curr_node, max_version, version_of_reg):
        if len(version_of_reg) == 1:
            if curr_node.state.registers[reg] is None:
                for p in curr_node.parent:
                    if p.state.registers[reg] is not None:
                        curr_node.state.registers[reg] = p.state.registers[reg]
                        break
        elif len(version_of_reg) > 1:
            curr_node.state.registers[reg].version = reg + "_" + str(max_version + 1)
            curr_node.state.registers[reg].prev_version = list(version_of_reg)
            variable = "var" + str(self.num_of_var)
            if curr_node.state.registers[reg].type == Type.param_global_id_x:
                variable = "*" + variable
            curr_node.state.registers[reg].val = variable
            self.num_of_var += 1
            for ver in version_of_reg:
                self.variables[ver] = variable
        return curr_node

    def process_src(self, name_of_program, set_of_config, set_of_instructions):
        self.process_config(set_of_config, name_of_program)
        last_node = Node("", self.initial_state)  # root
        last_node_state = self.initial_state
        self.cfg = last_node
        for row in set_of_instructions:
            instruction = row.strip().replace(',', ' ').split()
            curr_node = self.make_cfg_node(instruction, last_node_state, last_node)
            # curr_node.add_parent(last_node)
            last_node_state = copy.deepcopy(curr_node.state)
            if last_node is not None and last_node.instruction != "branch" and curr_node not in last_node.children:
                last_node.add_child(curr_node)
            last_node = curr_node
            if last_node is not None and last_node.instruction == "branch":
                last_node_state = copy.deepcopy(self.initial_state)
            if instruction[0][0] == ".":
                self.label = curr_node
                self.parents_of_label = curr_node.parent
                self.flag_of_else = True
            elif (instruction[0].find("andn2") != -1 or instruction[0].find("v_mov") != -1) and self.flag_of_else:
                continue
            elif instruction[0].find("cbranch") != -1 and self.flag_of_else:
                last_node, last_node_state = self.change_cfg_for_else_structure(curr_node, instruction)
            else:
                self.flag_of_else = False
            if instruction[0][0] == "." and len(curr_node.parent) > 1:
                for reg in curr_node.parent[0].state.registers:
                    # if reg.find("s") == -1:
                    version_of_reg = set()
                    max_version = 0
                    for parent in curr_node.parent:
                        if parent.state.registers.get(reg) is not None and parent.state.registers[reg] is not None \
                                and parent.state.registers[reg].version is not None:
                            par_version = parent.state.registers[reg].version
                            if len(version_of_reg) == 0:
                                max_version = int(par_version[par_version.find("_") + 1:])
                                version_of_reg.add(par_version)
                            else:
                                version_of_reg.add(par_version)
                                if int(par_version[par_version.find("_") + 1:]) > max_version:
                                    max_version = int(par_version[par_version.find("_") + 1:])
                    curr_node = self.update_reg_version(reg, curr_node, max_version, version_of_reg)
                last_node_state = curr_node.state
            if instruction != "branch" and len(instruction) > 1:
                for num_of_reg in list(range(1, len(curr_node.instruction))):
                    register = curr_node.instruction[num_of_reg]
                    if (curr_node.instruction[0].find("flat_store") != -1 or num_of_reg > 1) and len(register) > 1 \
                            and curr_node.instruction[0].find("cnd") == -1:
                        if register[1] == "[":
                            register = register[0] + register[2: register.find(":")]
                        if curr_node.state.registers.get(register) is not None \
                                and curr_node.state.registers[register].val.find("var") != -1 \
                                and curr_node.state.registers[register].type_of_data is not None \
                                and register != "vcc":
                            if curr_node.parent[0].state.registers[register].val.find("*var") != -1:
                                self.names_of_vars[curr_node.parent[0].state.registers[register].val] = \
                                    curr_node.parent[0].state.registers[register].type_of_data
                            else:
                                self.names_of_vars[curr_node.parent[0].state.registers[register].val] = \
                                    curr_node.state.registers[register].type_of_data
                        # if register[1] != "[":
                        #     if curr_node.state.registers.get(register) is not None \
                        #             and curr_node.state.registers[register].val.find("var") != -1:
                        #         self.names_of_vars[curr_node.parent[0].state.registers[register].val] = curr_node.state.registers[register].type_of_data
                        # else:
                        #     reg = register[0] + register[2: register.find(":")]
                        #     if curr_node.state.registers.get(reg) is not None \
                        #             and curr_node.state.registers[reg].val.find("var") != -1:
                        #         self.names_of_vars[curr_node.parent[0].state.registers[reg].val] = curr_node.state.registers[reg].type_of_data

        # self.make_version()
        self.process_cfg()
        self.output_file.write("{\n")
        for var in set(self.variables.values()):
            if var in self.names_of_vars.keys():
                type_of_var = self.make_type(self.names_of_vars[var])
                self.output_file.write("    " + type_of_var + " " + var + ";\n")
        offsets = list(self.lds_vars.keys())
        offsets.append(self.localsize)
        offsets.sort()
        for key in list(range(len(offsets) - 1)):
            size_var = int((offsets[key + 1] - offsets[key]) / (int(self.lds_vars[offsets[key]][1][1:]) / 8))
            type_of_var = self.make_type(self.lds_vars[offsets[key]][1])
            self.output_file.write(
                "    __local " + type_of_var + " " + self.lds_vars[offsets[key]][0] + "[" + str(size_var) + "]" + ";\n")
        self.make_output(self.improve_cfg, '    ')
        self.output_file.write("}\n")
        # while curr_node.children:
        #     self.to_openCL(curr_node.children[0], False)
        #     curr_node = curr_node.children[0]

    def make_type(self, asm_type):
        if asm_type == "u32":
            return "uint"
        elif asm_type == "i32":
            return "int"
        elif asm_type == "u64":
            return "ulong"
        elif asm_type == "i64":
            return "long"
        elif asm_type == "b32":
            return "uint"
        elif asm_type == "dword":
            return "int"
        elif asm_type == "f32":
            return "float"

    def make_cfg_node(self, instruction, last_node_state, last_node):
        node = Node(instruction, last_node_state)
        if last_node.instruction != "branch":
            node.add_parent(last_node)
        return self.to_openCL(node, True)

    def make_version(self):
        curr_node = self.cfg
        visited = [curr_node]
        q = deque()
        q.append(curr_node.children[0])
        while q:
            curr_node = q.popleft()
            if curr_node not in visited:
                visited.append(curr_node)
                if len(curr_node.parent) == 1:
                    for child in curr_node.children:
                        if child not in visited:
                            q.append(child)
                else:
                    if self.version_wait is None:
                        self.version_wait = curr_node
                        visited.remove(curr_node)
                    elif self.version_wait == curr_node:
                        self.update_versions(curr_node)
                        self.version_wait = None
                        for child in curr_node.children:
                            if child not in visited:
                                q.append(child)
        q.append(curr_node)
        visited = []
        num_of_variable = 0
        not_touch = []
        local_vars = {}
        while q:
            curr_node = q.popleft()
            if curr_node not in visited:
                visited.append(curr_node)
                if len(curr_node.instruction) > 1:
                    for register in curr_node.instruction[1:]:
                        if curr_node.state.registers.get(register) is not None and register[1] != "[":
                            variants = []
                            for l_v in local_vars.keys():
                                if l_v.find(register) != -1:
                                    variants.append(l_v)
                            for reg_version in variants:
                                if curr_node.state.registers[register].version == reg_version:
                                    curr_node.state.registers[register].val = local_vars[reg_version]
                                    curr_node.state.registers[register].version = None
                                    curr_node.state.registers[register].prev_version = []
                                    break
                        else:
                            reg = register[0] + register[2: register.find(":")]
                            if curr_node.state.registers.get(reg) is not None:
                                not_touch.append(register[0] + register[register.find(":") + 1: -1])
                                variants = []
                                for l_v in local_vars.keys():
                                    if l_v.find(reg) != -1:
                                        variants.append(l_v)
                                for reg_version in variants:
                                    if curr_node.state.registers[reg].version == reg_version:
                                        curr_node.state.registers[reg].val = local_vars[reg]
                                        curr_node.state.registers[reg].version = None
                                        curr_node.state.registers[reg].prev_version = []
                    # if len(curr_node.instruction) > 2:
                    for num_of_reg in list(range(1, len(curr_node.instruction))):
                        register = curr_node.instruction[num_of_reg]
                        if (curr_node.instruction[0].find("flat_store") != -1 or num_of_reg > 1) and len(register) > 1:
                            if register[1] != "[":
                                if curr_node.state.registers.get(register) is not None \
                                        and len(curr_node.state.registers[register].prev_version) > 1 \
                                        and curr_node.state.registers[register].version not in not_touch:
                                    versions = curr_node.state.registers[register].prev_version
                                    var = "var" + str(num_of_variable)
                                    if num_of_reg == 1 and curr_node.state.registers[register].type.param_global_id_x:
                                        var = "*" + var
                                    num_of_variable += 1
                                    local_vars[curr_node.state.registers[register].version] = var
                                    curr_node.state.registers[register].val = var
                                    for v in versions:
                                        self.variables[v] = var
                            else:
                                reg = register[0] + register[2: register.find(":")]
                                # not_touch.append(register[register.find(":") + 1 : -1])
                                if curr_node.state.registers.get(reg) is not None and len(
                                        curr_node.state.registers[reg].prev_version) > 1 \
                                        and curr_node.state.registers[reg].version not in not_touch:
                                    versions = curr_node.state.registers[reg].prev_version
                                    var = "var" + str(num_of_variable)
                                    if num_of_reg == 1 and curr_node.state.registers[reg].type.param_global_id_x:
                                        var = "*" + var
                                    num_of_variable += 1
                                    local_vars[curr_node.state.registers[reg].version] = var
                                    curr_node.state.registers[reg].val = var
                                    for v in versions:
                                        self.variables[v] = var
                for parent in curr_node.parent:
                    if parent not in visited:
                        q.append(parent)

    def update_versions(self, node):
        diff_regs = {}
        parent_0 = node.parent[0].state.registers
        parent_1 = node.parent[1].state.registers
        for key in parent_0.keys():
            if parent_0.get(key) is not None and parent_1.get(key) is not None and parent_0[key].version != parent_1[
                key].version and key.find("v") != -1:  # val and ver
                diff_regs[key] = [parent_0[key].version, parent_1[key].version]
        visited = []
        q = deque()
        q.append(node)
        while q:
            curr_node = q.popleft()
            if curr_node not in visited:
                visited.append(curr_node)
                for key in diff_regs:
                    if curr_node.state.registers[key].version == diff_regs[key][
                        1]:  # and len(curr_node.state.registers[key].prev_version) > 0:
                        # if curr_node.state.registers[key].version == diff_regs[key][0][:diff_regs[key][0].find("_")] + "_" + str(int(diff_regs[key][0][diff_regs[key][0].find("_") + 1:]) + 1):
                        curr_node.state.registers[key].prev_version = diff_regs[key]
                    # update_version = curr_node.state.registers[key].version
                    # update_version = update_version[:update_version.find("_")] + "_" + str(int(update_version[update_version.find("_") + 1:]) + 2)
                    # curr_node.state.registers[key].version = update_version
                    curr_node.state.registers[key].update(key)
                for child in curr_node.children:
                    if child not in visited:
                        q.append(child)

    def make_op(self, node, register0, register1, operation):
        new_val = ""
        new_val0 = ""
        new_val1 = ""
        register0_flag = True
        register1_flag = True
        if register0.find("s") != -1 or register0.find("v") != -1:
            new_val0 = node.state.registers[register0].val
        else:
            new_val0 = register0
            register0_flag = False
        if register1.find("s") != -1 or register1.find("v") != -1:
            new_val1 = node.state.registers[register1].val
        else:
            new_val1 = register1
            register1_flag = False
        if new_val0.find("-") != -1 or new_val0.find("+") != -1 or new_val0.find("*") != -1 or new_val0.find("/") != -1:
            new_val0 = "(" + new_val0 + ")"
        if new_val1.find("-") != -1 or new_val1.find("+") != -1 or new_val1.find("*") != -1 or new_val1.find("/") != -1:
            new_val1 = "(" + new_val1 + ")"
        new_val = new_val0 + operation + new_val1
        return new_val, register0_flag, register1_flag

    def union_regions(self, before_region, curr_region, next_region, start_region):
        start_now = start_region
        if len(before_region) == 1:
            before_region = before_region[0]
            if before_region.type != TypeNode.basic:
                region = Region(TypeNode.linear, before_region)
                region.end = curr_region
                if before_region == start_now:
                    start_now = region
                else:
                    parent = before_region.parent[0]
                    parent.children.remove(before_region)
                    parent.add_child(region)
                    region.add_parent(parent)
                if next_region is not None:
                    next_region.parent.remove(curr_region)
                    next_region.add_parent(region)
                    region.add_child(next_region)
                if next_region is not None and next_region != TypeNode.basic and len(curr_region.parent) == 1:
                    region_all = Region(TypeNode.linear, before_region)
                    region_all.end = next_region
                    if start_now == region:
                        start_now = region_all
                    else:
                        parent = before_region.parent[0]
                        parent.children.remove(region)
                        parent.add_child(region_all)
                        region_all.add_parent(parent)
                    if next_region.children:
                        child = next_region.children[0]
                        child.parent.remove(next_region)
                        child.add_parent(region_all)
                        region_all.add_child(child)
                return start_now

        if next_region is not None and next_region != TypeNode.basic and len(curr_region.parent) == 1:
            region_all = Region(TypeNode.linear, curr_region)
            region_all.end = next_region
            for prev_r in before_region:
                prev_r.children.remove(curr_region)
                prev_r.add_child(region_all)
                region_all.add_parent(prev_r)
            if next_region.children:
                child = next_region.children[0]
                child.parent.remove(next_region)
                child.add_parent(region_all)
                region_all.add_child(child)
        return start_region

    def check_if(self, curr_region):
        if curr_region.type == TypeNode.basic and len(curr_region.children) == 2 \
                and (len(curr_region.children[0].children) > 0
                     and curr_region.children[0].children[0] == curr_region.children[1]
                     or len(curr_region.children[1].children) > 0
                     and curr_region.children[1].children[0] == curr_region.children[0]):
            # and curr_region.children[1].type == TypeNode.basic \
            return True
        else:
            return False

    def check_if_else(self, curr_region):
        if curr_region.type == TypeNode.basic and len(curr_region.children) == 2 \
                and len(curr_region.children[0].children) > 0 \
                and len(curr_region.children[1].children) > 0 \
                and curr_region.children[0].children[0] == curr_region.children[1].children[0]:
            return True
        else:
            return False

    def add_parent_and_child(self, before_r, next_r, region, pred_child, pred_parent):
        for i in list(range(0, len(before_r))):
            before_r[i].children.remove(pred_child[i])
            before_r[i].add_child(region)
            region.add_parent(before_r[i])
        if next_r is not None:
            next_r.parent.remove(pred_parent)
            next_r.add_parent(region)
            region.add_child(next_r)

    def process_cfg(self):
        curr_node = self.cfg
        region = Region(TypeNode.linear, curr_node)
        self.starts_regions[curr_node] = region
        self.ends_regions[curr_node] = region
        visited = [curr_node]
        q = deque()
        q.append(curr_node.children[0])
        while q:
            curr_node = q.popleft()
            if curr_node not in visited:
                visited.append(curr_node)
                if len(curr_node.parent) == 1 and (len(curr_node.children) == 1 or len(curr_node.children) == 0):
                    if self.ends_regions[curr_node.parent[0]].type == TypeNode.linear:
                        region = self.ends_regions.pop(curr_node.parent[0])
                        region.end = curr_node
                        self.ends_regions[curr_node] = region
                    else:
                        region = Region(TypeNode.linear, curr_node)
                        self.starts_regions[curr_node] = region
                        self.ends_regions[curr_node] = region
                        parent = self.ends_regions[curr_node.parent[0]]
                        parent.add_child(region)
                        region.add_parent(parent)

                else:
                    region = Region(TypeNode.basic, curr_node)
                    self.starts_regions[curr_node] = region
                    self.ends_regions[curr_node] = region
                    for c_p in curr_node.parent:
                        if c_p in visited:
                            if self.ends_regions.get(c_p) is not None:
                                parent = self.ends_regions[c_p]
                            else:
                                parent = self.ends_regions[curr_node.parent[0].children[0]]
                            parent.add_child(region)
                            region.add_parent(parent)

                for child in curr_node.children:
                    if child not in visited:
                        q.append(child)
                    else:
                        region.add_child(self.starts_regions[child])
                        self.starts_regions[child].add_parent(region)
        start_region = self.starts_regions[self.cfg]
        visited = []
        q = deque()
        q.append(start_region)
        while start_region.children:
            curr_region = q.popleft()
            if curr_region not in visited:
                visited.append(curr_region)
                if curr_region.type != TypeNode.linear:

                    if self.check_if(curr_region):
                        last_if_region = curr_region.children[1]
                        # if last_if_region.children and last_if_region.children[0].type == TypeNode.linear \
                        #         and last_if_region.children[0].start == last_if_region.children[0].end \
                        #         and last_if_region.children[0].start.instruction.find("s_andn2") != -1 \
                        #         and last_if_region.children[0].children \
                        #         and last_if_region.children[0].children[0] != TypeNode.linear \
                        #         and self.check_if(last_if_region.children[0].children[0]):
                        #     region = Region(TypeNode.ifelsestatement, curr_region)
                        #     if_body = curr_region.children[0]
                        #     # if isinstance(if_body.start, Node):
                        #     last_state_if = if_body.end.state.registers
                        #     last_if_region = curr_region.children[1]
                        #     and_n2 = last_if_region.children[0]
                        #     else_start = and_n2.children[0]
                        #     else_body = else_start.children[0]
                        #     last_state_else = else_body.end.state.registers
                        #     last_else_region = else_start.children[1]
                        #     for key in last_state_if:
                        #         if last_state_else[key] is not None and last_state_if[key] is not None \
                        #                 and last_state_else[key].val == last_state_if[key].val \
                        #                 and last_state_else[key].type == last_state_if[key].type \
                        #                 and last_state_else[key].integrity == last_state_if[key].integrity:
                        #             last_else_region.start.state.registers[key] = last_state_if[key]
                        #     curr_node = last_else_region.start
                        #     while curr_node.children:
                        #         node = self.to_openCL(Node(curr_node.children[0].instruction, copy.deepcopy(curr_node.state)), True)
                        #         curr_node.children[0].state = copy.deepcopy(node.state)
                        #         curr_node = curr_node.children[0]
                        #     visited.extend([if_body, last_if_region, and_n2, else_start, else_body, last_else_region])
                        #     before_r = curr_region.parent[0]
                        #     next_r = last_else_region.children[0]
                        #     self.add_parent_and_child(before_r, next_r, region, curr_region, last_else_region)
                        #     start_region = self.union_regions(before_r, region, next_r, start_region)
                        #
                        # else:
                        region = Region(TypeNode.ifstatement, curr_region)
                        child0 = curr_region.children[0] if len(curr_region.children[0].parent) == 1 else \
                            curr_region.children[1]
                        child1 = curr_region.children[1] if len(curr_region.children[1].parent) == 2 else \
                            curr_region.children[0]
                        region.end = child1
                        visited.append(child1)
                        visited.append(child0)
                        before_r = [curr_region.parent[0]]
                        prev_child = [curr_region]
                        if len(child0.parent) > 1:
                            if child0.parent[0] not in [child1, curr_region]:
                                before_r.append(child0.parent[0])
                                prev_child.append(child0)
                            if child0.parent[1] not in [child1, curr_region]:
                                before_r = child0.parent[1]
                                prev_child.append(child0)
                        if len(child1.parent) > 1:
                            if child1.parent[0] not in [child0, curr_region]:
                                before_r.append(child1.parent[0])
                                prev_child.append(child1)
                            if child1.parent[1] not in [child0, curr_region]:
                                before_r.append(child1.parent[1])
                                prev_child.append(child1)
                        next_r = child1.children[0] if len(child1.children) > 0 else None
                        self.add_parent_and_child(before_r, next_r, region, prev_child, region.end)
                        start_region = self.union_regions(before_r, region, next_r, start_region)
                        # if curr_region.children:
                        #     for child in curr_region.children:
                        if region.children:
                            for child in region.children:
                                if child not in visited:
                                    q.append(child)
                        else:
                            q = deque()
                            q.append(start_region)
                            visited = []
                    elif self.check_if_else(curr_region):
                        region = Region(TypeNode.ifelsestatement, curr_region)
                        child0 = curr_region.children[0]
                        child1 = curr_region.children[1]
                        region.end = child0.children[0]
                        prev_child = [curr_region]
                        visited.append(child1)
                        visited.append(child0)
                        visited.append(region.end)
                        before_r = [curr_region.parent[0]]
                        next_r = region.end.children[0]
                        if len(region.end.parent) > 2:
                            for p in region.end.parent:
                                if p not in [child0, child1]:
                                    before_r.append(p)
                                    prev_child.append(region.end)
                        self.add_parent_and_child(before_r, next_r, region, prev_child, region.end)
                        start_region = self.union_regions(before_r, region, next_r, start_region)
                        # if curr_region.children:
                        #     for child in curr_region.children:
                        if region.children:
                            for child in region.children:
                                if child not in visited:
                                    q.append(child)
                        else:
                            q = deque()
                            q.append(start_region)
                            visited = []
                    else:
                        if curr_region.children:
                            for child in curr_region.children:
                                if child not in visited:
                                    q.append(child)
                        else:
                            q = deque()
                            q.append(start_region)
                            visited = []

                else:
                    if curr_region.children:
                        for child in curr_region.children:
                            if child not in visited:
                                q.append(child)
                    else:
                        q = deque()
                        q.append(start_region)
                        visited = []
        self.improve_cfg = start_region

    def make_output(self, region, indent):
        if region.type == TypeNode.linear:
            if isinstance(region.start, Node):
                reg = region.start
                if region.start == self.cfg:
                    reg = self.cfg.children[0]
                while reg != region.end:
                    new_output = self.to_openCL(reg, False)
                    if new_output != "":
                        self.output_file.write(indent + new_output + ";\n")
                    reg = reg.children[0]
                new_output = self.to_openCL(reg, False)
                if new_output != "":
                    self.output_file.write(indent + new_output + ";\n")
            else:
                reg = region.start
                self.make_output(reg, indent)
                while reg != region.end:
                    reg = reg.children[0]
                    self.make_output(reg, indent)
        elif region.type == TypeNode.ifstatement:
            for key in self.variables.keys():
                reg = key[:key.find("_")]
                if region.start.start.parent[0].state.registers[reg] is not None and \
                        region.start.start.parent[0].state.registers[reg].version == key and self.variables[
                    key] in self.names_of_vars.keys():
                    self.output_file.write(
                        indent + self.variables[key] + " = " + region.start.start.parent[0].state.registers[
                            reg].val + ";\n")
            self.output_file.write(indent + "if (")
            self.output_file.write(self.to_openCL(region.start.start, False))
            self.output_file.write(") {\n")
            self.make_output(region.start.children[0], indent + '    ')
            for key in self.variables.keys():
                reg = key[:key.find("_")]
                r_node = region.end.start
                while not isinstance(r_node, Node):
                    r_node = r_node.start
                if r_node.parent[0].state.registers[reg].version == key and self.variables[
                    key] in self.names_of_vars.keys():
                    self.output_file.write(
                        indent + "    " + self.variables[key] + " = " + r_node.parent[0].state.registers[
                            reg].val + ";\n")
            self.make_output(region.start.children[1], indent + '    ')
            self.output_file.write(indent + "}\n")
        elif region.type == TypeNode.ifelsestatement:
            # self.output_file.write("    int variable\n")
            self.output_file.write(indent + "if (")
            self.output_file.write(self.to_openCL(region.start.start, False))
            self.output_file.write(") {\n")
            if_body = region.start.children[0]
            self.make_output(if_body, indent + '    ')
            # if isinstance(if_body.start, Node) and if_body.end.instruction.find("store") == -1:
            #     last_node = if_body.end
            #     reg = last_node.instruction.split()[1][:-1]
            #     val_of_reg = last_node.state.registers[reg].val
            #     self.output_file.write("      variable = " + val_of_reg + "\n")
            #     self.initial_state.registers[reg] = Register("variable", Type.program_param, Integrity.integer)
            for key in self.variables.keys():
                reg = key[:key.find("_")]
                r_node = region.end.start
                while not isinstance(r_node, Node):
                    r_node = r_node.start
                if r_node.parent[1].state.registers.get(reg) is not None \
                        and r_node.parent[1].state.registers[reg].version == key and self.variables[
                    key] in self.names_of_vars.keys():
                    if self.variables[key].find("*") == -1:
                        self.output_file.write(
                            indent + "    " + self.variables[key] + " = " + r_node.parent[1].state.registers[
                                reg].val + ";\n")
                    else:
                        self.output_file.write(indent + "    " + self.variables[key][1:] + " = &" +
                                               r_node.parent[1].state.registers[reg].val + ";\n")
            self.output_file.write(indent + "}\n")
            # last_if_region = region.start.children[1]
            # and_n2 = last_if_region.children[0]
            # else_start = and_n2.children[0]
            # else_body = else_start.children[0]
            # last_else_region = else_start.children[1]
            else_body = region.start.children[1]
            self.output_file.write(indent + "else {\n")
            self.make_output(else_body, indent + '    ')
            # if isinstance(else_body.start, Node) and else_body.end.instruction.find("store") == -1:
            #     reg = else_body.end.instruction.split()[1][:-1]
            #     self.output_file.write("      variable = " + else_body.end.state.registers[reg].val + "\n")
            #     self.initial_state.registers[reg] = Register("variable", Type.program_param, Integrity.integer)
            for key in self.variables.keys():
                reg = key[:key.find("_")]
                if region.end.start.parent[0].state.registers[reg].version == key and self.variables[
                    key] in self.names_of_vars.keys():
                    if self.variables[key].find("*") == -1:
                        self.output_file.write(
                            indent + "    " + self.variables[key] + " = " + region.end.start.parent[0].state.registers[
                                reg].val + ";\n")
                    else:
                        self.output_file.write(indent + "    " + self.variables[key][1:] + " = &" +
                                               region.end.start.parent[0].state.registers[reg].val + ";\n")
            self.output_file.write(indent + "}\n")

    def ds_add(self, node, instruction, flag_of_status, suffix):
        if suffix == "u32":
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            name = self.lds_vars[offset][0] + "[" + node.state.registers[addr].val + "]"
            if flag_of_status:
                node.state.registers[name].val = \
                    node.state.registers[name].val + " + " + node.state.registers[vdata0].val
                node.state.make_version(self.versions, name)
                node.state.registers[name].type_of_data = suffix
                return node
            output_string = name + " += " + node.state.registers[vdata0].val
            return output_string

    def ds_bpermute(self, suffix, instruction):
        if suffix == "b32":
            tab = "    "
            tmp = "tmp" + str(self.number_of_tmp)
            dst = instruction[1]
            addr = instruction[2]
            src = instruction[3]
            offset = instruction[4][7:]
            self.output_file.write("uint64 " + tmp + "\n")  # именно массив
            self.output_file.write("for (short i = 0; i < 64; i++)\n")
            self.output_file.write("{\n")
            self.output_file.write(tab + "uint lane_id = " + addr + "[(i + (" + offset + " >> 2)) & 63]\n")
            self.output_file.write(
                tab + tmp + "[i] = exec & (1ULL << lane_id) != 0) ? " + src + "[lane_id] : 0\n")
            self.output_file.write("}\n")
            self.output_file.write("for (short i = 0; i < 64; i++)\n")
            self.output_file.write(tab + "if (exec & (1ULL << i) != 0)\n")
            self.output_file.write(tab + tab + dst + "[i] = " + tmp + "[i]\n")
            self.number_of_tmp += 1

    def ds_read(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "b32":
            vdst = instruction[1]
            addr = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            name = self.lds_vars[offset][0] + "[" + node.state.registers[addr].val + "]"
            if flag_of_status:
                node.state.registers[vdst] = Register(name, node.state.registers[name].type, Integrity.integer)
                node.state.make_version(self.versions, vdst)
                node.state.registers[vdst].type_of_data = "u" + suffix[1:]
                return node
            return output_string
            # self.output_file.write(vdst + " = *(uint)(ds + ((" + addr + " + " + offset + ") & ~3)\n")

        elif suffix == "b64":
            vdst = instruction[1]
            addr = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            # name = self.lds_vars[offset][0] + "[" + node.state.registers[addr].var + "]"
            # if flag_of_status:
            #     node.state.registers[vdst] = Register(name, node.state.registers[name].type, Integrity.integer)
            #     node.state.make_version(self.versions, vdst)
            #     node.state.registers[vdst].type_of_data = "u" + suffix[1:]
            #     return node
            # return output_string
            # self.output_file.write(vdst + " = *(ulong)(ds + ((" + addr + " + " + offset + ") & ~7)\n")

    def ds_read2(self, instruction, suffix):
        if suffix == "b64":
            v0 = "v0" + str(self.number_of_v0)
            v1 = "v1" + str(self.number_of_v1)
            vdst = instruction[1]
            addr = instruction[2]
            offset0 = instruction[3][8:]
            offset1 = instruction[4][8:]
            self.output_file.write(
                "ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7)\n")
            self.output_file.write(
                "ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
            self.output_file.write(vdst + " = *" + v0 + " | (ulonglong(*" + v1 + ") << 64)\n")  # uint128????
            self.number_of_v0 += 1
            self.number_of_v1 += 1

    def ds_write(self, node, instruction, flag_of_status, suffix):
        if suffix == "b32":
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            if self.lds_vars.get(offset) is None:
                self.lds_vars[offset] = ["lds" + str(self.lds_var_number), "u" + suffix[1:]]
                self.lds_var_number += 1
            name = self.lds_vars[offset][0] + "[" + node.state.registers[addr].val + "]"
            if flag_of_status:
                node.state.registers[name] = \
                    Register(node.state.registers[vdata0].val, node.state.registers[vdata0].type, Integrity.integer)
                if self.versions.get(name) is None:
                    self.versions[name] = 0
                node.state.make_version(self.versions, name)
                node.state.registers[name].type_of_data = "u" + suffix[1:]
                return node
            output_string = name + " = " + node.state.registers[name].val
            return output_string
            # v = "v" + str(self.number_of_v)
            # self.output_file.write("uint* " + v + "\n")
            # self.output_file.write(v + " = (uint*)(ds + ((" + addr + " + " + offset + ") & ~3))\n")
            # self.output_file.write("*" + v + " = " + vdata0 + "\n")
            # self.number_of_v += 1

        elif suffix == "b64":
            v = "v" + str(self.number_of_v)
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = instruction[3][7:]
            self.output_file.write("ulong* " + v + "\n")
            self.output_file.write(v + " = (ulong*)(ds + ((" + addr + " + " + offset + ") & ~3))\n")
            self.output_file.write("*" + v + " = " + vdata0 + "\n")
            self.number_of_v += 1

    def ds_write2(self, instruction, suffix):
        if suffix == "b64":
            v0 = "v0" + str(self.number_of_v0)
            v1 = "v1" + str(self.number_of_v1)
            addr = instruction[1]
            vdata0 = instruction[2]
            vdata1 = instruction[3]
            offset0 = instruction[4][8:]
            offset1 = instruction[5][8:]
            self.output_file.write(
                "ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7)\n")
            self.output_file.write(
                "ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
            self.output_file.write("*" + v0 + " = " + vdata0 + "\n")
            self.output_file.write("*" + v1 + " = " + vdata1 + "\n")
            self.number_of_v0 += 1
            self.number_of_v1 += 1

    def flat_atomic_add(self, instruction):
        vdst = instruction[1]
        vaddr = instruction[2]
        vdata = instruction[3]
        vm = "vm" + str(self.number_of_vm)
        p = "p" + str(self.number_of_p)
        inst_offset = instruction[4]  # не очень понятно, должно ли это быть в виде INST_OFFSET:OFFSET
        self.output_file.write("uint* " + vm + " = (uint*)(" + vaddr + " + " + inst_offset + ")\n")
        self.output_file.write("uint " + p + " = *" + vm + "; *" + vm + " = *" + vm + " + " + vdata + "; "
                               + vdst + " = (glc) ? " + p + " : " + vdst + '\n')
        self.number_of_vm += 1
        self.number_of_p += 1

    def flat_load(self, node, instruction, flag_of_status, suffix):
        if suffix == "dword":
            vdst = instruction[1]
            vaddr = instruction[2]
            inst_offset = instruction[3] if len(instruction) > 3 else ""
            variable = "var" + str(self.num_of_var)
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(vdst, vaddr)
            if flag_of_status:
                if inst_offset == "":
                    if first_to == last_to:
                        # node.state.registers[to_registers] = \
                        #     Register(node.state.registers[from_registers].val,
                        #              node.state.registers[from_registers].type,
                        #              Integrity.integer)
                        node.state.registers[to_registers] = Register(variable, Type.program_param,
                                                                      Integrity.integer)
                        node.state.make_version(self.versions, to_registers)
                        node.state.registers[to_registers].type_of_data = node.state.registers[
                            from_registers].type_of_data
                        #
                        node.state.registers[to_registers].val = variable
                        self.num_of_var += 1
                        self.variables[node.state.registers[to_registers].version] = variable
                        self.names_of_vars[variable] = node.state.registers[from_registers].type_of_data
                return node
            output_string = node.state.registers[to_registers].val + " = " + node.state.registers[
                from_registers].val
            return output_string
            # self.output_file.write(vdst + " = *(uint)(" + vaddr + " + " + inst_offset + "\n")

        elif suffix == "dwordx4":
            vdst = instruction[1]
            vaddr = instruction[2]
            inst_offset = instruction[3]
            vm = "vm" + str(self.number_of_vm)
            self.output_file.write("short* " + vm + " = (" + vaddr + " + " + inst_offset + ")\n")
            self.output_file.write(vdst + "[0] = *(uint*)" + vm + "\n")
            self.output_file.write(vdst + "[1] = *(uint*)(" + vm + " + 4)\n")
            self.output_file.write(vdst + "[2] = *(uint*)(" + vm + " + 8)\n")
            self.output_file.write(vdst + "[3] = *(uint*)(" + vm + " + 12)\n")
            self.number_of_vm += 1

    def flat_store_dword(self, node, instruction, flag_of_status, suffix):
        vaddr = instruction[1]
        vdata = instruction[2]
        inst_offset = "0" if len(instruction) < 4 else instruction[3]
        first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
            = node.state.find_first_last_num_to_from(vaddr, vdata)
        if flag_of_status:
            if first_to == last_to:
                node.state.registers[to_registers] = \
                    Register(node.state.registers[vdata].val, node.state.registers[from_registers].type,
                             Integrity.integer)
                # node.state.make_version(self.versions, to_registers)
                node.state.registers[to_registers].version = node.parent[0].state.registers[to_registers].version
                node.state.registers[to_registers].type_of_data = suffix
            else:
                to_now = name_of_register + str(first_to + 1)
                if node.state.registers.get(vdata):
                    node.state.registers[to_registers] = \
                        Register(node.state.registers[vdata].val, node.state.registers[from_registers].type,
                                 Integrity.low_part)
                    # node.state.make_version(self.versions, to_registers)
                    node.state.registers[to_registers].version = \
                        node.parent[0].state.registers[to_registers].version
                    node.state.registers[to_registers].type_of_data = suffix
                    node.state.registers[to_now] = \
                        Register(node.state.registers[vdata].val, node.state.registers[from_registers].type,
                                 Integrity.high_part)
                    # node.state.make_version(self.versions, to_now)
                    if node.parent[0].state.registers[to_now] is not None:
                        node.state.registers[to_now].version = node.parent[0].state.registers[to_now].version
                    node.state.registers[to_now].type_of_data = suffix
                else:
                    return node
            return node
        if inst_offset != "0":
            output_string = "*(uint*)(" + node.parent[0].state.registers[to_registers].val \
                            + " + " + inst_offset + ") = " \
                            + node.state.registers[name_of_register + str(first_to)].val
        else:
            var = node.parent[0].state.registers[to_registers].val
            # if node.state.registers[to_registers].val.find("var") == -1 \
            # else node.state.registers[to_registers].val
            if node.state.registers.get(from_registers):
                output_string = var + " = " + node.state.registers[from_registers].val
            else:
                output_string = var + " = " + self.initial_state.registers[from_registers].val
        return output_string
        # self.output_file.write("*(uint*)(" + vaddr + " + " + inst_offset + ") = " + vdata + "\n")  # нужен ли номер...

    def flat_store_dwordx2(self, node, instruction, flag_of_status):
        vaddr = instruction[1]
        vdata = instruction[2]
        inst_offset = "0" if len(instruction) < 4 else instruction[3]
        first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
            = node.state.find_first_last_num_to_from(vaddr, vdata)
        if flag_of_status:
            to_now = name_of_register + str(first_to + 1)
            node.state.registers[to_registers] = \
                Register(node.state.registers[from_registers].val, node.state.registers[from_registers].type,
                         Integrity.low_part)
            # node.state.make_version(self.versions, to_registers)
            node.state.registers[to_registers].version = \
                node.parent[0].state.registers[to_registers].version
            node.state.registers[to_registers].type_of_data = "dwordx2"
            second_from = name_of_from + str(first_from + 1)
            node.state.registers[to_now] = \
                Register(node.state.registers[second_from].val, node.state.registers[second_from].type,
                         Integrity.high_part)
            # node.state.make_version(self.versions, to_now)
            if node.parent[0].state.registers[to_now] is not None:
                node.state.registers[to_now].version = node.parent[0].state.registers[to_now].version
            node.state.registers[to_now].type_of_data = "dwordx2"
            return node
        else:
            var = node.parent[0].state.registers[to_registers].val
            if node.state.registers.get(from_registers):
                output_string = var + " = " + node.state.registers[from_registers].val
            else:
                output_string = var + " = " + self.initial_state.registers[from_registers].val
        return output_string

    def flat_store_dwordx4(self, node, instruction, flag_of_status):
        vaddr = instruction[1]
        vdata = instruction[2]
        inst_offset = instruction[3]
        vm = "vm" + str(self.number_of_vm)
        self.output_file.write("short* " + vm + " = (" + vaddr + " + " + inst_offset + ")\n")
        self.output_file.write("*(uint*)(" + vm + ") = " + vdata + "[0]\n")
        self.output_file.write("*(uint*)(" + vm + " + 4) = " + vdata + "[1]\n")
        self.output_file.write("*(uint*)(" + vm + " + 8) = " + vdata + "[2]\n")
        self.output_file.write("*(uint*)(" + vm + " + 12) = " + vdata + "[3]\n")
        self.number_of_vm += 1

    def global_load(self, instruction, suffix):
        if suffix == "dword":
            vdst = instruction[1]
            vaddr = instruction[2]
            saddr = "0" if instruction[3] == "off" else instruction[3]
            inst_offset = "0" if len(instruction) == 4 else instruction[4]
            self.output_file.write(vdst + " = *(uint*)(" + vaddr + " + " + saddr + " + " + inst_offset + ")\n")

        elif suffix == "dwordx2":
            vdst = instruction[1]
            vaddr = instruction[2]
            saddr = "0" if instruction[3] == "off" else instruction[3]
            inst_offset = "0" if len(instruction) == 4 else instruction[4]
            self.output_file.write(vdst + " = *(ulong*)(" + vaddr + " + " + saddr + " + " + inst_offset + ")\n")

    def global_store(self, instruction, suffix):
        if suffix == "dword":
            vaddr = instruction[1]
            vdata = instruction[2]
            saddr = 0 if instruction[3] == "off" else instruction[3]
            inst_offset = 0 if len(instruction) == 4 else instruction[4]
            self.output_file.write(
                "*(uint*)(" + vaddr + " + " + saddr + " + " + inst_offset + ") = " + vdata + "\n")

        elif suffix == "dwordx2":
            vaddr = instruction[1]
            vdata = instruction[2]
            saddr = 0 if instruction[3] == "off" else instruction[3]
            inst_offset = 0 if len(instruction) == 4 else instruction[4]
            self.output_file.write(
                "*(ulong*)(" + vaddr + " + " + saddr + " + " + inst_offset + ") = " + vdata + "\n")

    def s_add(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            new_val, ssrc0_reg, ssrc1_reg = self.make_op(node, ssrc0, ssrc1, " + ")  # may be this should be (ulong)
            if flag_of_status:
                if ssrc0_reg and ssrc1_reg:
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
                    elif node.state.registers[ssrc0].type == Type.param or node.state.registers[ssrc1].type == Type.param:
                        node.state.registers[sdst] = \
                            Register(new_val, Type.param, Integrity.integer)
                    else:
                        node.state.registers[sdst] = \
                            Register(new_val, Type.unknown, Integrity.integer)
                else:
                    type_reg = Type.int32
                    if ssrc0_reg:
                        type_reg = node.state.registers[ssrc0].type
                    if ssrc1_reg:
                        type_reg = node.state.registers[ssrc1].type
                    node.state.registers[sdst] = \
                        Register(new_val, type_reg, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # temp = "temp" + str(self.number_of_temp)
            # self.output_file.write("ulong " + temp + " = " + new_val + "\n")
            # self.output_file.write(sdst + " = " + temp + "\n")
            # self.output_file.write("scc = " + temp + " >> 32\n")
            # self.number_of_temp += 1

    def s_addc(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            new_val, ssrc0_reg, ssrc1_reg = self.make_op(node, ssrc0, ssrc1, " + ")  # may be this should be (ulong)
            if flag_of_status:
                if ssrc0_reg and ssrc1_reg:
                    node.state.registers[sdst] = \
                        Register(new_val, Type.unknown, Integrity.integer)
                else:
                    type_reg = Type.int32
                    if ssrc0_reg:
                        type_reg = node.state.registers[ssrc0].type
                    if ssrc1_reg:
                        type_reg = node.state.registers[ssrc1].type
                    node.state.registers[sdst] = \
                        Register(new_val, type_reg, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # temp = " temp" + str(self.number_of_temp)
            # self.output_file.write("ulong " + temp + " = (ulong)" + ssrc0 + " + (ulong)" + ssrc1 + " scc\n")
            # self.output_file.write(sdst + " = " + temp + "\n")
            # self.output_file.write("scc = " + temp + " >> 32\n")
            # self.number_of_temp += 1

    def s_and(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'b32' or suffix == 'b64':
            if flag_of_status:
                sdst = instruction[1]
                ssrc0 = instruction[2]
                ssrc1 = instruction[3]
                node.state.registers[sdst] = node.state.registers[ssrc0]
                return node
            return output_string
            # self.output_file.write(sdst + " = " + ssrc0 + " & " + ssrc1 + "\n")
            # self.output_file.write("scc = " + sdst + " != 0\n")

    def s_and_saveexec(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            if flag_of_status:
                node.state.registers[sdst] = node.state.registers["exec"]
                node.state.registers["exec"] = node.state.registers[ssrc0]
                return node
            return output_string
            # self.output_file.write(sdst + " = " + "exec\n")
            # self.output_file.write("exec = " + ssrc0 + " & exec\n")
            # self.output_file.write("scc = exec != 0\n")

    def s_andn2(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                return node
            return output_string
            # self.output_file.write(sdst + " = " + ssrc0 + " & ~" + ssrc1 + "\n")
            # self.output_file.write("scc = " + sdst + " != 0\n")

    def s_ashr(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'i32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                new_val, ssrc0_flag, ssrc1_flag = self.make_op(node, ssrc0, str(pow(2, int(ssrc1))), " / ")
                node.state.registers[sdst] = \
                    Register(new_val, Type.unknown, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdst + " = (int)" + ssrc0 + " >> (" + ssrc1 + " & 31)\n")
            # self.output_file.write("scc = " + sdst + " != 0\n")

    def s_barrier(self, node, flag_of_status):
        if flag_of_status:
            return node
        output_string = "barrier(CLK_LOCAL_MEM_FENCE)"
        return output_string

    def s_bfe(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                if ssrc1 == "0x20010":
                    node.state.registers[sdst] = Register("get_work_dim()", Type.work_dim, Integrity.integer)
                else:
                    node.state.registers[sdst].val = "get_local_size(1)" # I think that it not all true
                node.state.make_version(self.versions, sdst)
                return node
            return output_string

        if suffix == "i32":
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                return node
            return output_string
            # shift = "shift" + str(self.number_of_shift)
            # length = "length" + str(self.number_of_length)
            # self.output_file.write("uchar " + shift + " = " + ssrc1 + " & 31\n")
            # self.output_file.write("uchar " + length + " = (" + ssrc0 + " >> 16) & 0x7f\n")
            # self.output_file.write("if (" + length + " == 0)\n")
            # self.output_file.write(tab + sdst + " = 0\n")
            # self.output_file.write("if (" + shift + " + " + length + " < 32)\n")
            # self.output_file.write(
            #     tab + sdst + " = " + ssrc0 + " << (32 - " + shift + " - " + length + ") >> (32 - "
            #     + length + "\n")
            # self.output_file.write("else\n")
            # self.output_file.write(tab + sdst + " = " + instruction[2] + " >> " + shift + "\n")
            # self.output_file.write("scc = " + ssrc0 + " != 0\n")
            # self.number_of_length += 1
            # self.number_of_shift += 1

    def s_branch(self, node, instruction):
        reladdr = instruction[1]
        if self.to_node.get(reladdr) is not None:
            node.add_child(self.to_node[reladdr])
            self.to_node[reladdr].add_parent(node)
        else:
            if self.from_node.get(reladdr) is None:
                self.from_node[reladdr] = [node]
            else:
                self.from_node[reladdr].append(node)
        node.instruction = "branch"
        return node
        # self.output_file.write("pc = " + reladdr + "\n")

    def s_cbranch_execz(self, node, instruction, flag_of_status):
        reladdr = instruction[1]
        if flag_of_status:
            if self.to_node.get(reladdr) is not None:
                node.add_child(self.to_node[reladdr])
                self.to_node[reladdr].add_parent(node)
            else:
                if self.from_node.get(reladdr) is None:
                    self.from_node[reladdr] = [node]
                else:
                    self.from_node[reladdr].append(node)
            return node
        output_string = node.state.registers["exec"].val
        return output_string
        # self.output_file.write("pc = exec == 0 ? " + reladdr + " : pc + 4\n")

    def s_cbranch_scc0(self, node, instruction, flag_of_status):
        reladdr = instruction[1]
        if flag_of_status:
            if self.to_node.get(reladdr) is not None:
                node.add_child(self.to_node[reladdr])
                self.to_node[reladdr].add_parent(node)
            else:
                if self.from_node.get(reladdr) is None:
                    self.from_node[reladdr] = [node]
                else:
                    self.from_node[reladdr].append(node)
            return node
        output_string = node.state.registers["scc"].val
        return output_string
        # self.output_file.write("pc = scc0 == 0 ? " + reladdr + " : pc + 4\n")

    def s_cbranch_scc1(self, instruction):
        reladdr = instruction[1]
        self.output_file.write("pc = scc1 == 0 ? " + reladdr + " : pc + 4\n")

    def s_cbranch_vccnz(self, instruction):
        reladdr = instruction[1]
        self.output_file.write("pc = vcc != 0 ? " + reladdr + " : pc + 4")

    def s_cmp_eq(self, instruction, suffix):
        if suffix == 'i32' or suffix == 'u32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            self.output_file.write("scc = " + ssrc0 + " == " + ssrc1 + "\n")

    def s_cmp_ge(self, instruction, suffix):
        if suffix == 'i32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            self.output_file.write("scc = (int)" + ssrc0 + " >= (int)" + ssrc1 + "\n")

        elif suffix == 'u32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            self.output_file.write("scc = " + ssrc0 + " >= " + ssrc1 + "\n")

    def s_cmp_lt(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'i32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            if flag_of_status:
                node.state.registers["scc"] = Register(
                    node.state.registers[ssrc0].val + " < " + node.state.registers[ssrc1].val,
                    Type.unknown, Integrity.integer)
                node.state.make_version(self.versions, "scc")
                if "scc" in [ssrc0, ssrc1]:
                    node.state.registers["scc"].make_prev()
                node.state.registers["scc"].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write("scc = (int)" + ssrc0 + " < (int)" + ssrc1 + "\n")

    def s_cselect(self, instruction, suffix):
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            self.output_file.write(sdst + " = scc ? " + ssrc0 + " : " + ssrc1 + "\n")

    def s_endpgm(self, node, flag_of_status, output_string):
        if flag_of_status:
            return node
        # self.output_file.write("}\n")
        return output_string

    def s_getpc(self, instruction, suffix):
        if suffix == 'b64':
            sdst = instruction[1]
            self.output_file.write(sdst + " = pc + 4\n")

    def s_load(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'dword':
            sdata = instruction[1]
            sbase = instruction[2]
            offset = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(sdata, sbase)
            if flag_of_status:
                if self.usesetup == False and sbase == "s[4:5]" \
                        or self.usesetup == True and sbase == "s[6:7]":
                    node.state.upload(sdata, sbase, offset, self.params, self.versions)
                else:
                    node.state.upload_usesetup(sdata, sbase, offset, self.params, self.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdata + " = *(uint*)(smem + (" + offset + " & ~3))\n")

        elif suffix == 'dwordx2':
            sdata = instruction[1]
            sbase = instruction[2]
            offset = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(sdata, sbase)
            if flag_of_status:
                if self.usesetup == False and sbase == "s[4:5]" \
                        or self.usesetup == True and sbase == "s[6:7]":
                    node.state.upload(sdata, sbase, offset, self.params, self.versions)
                else:
                    node.state.upload_usesetup(sdata, sbase, offset, self.params, self.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdata + " = " + node.state.registers[to_registers].val + "\n")
            # self.output_file.write(sdata + " = *(ulong*)(smem + (" + offset + " & ~3))\n")  # smem??? как и dc..

        elif suffix == 'dwordx4' or suffix == 'dwordx8':
            sdata = instruction[1]
            sbase = instruction[2]
            offset = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(sdata, sbase)
            if flag_of_status:
                if self.usesetup == False and sbase == "s[4:5]" \
                        or self.usesetup == True and sbase == "s[6:7]":
                    node.state.upload(sdata, sbase, offset, self.params, self.versions)
                else:
                    node.state.upload_usesetup(sdata, sbase, offset, self.params, self.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write("for (short i = 0; i < " + suffix[-1] + "; i++)\n")
            # self.output_file.write(tab + sdata + " = *(uint*)(smem + i * 4 + (" + offset + " & ~3))\n")

    def s_lshl(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'b32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                new_val, ssrc0_flag, ssrc1_flag = self.make_op(node, ssrc0, str(pow(2, int(ssrc1))), " * ")
                # probably we should check ssrc0_flag and ssrc1_flag. not sure
                if node.state.registers[ssrc0].type == Type.work_group_id_x:
                    node.state.registers[sdst] = Register(new_val, Type.work_group_id_x_local_size, Integrity.integer)
                    node.state.registers["scc"] = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                elif node.state.registers[ssrc0].type == Type.work_group_id_y:
                    node.state.registers[sdst] = Register(new_val, Type.work_group_id_y_local_size, Integrity.integer)
                    node.state.registers["scc"] = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                elif node.state.registers[ssrc0].type == Type.work_group_id_z:
                    node.state.registers[sdst] = Register(new_val, Type.work_group_id_z_local_size, Integrity.integer)
                    node.state.registers["scc"] = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                else:
                    node.state.registers[sdst] = Register(new_val, node.state.registers[ssrc0].type, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                node.state.registers[sdst].type_of_data = suffix
                node.state.make_version(self.versions, "scc")
                node.state.registers["scc"].type_of_data = suffix
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                return node
            return output_string
            # self.output_file.write(sdst + " = " + node.state.registers[sdst].val + "\n")
            # self.output_file.write("scc = " + sdst + " != 0\n")
            # self.output_file.write(sdst + " = " + ssrc0 + " << (" + ssrc1 + " & " + str(int(suffix[1:]) - 1) + ")\n")
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                    = node.state.find_first_last_num_to_from(sdst, ssrc0)
                from_registers1 = name_of_from + str(first_from + 1)
                to_registers1 = name_of_register + str(first_to + 1)
                new_val0, ssrc0_flag0, ssrc1_flag0 = self.make_op(node, from_registers, str(pow(2, int(ssrc1))), " * ")
                new_val1, ssrc0_flag1, ssrc1_flag1 = self.make_op(node, from_registers1, str(pow(2, int(ssrc1))), " * ")
                node.state.registers[to_registers] = \
                    Register(new_val0, node.state.registers[from_registers].type, Integrity.low_part)
                node.state.registers[to_registers1] = \
                    Register(new_val1, node.state.registers[from_registers1].type, Integrity.high_part)
                node.state.make_version(self.versions, to_registers)
                node.state.registers[to_registers].type_of_data = suffix
                if to_registers in [from_registers, ssrc1]:
                    node.state.registers[to_registers].make_prev()
                node.state.make_version(self.versions, to_registers1)
                node.state.registers[to_registers1].type_of_data = suffix
                if to_registers1 in [from_registers1, ssrc1]:
                    node.state.registers[to_registers1].make_prev()
                return node
            return output_string

    def s_lshr(self, node, instruction, flag_of_status, suffix, output_string):
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]
        if suffix == 'b32':
            if flag_of_status:
                if node.state.registers[ssrc0].type == Type.global_size_x \
                        and str(pow(2, int(ssrc1))) == self.size_of_work_groups[0]:
                    node.state.registers[sdst] = \
                        Register("get_num_groups(0)", node.state.registers[ssrc0].type, Integrity.integer)
                elif node.state.registers[ssrc0].type == Type.global_size_y \
                        and str(pow(2, int(ssrc1))) == self.size_of_work_groups[1]:
                    node.state.registers[sdst] = \
                        Register("get_num_groups(1)", node.state.registers[ssrc0].type, Integrity.integer)
                elif node.state.registers[ssrc0].type == Type.global_size_z \
                        and str(pow(2, int(ssrc1))) == self.size_of_work_groups[2]:
                    node.state.registers[sdst] = \
                        Register("get_num_groups(2)", node.state.registers[ssrc0].type, Integrity.integer)
                else:
                    new_val, ssrc0_flag, ssrc1_flag = self.make_op(node, ssrc0, str(pow(2, int(ssrc1))), " / ")
                    node.state.registers[sdst] = Register(new_val, node.state.registers[ssrc0].type, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                return node
            return output_string

    def s_mov(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'b32' or suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            if flag_of_status:
                if node.state.registers.get(ssrc0) is not None:
                    node.state.registers[sdst] = \
                        Register(node.state.registers[ssrc0].val, node.state.registers[ssrc0].type, Integrity.integer)
                else:
                    node.state.registers[sdst] = Register(ssrc0, Type.int32, Integrity.integer)
                if self.versions.get(sdst) is None:
                    self.versions[sdst] = 0
                node.state.make_version(self.versions, sdst)
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdst + " = " + ssrc0 + "\n")

    def s_movk(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'i32':
            sdst = instruction[1]
            simm16 = instruction[2]
            if flag_of_status:
                node.state.registers[sdst] = Register(simm16, Type.unknown, Integrity.integer)  #  may be here can be not  only value
                if self.versions.get(sdst) is None:
                    self.versions[sdst] = 0
                node.state.make_version(self.versions, sdst)
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdst + " = " + simm16 + "\n")

    def s_mul(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'i32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                new_val, ssrc0_reg, ssrc1_reg = self.make_op(node, ssrc0, ssrc1, " * ")
                if ssrc0_reg and ssrc1_reg:
                    if node.state.registers[ssrc0].type == Type.local_size_x \
                            and node.state.registers[ssrc1].type == Type.work_group_id_x:
                        node.state.registers[sdst] = \
                            Register(new_val, Type.work_group_id_x_local_size, Integrity.integer)
                    elif node.state.registers[ssrc0].type == Type.local_size_y \
                            and node.state.registers[ssrc1].type == Type.work_group_id_y:
                        node.state.registers[sdst] = \
                            Register(new_val, Type.work_group_id_y_local_size, Integrity.integer)
                    elif node.state.registers[ssrc0].type == Type.local_size_z \
                            and node.state.registers[ssrc1].type == Type.work_group_id_z:
                        node.state.registers[sdst] = \
                            Register(new_val, Type.work_group_id_z_local_size, Integrity.integer)
                    else:
                        node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                else:
                    node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdst + " = " + ssrc0 + " * " + ssrc1 + "\n")

    def s_mulk(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'i32':
            sdst = instruction[1]
            simm16 = instruction[2][instruction[2].find("x") + 1:]
            if flag_of_status:
                new_val, sdst_flag, simm16_flag = self.make_op(node, sdst, simm16, " * ")
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdst + " = " + sdst + " * " + simm16 + "\n")

    def s_not(self, instruction, suffix):
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            self.output_file.write(sdst + " = ~" + ssrc0 + "\n")
            self.output_file.write("scc = " + sdst + " != 0\n")

    def s_set_gpr_idx_on(self, instruction):
        ssrc0 = instruction[1]
        imm8 = instruction[2]
        self.output_file.write("mode = (mode & ~(1U << 27)) | (1U << 27)\n")
        self.output_file.write(
            "m0 = (m0 & 0xffff0f00) | ((" + imm8 + " & 15) << 12) | (" + ssrc0 + " & 0xff)\n")

    def s_set_gpr_idx_off(self):
        self.output_file.write("mode = (mode & ~(1U << 27))\n")

    def s_setpc(self, instruction, suffix):
        if suffix == 'b64':
            ssrc0 = instruction[1]
            self.output_file.write("pc = " + ssrc0 + "\n")

    def s_setreg(self, instruction, suffix):
        if suffix == 'b32':
            hwreg = instruction[1]
            hwregname = instruction[2]
            bitoffset = instruction[3]
            bitsize = instruction[4]
            sdst = instruction[5]
            mask = "mask" + str(self.number_of_mask)
            self.output_file.write("uint " + mask + " = (1U << " + bitsize + ") - 1U) << " + bitoffset + "\n")
            self.output_file.write(
                hwreg + " = (" + hwreg + "& ~" + mask + ") | ((" + sdst + " << " + bitoffset + ") & " + mask
                + ")\n")
            self.number_of_mask += 1

    def s_sub(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'i32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            temp = "temp" + str(self.number_of_temp)
            self.output_file.write(sdst + " = " + ssrc0 + " - " + ssrc1 + "\n")
            self.output_file.write(
                "long " + temp + " = (long)" + ssrc0 + " - (long)" + ssrc1 + "\n")  # SEXT64 - long?
            self.output_file.write("scc = " + temp + " > ((1LL << 31) - 1) || " + temp + " < (-1LL << 31)\n")
            self.number_of_temp += 1

        elif suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                new_val, src0_reg, src1_reg = self.make_op(node, ssrc0, ssrc1, " - ")
                new_integrity = node.state.registers[ssrc1].integrity
                node.state.registers[sdst] = Register(new_val, Type.unknown, new_integrity)
                node.state.make_version(self.versions, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # may be should add "ulong"

    def s_subb(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            temp = "temp" + str(self.number_of_temp)
            self.output_file.write("ulong " + temp + " = (ulong)" + ssrc0 + " - (ulong)" + ssrc1 + " - scc\n")
            self.output_file.write(sdst + " = " + temp + "\n")
            self.output_file.write("scc = (" + temp + " >> 32) & 1\n")
            self.number_of_temp += 1

    def s_swappc(self, instruction, suffix):
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            self.output_file.write(sdst + " = pc + 4\n")
            self.output_file.write("pc = " + ssrc0 + "\n")

    def s_waitcnt(self, node, flag_of_status, output_string):
        if flag_of_status:
            return node
        return output_string

    def v_add(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "u32":
            vdst = instruction[1]
            sdst = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            new_val, src0_reg, src1_reg = self.make_op(node, src0, src1, " + ")  # may be this should be ulong
            if flag_of_status:
                if src0_reg and src1_reg:
                    if node.state.registers[src0].type == Type.work_group_id_x_local_size_offset and \
                            node.state.registers[src1].type == Type.work_item_id_x or \
                            node.state.registers[src0].type == Type.global_offset_x and \
                            node.state.registers[src1].type == Type.work_group_id_x_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(0)", Type.global_id_x, new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_y_local_size_offset and \
                            node.state.registers[src1].type == Type.work_item_id_y or \
                            node.state.registers[src0].type == Type.global_offset_y and \
                            node.state.registers[src1].type == Type.work_group_id_y_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(1)", Type.global_id_y, new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_z_local_size_offset and \
                            node.state.registers[src1].type == Type.work_item_id_z or \
                            node.state.registers[src0].type == Type.global_offset_z and \
                            node.state.registers[src1].type == Type.work_group_id_z_work_item_id or \
                            node.state.registers[src1].type == Type.global_offset_z and \
                            node.state.registers[src0].type == Type.work_group_id_z_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(2)", Type.global_id_z, new_integrity)
                    elif node.state.registers[src0].type == Type.paramA:
                        new_integrity = node.state.registers[src1].integrity
                        if self.type_params.get("*" + node.state.registers[src0].val) == "int" \
                                or self.type_params.get("*" + node.state.registers[src0].val) == "uint":
                            new_value, src0_flaf, src1_flag = self.make_op(node, src1, "4", " / ")
                            new_val = node.state.registers[src0].val + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, Type.param_global_id_x, new_integrity)
                        elif self.type_params.get("*" + node.state.registers[src0].val) == "long" \
                                or self.type_params.get("*" + node.state.registers[src0].val) == "ulong":
                            new_value, src0_flaf, src1_flag = self.make_op(node, src1, "8", " / ")
                            new_val = node.state.registers[src0].val + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, Type.param_global_id_x, new_integrity)
                        elif self.type_params.get("*" + node.state.registers[src0].val) == "char" \
                                or self.type_params.get("*" + node.state.registers[src0].val) == "uchar":
                            # new_value, src0_flaf, src1_flag = self.make_op(node, src1, "8", " / ")
                            new_val = node.state.registers[src0].val + "[" + node.state.registers[src1].val + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, Type.param_global_id_x, new_integrity)
                        #  make something same fo another types

                    elif node.state.registers[src0].type == Type.work_group_id_x_local_size and \
                            node.state.registers[src1].type == Type.work_item_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(0) - get_global_offset(0)", Type.work_group_id_x_work_item_id,
                                     new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_y_local_size and \
                            node.state.registers[src1].type == Type.work_item_id_y:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(1) - get_global_offset(1)", Type.work_group_id_y_work_item_id,
                                     new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_z_local_size and \
                            node.state.registers[src1].type == Type.work_item_id_z:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(2) - get_global_offset(2)", Type.work_group_id_z_work_item_id,
                                     new_integrity)
                    # elif node.state.registers[src0].type == Type.global_id_y and node.state.registers[src1].type == Type.global_id_z\
                    #         or node.state.registers[src0].type == Type.global_id_z and node.state.registers[src1].type == Type.global_id_y:
                    #     new_integrity = node.state.registers[src1].integrity
                    #     node.state.registers[vdst] = \
                    #         Register(node.state.registers[src0].val + " + " + node.state.registers[src1].val,
                    #                  Type.unknown, new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_x_local_size and \
                            node.state.registers[src1].type == Type.work_item_id_x or \
                            node.state.registers[src1].type == Type.work_group_id_x_local_size and \
                            node.state.registers[src0].type == Type.work_item_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(0) - get_global_offset(0)", Type.unknown, new_integrity)
                    # elif node.state.registers[src0]. type == Type.param or node.state.registers[src1]. type == Type.param:
                    else:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                else:
                    type_reg = Type.int32
                    if src0_reg:
                        type_reg = node.state.registers[src0].type
                    if src1_reg:
                        type_reg = node.state.registers[src1].type
                    node.state.registers[vdst] = Register(new_val, type_reg, Integrity.integer)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                # elif node.state.registers[src0].type == Type.param and node.state.registers[src1].type
                # не хватает описания sdst
                return node
            return output_string
            # if node.state.registers[vdst].integrity == Integrity.integer:
            #     new_val = node.state.registers[vdst].val
            #     temp = "temp" + str(self.number_of_temp)
            #     mask = "mask" + str(self.number_of_mask)
            #     self.output_file.write("ulong " + temp + " = " + new_val + "\n")
            #     self.output_file.write(vdst + " = clamp ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
            #     self.output_file.write(sdst + " = 0\n")
            #     self.output_file.write("ulong " + mask + " = (1ULL << laneid)\n")
            #     self.output_file.write(sdst + " = (" + sdst + " & ~" + mask + ") | ((" + temp + " >> 32) ? " + mask + " : 0\n")
            #     self.number_of_temp += 1
            #     self.number_of_mask += 1

    def v_addc(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "u32":
            vdst = instruction[1]
            sdst = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            ssrc2 = instruction[5]
            new_val, src0_reg, src1_reg = self.make_op(node, src0, src1, " + ")  # may be this should be ulong
            if flag_of_status:
                if src0_reg and src1_reg:
                    if node.state.registers[src0].type == Type.paramA \
                            and node.state.registers[src1].type == Type.global_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register(node.state.registers[src0].val + "[get_global_id(0)]",
                                                              Type.param_global_id_x, new_integrity)
                        # think about another case with paramA, it should be like v_add?
                    else:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                else:
                    type_reg = Type.int32
                    if src0_reg:
                        type_reg = node.state.registers[src0].type
                    if src1_reg:
                        type_reg = node.state.registers[src1].type
                    node.state.registers[vdst] = Register(new_val, type_reg, Integrity.integer)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
            # if node.state.registers[vdst].integrity == Integrity.integer:
            #     new_val = node.state.registers[vdst].val
            #     temp = "temp" + str(self.number_of_temp)
            #     mask = "mask" + str(self.number_of_mask)
            #     cc = "cc" + str(self.number_of_cc)
            #     self.output_file.write("ulong " + mask + " = (1ULL << laneid)\n")
            #     self.output_file.write("uchar " + cc + " = ((" + ssrc2 + " & " + mask + ") ? 1 : 0)\n")
            #     self.output_file.write("ulong " + temp + " = " + new_val + " + " + cc + "\n")
            #     self.output_file.write(sdst + " = 0\n")
            #     self.output_file.write(vdst + " = clamp ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
            #     self.output_file.write(sdst + " = (" + sdst + " & ~" + mask + ") | ((" + temp + " >> 32) ? " + mask + " : 0)\n")
            #     self.number_of_temp += 1
            #     self.number_of_mask += 1
            #     self.number_of_mask += 1

    def v_alignbit(self, instruction, suffix):
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            self.output_file.write(
                vdst + " = (((ulong)" + src0 + ") << 32) | " + src1 + ") >> (" + src2 + " & 31)\n")

    def v_alignbyte(self, instruction, suffix):
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            self.output_file.write(
                vdst + " = (((ulong)" + src0 + ") << 32) | " + src1 + ") >> ((" + src2 + " & 3) * 8)\n")

    def v_and(self, node, instruction, flag_of_status, suffix, output_string):  # fixed by examples, not sure
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                new_integrity = node.state.registers[src1].integrity
                new_val, src0_flag, src1_flag = self.make_op(node, src1, src0[1:], " * ")
                # check is this expression correctly, may be add to make_op
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(vdst + " = " + src0 + " & " + src1 + "\n")

    def v_and_or(self, instruction, suffix):
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            self.output_file.write(vdst + " = (" + src0 + " & " + src1 + ") | " + src2 + "\n")

    def v_ashrrev(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "i32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                node.state.registers[vdst] = \
                    Register(node.state.registers[src1].val, node.state.registers[src1].type, Integrity.integer)
                node.state.registers[vdst].version = node.parent[0].state.registers[vdst].version
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

        elif suffix == "i64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(vdst, src1)
            if flag_of_status:
                if node.state.registers[from_registers].val == "0":
                    node.state.registers[from_registers].val = \
                        node.state.registers[name_of_from + str(first_from + 1)].val
                node.state.registers[to_registers] = \
                    Register(node.state.registers[from_registers].val,
                             node.state.registers[from_registers].type,
                             Integrity.low_part)
                node.state.registers[to_registers].version = \
                    node.parent[0].state.registers[to_registers].version
                node.state.registers[to_registers].type_of_data = suffix
                to_registers_1 = name_of_register + str(last_to)
                node.state.registers[to_registers_1] = \
                    Register(node.state.registers[from_registers].val,
                             node.state.registers[from_registers].type,
                             Integrity.high_part)
                node.state.registers[to_registers_1].version = \
                    node.parent[0].state.registers[to_registers_1].version
                node.state.registers[to_registers_1].type_of_data = suffix
                return node
            return output_string

    def v_bfi(self, instruction, suffix):
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            self.output_file.write(vdst + " = (" + src0 + " & " + src1 + ") | (~" + src0 + " & " + src2 + ")\n")

    def v_cmp_eq(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "u32" or suffix == "i32":
            sdst = instruction[1]
            src0 = instruction[2] #  if instruction[2][0] != "v" else node.state.registers[instruction[2]].val
            src1 = instruction[3] #  if instruction[3][0] != "v" else node.state.registers[instruction[3]].val
            # I think that it not necessary now, check tests
            if flag_of_status:
                new_val, src0_flag, src1_flag = self.make_op(node, src0, src1, " == ")
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdst + " = (uint)" + src0 + " == (uint)" + src1 + "\n")

    def v_cmp_ge(self, instruction, suffix):
        if suffix == "u32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(sdst + " = (uint)" + src0 + " >= (uint)" + src1 + "\n")

    def v_cmp_gt(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "u64":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(sdst + " = (ulong)" + src0 + " > (uint)" + src1 + "\n")

        elif suffix == "i32":
            sdst = instruction[1]
            src0 = instruction[2] #  if instruction[2][0] != "v" and instruction[2][0] != "s" else node.state.registers[instruction[2]].val
            src1 = instruction[3] #  if instruction[3][0] != "v" and instruction[2][0] != "s" else node.state.registers[instruction[3]].val
            # I think that it not necessary now, check tests
            if flag_of_status:
                new_val, src0_flag, src1_flag = self.make_op(node, src0, src1, " > ")
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                node.state.make_version(self.versions, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string

    def v_cmp_lg(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "i32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                new_val, src0_flag, src1_flag = self.make_op(node, src0, src1, " != ")
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                if self.versions.get(sdst) is None:
                    self.versions[sdst] = 0
                node.state.make_version(self.versions, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(sdst + " = (int)" + src0 + " != (int)" + src1 + "\n")

        elif suffix == "u32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(sdst + " = (uint)" + src0 + " != (uint)" + src1 + "\n")

    def v_cmp_lt(self, instruction, suffix):
        if suffix == "u32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(sdst + " = (uint)" + src0 + " < (uint)" + src1 + "\n")

    def v_cmpx_class(self, suffix):
        if suffix == "f64":
            self.output_file.write("Not resolve yet. Maybe you lose.\n")

    def v_cmpx_eq(self, instruction, suffix):
        if suffix == "f64":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(sdst + " = as_double(" + src0 + ") == as_double(" + src1 + ")\n")
            self.output_file.write("exec = " + sdst + "\n")

    def v_cmpx_le(self, instruction, suffix):
        if suffix == "u32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(sdst + " = (uint)" + src0 + " <= (uint)" + src1 + "\n")
            self.output_file.write("exec = " + " = " + sdst + "\n")

    def v_cndmask(self, node, instruction, flag_of_status, suffix):
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            ssrc2 = instruction[4]
            variable = "var" + str(self.num_of_var)
            if flag_of_status:
                node.state.registers[vdst] = Register(variable, Type.program_param, Integrity.integer)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_date = suffix

                if node.state.registers[vdst].type == Type.param_global_id_x:
                    variable = "*" + variable
                node.state.registers[vdst].val = variable
                self.num_of_var += 1
                self.variables[node.state.registers[vdst].version] = variable
                self.names_of_vars[variable] = suffix
                return node
            output_string = node.state.registers[vdst].val + " = " + node.state.registers[ssrc2].val \
                            + " ? " + node.state.registers[src1].val + " : " \
                            + node.parent[0].state.registers[src0].val
            return output_string
            # self.output_file.write(vdst + " = " + ssrc2 + " & (1ULL << laneid) ? " + src1 + " : " + src0 + "\n")

    def v_cvt(self, instruction, suffix):
        tab = "    "
        if suffix == "f32_u32":
            vdst = instruction[1]
            src0 = instruction[2]
            self.output_file.write(vdst + " = (float)" + src0 + "\n")

        elif suffix == "f64_i32":
            vdst = instruction[1]
            src0 = instruction[2]
            self.output_file.write(vdst + " = (double)(int)" + src0 + "\n")

        elif suffix == "u32_f32":
            vdst = instruction[1]
            src0 = instruction[2]
            self.output_file.write(instruction[1] + " = 0\n")
            self.output_file.write("if (!isnan(as_float(" + src0 + ")))\n")
            self.output_file.write(
                tab + vdst + " = (int)min(convert_int_rtz(as_float(" + src0 + ")), 4294967295.0)\n")

    def v_div_fixup(self, instruction, suffix):
        tab = "    "
        if suffix == "f64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            sf0 = "sf0" + str(self.number_of_sf0)
            sf1 = "sf1" + str(self.number_of_sf1)
            sf2 = "sf2" + str(self.number_of_sf2)
            self.output_file.write("double " + sf0 + " = as_double(" + src0 + ")\n")
            self.output_file.write("double " + sf1 + " = as_double(" + src1 + ")\n")
            self.output_file.write("double " + sf2 + " = as_double(" + src2 + ")\n")
            self.output_file.write("if (isnan(" + sf1 + ") && !isnan(" + sf2 + "))\n")
            self.output_file.write(tab + vdst + " = nan(" + sf1 + ")\n")
            self.output_file.write("else if (abs(" + sf2 + "))\n")
            self.output_file.write(
                tab + vdst + " = nan(" + sf2 + ")\n")  # nan не может принимать что-то нецелое
            self.output_file.write("else if (" + sf1 + " == 0.0 && " + sf2 + " == 0.0)\n")
            self.output_file.write(tab + vdst + " = NAN\n")
            self.output_file.write("else if (abs(" + sf1 + ") == INFINITY)\n")
            self.output_file.write(tab + vdst + " = -NAN\n")
            self.output_file.write("else if (" + sf1 + " == 0.0)\n")
            self.output_file.write(tab + vdst + " = INFINITY * sign(" + sf1 + ") * sign(" + sf2 + ")\n")
            self.output_file.write("else if (abs(" + sf1 + ") == INFINITY)\n")
            self.output_file.write(tab + vdst + " = sign(" + sf1 + ") * sign(" + sf2 + ") >= 0 ? 0.0 : -0.0\n")
            self.output_file.write("else if (isnan(" + sf0 + "))\n")
            self.output_file.write(tab + vdst + " = sign(" + sf1 + ") * sign(" + sf2 + ") * INFINITY\n")
            self.output_file.write("else\n")
            self.output_file.write(tab + vdst + " = " + sf0 + "\n")

    def v_fma(self, instruction, suffix):
        if suffix == "f64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            self.output_file.write(
                vdst + " = " + "as_double(" + src0 + ") * as_double(" + src1 + ") + as_double(" + src2 + ")\n")

    def v_lshlrev(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                new_val, src0_flag, src1_flag = self.make_op(node, src1, str(pow(2, int(src0))), " * ")
                node.state.registers[vdst] = Register(new_val, node.state.registers[src1].type, Integrity.integer)
                node.state.registers[vdst].version = node.parent[0].state.registers[src1].version
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(vdst + " = " + src1 + " << (" + src0 + " & 31)\n")

        elif suffix == "b64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(vdst, src1)
            if flag_of_status:
                to_registers_1 = name_of_register + str(last_to)
                from_registers_1 = name_of_from + str(first_from + 1)
                new_val, src1_flag, src0_flag = self.make_op(node, from_registers, str(pow(2, int(src0))), " * ")
                if src0_flag and src1_flag:
                    if node.state.registers[from_registers].type \
                            in [Type.global_id_x, Type.global_id_y, Type.global_id_z] \
                            and node.state.registers[name_of_register + str(first_from + 1)].val == "0":
                        node.state.registers[to_registers] = \
                            Register(new_val, node.state.registers[from_registers].type, Integrity.low_part)
                        if node.parent[0].state.registers.get(to_registers) is not None:
                            node.state.registers[to_registers].version = \
                                node.parent[0].state.registers[to_registers].version
                        else:
                            node.state.make_version(self.versions, to_registers)
                        node.state.registers[to_registers].type_of_data = suffix
                        # node.state.make_version(self.versions, to_registers)
                        # if to_registers == from_registers:
                        #     node.state.registers[to_registers].make_prev()
                        node.state.registers[to_registers_1] = \
                            Register(node.state.registers[from_registers_1].val,
                                     node.state.registers[from_registers].type,
                                     Integrity.high_part)
                        if node.parent[0].state.registers.get(to_registers_1) is not None:
                            node.state.registers[to_registers_1].version = \
                                node.parent[0].state.registers[to_registers_1].version
                        else:
                            node.state.make_version(self.versions, to_registers_1)
                        node.state.registers[to_registers_1].type_of_data = suffix
                        # node.state.make_version(self.versions, to_registers_1)
                        # if to_registers_1 == from_registers_1:
                        #     node.state.registers[to_registers_1].make_prev()
                    else:
                        node.state.registers[to_registers] = node.state.registers[from_registers]
                        node.state.make_version(self.versions, to_registers)
                        node.state.registers[to_registers_1] = node.state.registers[from_registers_1]
                        node.state.make_version(self.versions, to_registers_1)
                    # нет описания под y и z
                else: #  should check
                    type_reg = Type.int32
                    if src0_flag:
                        type_reg = node.state.registers[src0].type
                    if src1_flag:
                        type_reg = node.state.registers[from_registers].type
                    node.state.registers[to_registers] = Register(new_val, type_reg, Integrity.low_part)
                    node.state.make_version(self.versions, to_registers)
                    node.state.registers[to_registers_1] = Register(new_val, type_reg, Integrity.high_part)
                    node.state.make_version(self.versions, to_registers_1)
                return node
            return output_string
            # self.output_file.write(vdst + " = " + node.state.registers[to_registers].val + " + " + node.state.registers[name_of_register + str(last_to)].val + "\n") #понять, что хочу выводить
            # self.output_file.write(vdst + " = " + src1 + " << (" + src0 + " & 63)\n")

    def v_lshrrev(self, instruction, suffix):
        if suffix == "b64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(vdst + " = " + src1 + " >> (" + src0 + " & 63)\n")

    def v_min(self, instruction, suffix):
        if suffix == "u32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(vdst + " = min(" + src0 + ", " + src1 + ")\n")

    def v_mul(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "f32" or suffix == "i32_i24":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                new_integrity = node.state.registers[src1].integrity
                new_val, src0_reg, src1_reg = self.make_op(node, src0, src1, " * ")
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

        elif suffix == "f64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            self.output_file.write(vdst + " = as_double(" + src0 + ") * as_double(" + src1 + ")\n")

    def v_mul_lo(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "u32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                new_integrity = node.state.registers[src1].integrity
                new_val, src0_reg, src1_reg = self.make_op(node, src0, src1, " * ")
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

    def v_mov(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            if flag_of_status:
                if node.state.registers.get(src0) is not None:
                    node.state.registers[vdst] = \
                        Register(node.state.registers[src0].val, node.state.registers[src0].type,
                                 Integrity.integer)
                else:
                    node.state.registers[vdst] = Register(src0, Type.int32, Integrity.integer)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
            # self.output_file.write(vdst + " = " + node.state.registers[vdst].val + "\n")
            # self.output_file.write(vdst + " = " + src0 + "\n")

    def v_sub(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "u32":
            vdst = instruction[1]
            vcc = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            if flag_of_status:
                new_val, src0_reg, src1_reg = self.make_op(node, src0, src1, " - ")
                type_reg = Type.int32
                if src0_reg:
                    type_reg = node.state.registers[src0].integrity
                elif src1_reg:
                    type_reg = node.state.registers[src1].integrity
                node.state.registers[vdst] = Register(new_val, Type.unknown, type_reg)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

    def v_subrev(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "u32":
            vdst = instruction[1]
            vcc = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            if flag_of_status:
                new_val, src0_reg, src1_reg = self.make_op(node, src1, src0, " - ")
                new_integrity = node.state.registers[src1].integrity
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                node.state.make_version(self.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

    def to_openCL(self, node, flag_of_status):
        tab = "    "
        output_string = ""
        if node.instruction[0][0] == ".":
            if flag_of_status:
                self.to_node[node.instruction[0][:-1]] = node
                if self.from_node.get(node.instruction[0][:-1]) is not None:
                    for wait_node in self.from_node[node.instruction[0][:-1]]:
                        if node not in wait_node.children:
                            wait_node.add_child(node)
                            node.add_parent(wait_node)
                            node.state = copy.deepcopy(node.parent[-1].state)
                return node
            return output_string
        if node.instruction == "branch":
            return output_string
        instruction = node.instruction
        # instruction = node.instruction.strip().replace(',', ' ').split()
        operation = instruction[0]
        parts_of_operation = operation.split('_')
        prefix = parts_of_operation[0]
        suffix = ""
        root = parts_of_operation[1]
        if len(parts_of_operation) >= 3:
            for part in parts_of_operation[2:]:
                if part in ["b32", 'b64', "u32", "u64", "i32", "i64", "dwordx4", "dwordx2", "dword", "f32",
                            "f64", "i32", "i24", "byte"]:  # дописать!
                    if suffix != "":
                        suffix = suffix + "_" + part
                    else:
                        suffix = part
                else:
                    root = root + "_" + part
        if prefix == "ds":
            if root == "add":
                return self.ds_add(node, instruction, flag_of_status, suffix)

            elif root == "bpermute":
                return self.ds_bpermute(suffix, instruction)

            elif root == "read":
                return self.ds_read(node, instruction, flag_of_status, suffix, output_string)

            elif root == "read2":
                return self.ds_read2(instruction, suffix)

            elif root == "write":
                return self.ds_write(node, instruction, flag_of_status, suffix)

            elif root == "write2":
                return self.ds_write2(instruction, suffix)

        elif prefix == "flat":  # не очень понятное описание, особенно про inst_offset
            if root == "atomic_add":
                return self.flat_atomic_add(instruction)

            elif root == "load":
                return self.flat_load(node, instruction, flag_of_status, suffix)

            elif root == "store":
                if suffix == "dword" or suffix == "byte":
                    return self.flat_store_dword(node, instruction, flag_of_status, suffix)
                elif suffix == "dwordx2":
                    return self.flat_store_dwordx2(node, instruction, flag_of_status)
                elif suffix == "dwordx4":
                    return self.flat_store_dwordx4(node, instruction, flag_of_status)

        elif prefix == 'global':  # offset - опциональная часть?
            if root == "load":
                return self.global_load(instruction, suffix)

            elif root == "store":
                return self.global_store(instruction, suffix)

        elif prefix == 's':
            if root == 'add':
                return self.s_add(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'addc':
                return self.s_addc(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'and':
                return self.s_and(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'and_saveexec':
                return self.s_and_saveexec(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'andn2':
                return self.s_andn2(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'ashr':
                return self.s_ashr(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'barrier':
                return self.s_barrier(node, flag_of_status)

            elif root == 'bfe':
                return self.s_bfe(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'branch':
                return self.s_branch(node, instruction)

            elif root == 'cbranch_execz':
                return self.s_cbranch_execz(node, instruction, flag_of_status)

            elif root == 'cbranch_scc0':
                return self.s_cbranch_scc0(node, instruction, flag_of_status)

            elif root == 'cbranch_scc1':
                return self.s_cbranch_scc1(instruction)

            elif root == 'cbranch_vccnz':
                return self.s_cbranch_vccnz(instruction)

            elif root == 'cmp_eq':
                return self.s_cmp_eq(instruction, suffix)

            elif root == 'cmp_ge':
                return self.s_cmp_ge(instruction, suffix)

            elif root == 'cmp_lt':
                return self.s_cmp_lt(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'cselect':
                return self.s_cselect(instruction, suffix)

            elif root == 'endpgm':
                return self.s_endpgm(node, flag_of_status, output_string)

            elif root == 'getpc':
                return self.s_getpc(instruction, suffix)

            elif root == 'load':
                return self.s_load(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'lshl':
                return self.s_lshl(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'lshr':
                return self.s_lshr(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'mov':
                return self.s_mov(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'movk':
                return self.s_movk(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'mul':
                return self.s_mul(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'mulk':
                return self.s_mulk(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'not':
                return self.s_not(instruction, suffix)

            elif root == 'set_gpr_idx_on':
                return self.s_set_gpr_idx_on(instruction)

            elif root == 'set_gpr_idx_off':
                return self.s_set_gpr_idx_off()

            elif root == 'setpc':
                return self.s_setpc(instruction, suffix)

            elif root == 'setreg':  # возможно это неправда
                return self.s_setreg(instruction, suffix)

            elif root == 'sub':
                return self.s_sub(node, instruction, flag_of_status, suffix, output_string)

            elif root == 'subb':
                return self.s_sub(node, instruction, flag_of_status, suffix, output_string)  # probably it's not correct

            elif root == 'swappc':
                return self.s_swappc(instruction, suffix)

            elif root == 'waitcnt':
                return self.s_waitcnt(node, flag_of_status, output_string)

        elif prefix == 'v':
            # if root == "add_co":
            #     if suffix == "u32":
            # не 1.2
            if root == "add":
                return self.v_add(node, instruction, flag_of_status, suffix, output_string)

            # elif root == "add3":
            #     if suffix == "u32":
            #
            # elif root == "addc_co":
            #     if suffix == "u32":
            # не 1.2

            elif root == "addc":
                return self.v_addc(node, instruction, flag_of_status, suffix, output_string)

            elif root == "alignbit":
                return self.v_alignbit(instruction, suffix)

            elif root == "alignbyte":
                return self.v_alignbyte(instruction, suffix)

            elif root == "and":
                return self.v_and(node, instruction, flag_of_status, suffix, output_string)

            elif root == "and_or":
                return self.v_and_or(instruction, suffix)

            elif root == "ashrrev":
                return self.v_ashrrev(node, instruction, flag_of_status, suffix, output_string)

            elif root == "bfi":
                return self.v_bfi(instruction, suffix)

            elif root == "cmp_eq":
                return self.v_cmp_eq(node, instruction, flag_of_status, suffix, output_string)

            elif root == "cmp_ge":
                return self.v_cmp_ge(instruction, suffix)

            elif root == "cmp_gt":
                return self.v_cmp_gt(node, instruction, flag_of_status, suffix, output_string)

            elif root == "cmp_lg":
                return self.v_cmp_lg(node, instruction, flag_of_status, suffix, output_string)

            elif root == "cmp_lt":
                return self.v_cmp_lt(instruction, suffix)

            elif root == "cmpx_class":  # постоянно пишут про sdst(lane) зачем...
                return self.v_cmpx_class(suffix)

            elif root == "cmpx_eq":
                return self.v_cmpx_eq(instruction, suffix)

            elif root == "cmpx_le":
                return self.v_cmpx_le(instruction, suffix)

            elif root == "cndmask":
                return self.v_cndmask(node, instruction, flag_of_status, suffix)

            elif root == "cvt":
                return self.v_cvt(instruction, suffix)

            elif root == "div_fixup":
                return self.v_div_fixup(instruction, suffix)

            elif root == "fma":
                return self.v_fma(instruction, suffix)

            elif root == "lshlrev":
                return self.v_lshlrev(node, instruction, flag_of_status, suffix, output_string)

            elif root == "lshrrev":
                return self.v_lshrrev(instruction, suffix)

            elif root == "min":
                return self.v_min(instruction, suffix)

            elif root == "mul":
                return self.v_mul(node, instruction, flag_of_status, suffix, output_string)

            elif root == "mul_hi":
                return self.v_mul_lo(node, instruction, flag_of_status, suffix, output_string)  # I'm not sure

            elif root == "mul_lo":
                return self.v_mul_lo(node, instruction, flag_of_status, suffix, output_string)

            elif root == "mov":
                return self.v_mov(node, instruction, flag_of_status, suffix, output_string)

            elif root == "sub":
                return self.v_sub(node, instruction, flag_of_status, suffix, output_string)

            elif root == "subb":
                return self.v_sub(node, instruction, flag_of_status, suffix, output_string)  # probably it's not correct

            elif root == "subrev":
                return self.v_subrev(node, instruction, flag_of_status, suffix, output_string)

        else:
            self.output_file.write("Not resolve yet. Maybe you lose.\n")
    # нет таких инструкций
