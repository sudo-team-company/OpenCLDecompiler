import copy
from collections import deque
from integrity import Integrity
from node import Node
from region import Region
from register import Register
from type_of_node import TypeNode
from type_of_reg import Type
from decompiler_data import DecompilerData
from instruction_dict import instruction_dict


class Decompiler:
    def __init__(self, output_file):
        self.decompiler_data = DecompilerData.Instance()
        self.decompiler_data.reset(output_file)

    def process_config(self, set_of_config, name_of_program):
        dimensions = set_of_config[0][6:]
        g_id = ["s6", "s7", "s8"]
        if ".usesetup" in set_of_config:
            g_id = ["s8", "s9", "s10"]
            self.decompiler_data.usesetup = True
        if len(dimensions) > 0:
            self.decompiler_data.initial_state.registers[g_id[0]] = Register("get_group_id(0)", Type.work_group_id_x, Integrity.integer)
            self.decompiler_data.initial_state.registers[g_id[0]].add_version(g_id[0], self.decompiler_data.versions[g_id[0]])
            self.decompiler_data.versions[g_id[0]] += 1
            self.decompiler_data.initial_state.registers["v0"] = Register("get_local_id(0)", Type.work_item_id_x, Integrity.integer)
            self.decompiler_data.initial_state.registers["v0"].add_version("v0", self.decompiler_data.versions["v0"])
            self.decompiler_data.versions["v0"] += 1
        if len(dimensions) > 1:
            self.decompiler_data.initial_state.registers[g_id[1]] = Register("get_group_id(1)", Type.work_group_id_y, Integrity.integer)
            self.decompiler_data.initial_state.registers[g_id[1]].add_version(g_id[1], self.decompiler_data.versions[g_id[1]])
            self.decompiler_data.versions[g_id[1]] += 1
            self.decompiler_data.initial_state.registers["v1"] = Register("get_local_id(1)", Type.work_item_id_y, Integrity.integer)
            self.decompiler_data.initial_state.registers["v1"].add_version("v1", self.decompiler_data.versions["v1"])
            self.decompiler_data.versions["v1"] += 1
        if len(dimensions) > 2:
            self.decompiler_data.initial_state.registers[g_id[2]] = Register("get_group_id(2)", Type.work_group_id_z, Integrity.integer)
            self.decompiler_data.initial_state.registers[g_id[2]].add_version(g_id[2], self.decompiler_data.versions[g_id[2]])
            self.decompiler_data.versions[g_id[2]] += 1
            self.decompiler_data.initial_state.registers["v2"] = Register("get_local_id(2)", Type.work_item_id_z, Integrity.integer)
            self.decompiler_data.initial_state.registers["v2"].add_version("v2", self.decompiler_data.versions["v2"])
            self.decompiler_data.versions["v2"] += 1
        if set_of_config[1].find(".cws") != "-1":
            self.decompiler_data.size_of_work_groups = set_of_config[1].replace(',', ' ').split()[1:]
            self.decompiler_data.output_file.write("__kernel __attribute__((reqd_work_group_size(" + self.decompiler_data.size_of_work_groups[0] + ", "
                                   + self.decompiler_data.size_of_work_groups[1] + ", " + self.decompiler_data.size_of_work_groups[2] + ")))\n")
        else:
            self.decompiler_data.output_file.write("__kernel ")
        self.decompiler_data.sgprsnum = int(set_of_config[2][10:])
        self.decompiler_data.vgprsnum = int(set_of_config[3][10:])
        if not self.decompiler_data.usesetup:
            self.decompiler_data.initial_state.registers["s4"] = Register("s4", Type.arguments_pointer, Integrity.low_part)
            self.decompiler_data.initial_state.registers["s4"].add_version("s4", self.decompiler_data.versions["s4"])
            self.decompiler_data.versions["s4"] += 1
            self.decompiler_data.initial_state.registers["s5"] = Register("s5", Type.arguments_pointer, Integrity.high_part)
            self.decompiler_data.initial_state.registers["s5"].add_version("s5", self.decompiler_data.versions["s5"])
            self.decompiler_data.versions["s5"] += 1
        else:
            self.decompiler_data.initial_state.registers["s6"] = Register("s6", Type.arguments_pointer, Integrity.low_part)
            self.decompiler_data.initial_state.registers["s6"].add_version("s6", self.decompiler_data.versions["s6"])
            self.decompiler_data.versions["s6"] += 1
            self.decompiler_data.initial_state.registers["s7"] = Register("s7", Type.arguments_pointer, Integrity.high_part)
            self.decompiler_data.initial_state.registers["s7"].add_version("s7", self.decompiler_data.versions["s7"])
            self.decompiler_data.versions["s7"] += 1
        parameters = set_of_config[17:]
        if set_of_config[4].find("localsize") != -1:
            self.decompiler_data.localsize = int(set_of_config[4][11:])
        for num_of_setting in list(range(0, len(set_of_config))):
            if set_of_config[num_of_setting].find(".arg") != -1 and set_of_config[num_of_setting].find("_.") == -1:
                parameters = set_of_config[num_of_setting:]
                break
        self.decompiler_data.output_file.write("void " + name_of_program + "(")
        num_of_param = 0
        flag_start = False
        for param in parameters:
            if not flag_start:
                flag_start = True
            else:
                self.decompiler_data.output_file.write(", ")
            set_of_param = param.strip().replace(',', ' ').split()
            name_param = set_of_param[1]
            type_param = set_of_param[3]
            flag_param = ""
            if len(set_of_param) > 4:
                flag_param = "__" + set_of_param[4] + " "
            if type_param[-1] == "*":
                name_param = "*" + name_param
                type_param = type_param[:-1]
            self.decompiler_data.params["param" + str(num_of_param)] = name_param
            self.decompiler_data.type_params[name_param] = type_param
            self.decompiler_data.output_file.write(flag_param + type_param + " " + name_param)
            num_of_param += 1
        self.decompiler_data.output_file.write(")\n")

    def change_cfg_for_else_structure(self, curr_node, instruction):
        self.decompiler_data.parents_of_label[0].children.remove(self.decompiler_data.label)
        self.decompiler_data.parents_of_label[1].children.remove(self.decompiler_data.label)
        last_node = self.decompiler_data.parents_of_label[1]
        last_node_state = copy.deepcopy(self.decompiler_data.parents_of_label[1].state)
        if curr_node.parent[0].instruction[0].find("v_mov") != -1:
            last_node_state.registers[curr_node.parent[0].instruction[1]] \
                = curr_node.state.registers[curr_node.parent[0].instruction[1]]
        self.decompiler_data.from_node[instruction[1]].remove(curr_node)
        if self.decompiler_data.from_node.get(instruction[1], None) is None:
            self.decompiler_data.from_node[instruction[1]] = [self.decompiler_data.parents_of_label[0]]
        else:
            self.decompiler_data.from_node[instruction[1]].append(self.decompiler_data.parents_of_label[0])
        self.decompiler_data.flag_of_else = False
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
            variable = "var" + str(self.decompiler_data.num_of_var)
            if curr_node.state.registers[reg].type == Type.param_global_id_x:
                variable = "*" + variable
            curr_node.state.registers[reg].val = variable
            self.decompiler_data.num_of_var += 1
            for ver in version_of_reg:
                self.decompiler_data.variables[ver] = variable
        return curr_node

    def process_src(self, name_of_program, set_of_config, set_of_instructions):
        self.process_config(set_of_config, name_of_program)
        last_node = Node("", self.decompiler_data.initial_state)  # root
        last_node_state = self.decompiler_data.initial_state
        self.decompiler_data.cfg = last_node
        for row in set_of_instructions:
            instruction = row.strip().replace(',', ' ').split()
            curr_node = self.make_cfg_node(instruction, last_node_state, last_node)
            # curr_node.add_parent(last_node)
            if curr_node is None:
                for instr in set_of_instructions:
                    self.decompiler_data.output_file.write(instr + "\n")
                return
            last_node_state = copy.deepcopy(curr_node.state)
            if last_node is not None and last_node.instruction != "branch" and curr_node not in last_node.children:
                last_node.add_child(curr_node)
            last_node = curr_node
            if last_node is not None and last_node.instruction == "branch":
                last_node_state = copy.deepcopy(self.decompiler_data.initial_state)
            if instruction[0][0] == ".":
                self.decompiler_data.label = curr_node
                self.decompiler_data.parents_of_label = curr_node.parent
                self.decompiler_data.flag_of_else = True
            elif (instruction[0].find("andn2") != -1 or instruction[0].find("v_mov") != -1) and self.decompiler_data.flag_of_else:
                continue
            elif instruction[0].find("cbranch") != -1 and self.decompiler_data.flag_of_else:
                last_node, last_node_state = self.change_cfg_for_else_structure(curr_node, instruction)
            else:
                self.decompiler_data.flag_of_else = False
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
                            vals_of_parent = curr_node.parent[0].state.registers[register].val.split()
                            for val in vals_of_parent:
                                if val.find("var") != -1:
                                    var_name = val
                            if curr_node.parent[0].state.registers[register].val.find("*var") != -1:
                                self.decompiler_data.names_of_vars[var_name] = \
                                    curr_node.parent[0].state.registers[register].type_of_data
                            else:
                                self.decompiler_data.names_of_vars[var_name] = \
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
        self.decompiler_data.output_file.write("{\n")
        # for var in set(self.decompiler_data.variables.values()):
        #     if var in self.decompiler_data.names_of_vars.keys():
        for var in self.decompiler_data.names_of_vars.keys():
            type_of_var = self.make_type(self.decompiler_data.names_of_vars[var])
            self.decompiler_data.output_file.write("    " + type_of_var + " " + var + ";\n")
        offsets = list(self.decompiler_data.lds_vars.keys())
        offsets.append(self.decompiler_data.localsize)
        offsets.sort()
        for key in list(range(len(offsets) - 1)):
            size_var = int((offsets[key + 1] - offsets[key]) / (int(self.decompiler_data.lds_vars[offsets[key]][1][1:]) / 8))
            type_of_var = self.make_type(self.decompiler_data.lds_vars[offsets[key]][1])
            self.decompiler_data.output_file.write(
                "    __local " + type_of_var + " " + self.decompiler_data.lds_vars[offsets[key]][0] + "[" + str(size_var) + "]" + ";\n")
        self.make_output(self.decompiler_data.improve_cfg, '    ')
        self.decompiler_data.output_file.write("}\n")
        # while curr_node.children:
        #     self.to_opencl(curr_node.children[0], False)
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
        return self.to_opencl(node, True)

    def make_version(self):
        curr_node = self.decompiler_data.cfg
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
                    if self.decompiler_data.version_wait is None:
                        self.decompiler_data.version_wait = curr_node
                        visited.remove(curr_node)
                    elif self.decompiler_data.version_wait == curr_node:
                        self.update_versions(curr_node)
                        self.decompiler_data.version_wait = None
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
                                        self.decompiler_data.variables[v] = var
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
                                        self.decompiler_data.variables[v] = var
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
        curr_node = self.decompiler_data.cfg
        region = Region(TypeNode.linear, curr_node)
        self.decompiler_data.starts_regions[curr_node] = region
        self.decompiler_data.ends_regions[curr_node] = region
        visited = [curr_node]
        q = deque()
        q.append(curr_node.children[0])
        while q:
            curr_node = q.popleft()
            if curr_node not in visited:
                visited.append(curr_node)
                if len(curr_node.parent) == 1 and (len(curr_node.children) == 1 or len(curr_node.children) == 0):
                    if self.decompiler_data.ends_regions[curr_node.parent[0]].type == TypeNode.linear:
                        region = self.decompiler_data.ends_regions.pop(curr_node.parent[0])
                        region.end = curr_node
                        self.decompiler_data.ends_regions[curr_node] = region
                    else:
                        region = Region(TypeNode.linear, curr_node)
                        self.decompiler_data.starts_regions[curr_node] = region
                        self.decompiler_data.ends_regions[curr_node] = region
                        parent = self.decompiler_data.ends_regions[curr_node.parent[0]]
                        parent.add_child(region)
                        region.add_parent(parent)

                else:
                    region = Region(TypeNode.basic, curr_node)
                    self.decompiler_data.starts_regions[curr_node] = region
                    self.decompiler_data.ends_regions[curr_node] = region
                    for c_p in curr_node.parent:
                        if c_p in visited:
                            if self.decompiler_data.ends_regions.get(c_p) is not None:
                                parent = self.decompiler_data.ends_regions[c_p]
                            else:
                                parent = self.decompiler_data.ends_regions[curr_node.parent[0].children[0]]
                            parent.add_child(region)
                            region.add_parent(parent)

                for child in curr_node.children:
                    if child not in visited:
                        q.append(child)
                    else:
                        region.add_child(self.decompiler_data.starts_regions[child])
                        self.decompiler_data.starts_regions[child].add_parent(region)
        start_region = self.decompiler_data.starts_regions[self.decompiler_data.cfg]
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
                        #         node = self.to_opencl(Node(curr_node.children[0].instruction, copy.deepcopy(curr_node.state)), True)
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
        self.decompiler_data.improve_cfg = start_region

    def make_output(self, region, indent):
        if region.type == TypeNode.linear:
            if isinstance(region.start, Node):
                reg = region.start
                if region.start == self.decompiler_data.cfg:
                    reg = self.decompiler_data.cfg.children[0]
                while reg != region.end:
                    new_output = self.to_opencl(reg, False)
                    if new_output != "":
                        self.decompiler_data.output_file.write(indent + new_output + ";\n")
                    reg = reg.children[0]
                new_output = self.to_opencl(reg, False)
                if new_output != "":
                    self.decompiler_data.output_file.write(indent + new_output + ";\n")
            else:
                reg = region.start
                self.make_output(reg, indent)
                while reg != region.end:
                    reg = reg.children[0]
                    self.make_output(reg, indent)
        elif region.type == TypeNode.ifstatement:
            for key in self.decompiler_data.variables.keys():
                reg = key[:key.find("_")]
                if region.start.start.parent[0].state.registers[reg] is not None and \
                        region.start.start.parent[0].state.registers[reg].version == key and self.decompiler_data.variables[
                    key] in self.decompiler_data.names_of_vars.keys():
                    self.decompiler_data.output_file.write(
                        indent + self.decompiler_data.variables[key] + " = " + region.start.start.parent[0].state.registers[
                            reg].val + ";\n")
            self.decompiler_data.output_file.write(indent + "if (")
            self.decompiler_data.output_file.write(self.to_opencl(region.start.start, False))
            self.decompiler_data.output_file.write(") {\n")
            self.make_output(region.start.children[0], indent + '    ')
            for key in self.decompiler_data.variables.keys():
                reg = key[:key.find("_")]
                r_node = region.end.start
                while not isinstance(r_node, Node):
                    r_node = r_node.start
                if r_node.parent[0].state.registers[reg].version == key and self.decompiler_data.variables[
                    key] in self.decompiler_data.names_of_vars.keys():
                    self.decompiler_data.output_file.write(
                        indent + "    " + self.decompiler_data.variables[key] + " = " + r_node.parent[0].state.registers[
                            reg].val + ";\n")
            self.make_output(region.start.children[1], indent + '    ')
            self.decompiler_data.output_file.write(indent + "}\n")
        elif region.type == TypeNode.ifelsestatement:
            # self.output_file.write("    int variable\n")
            self.decompiler_data.output_file.write(indent + "if (")
            self.decompiler_data.output_file.write(self.to_opencl(region.start.start, False))
            self.decompiler_data.output_file.write(") {\n")
            if_body = region.start.children[0]
            self.make_output(if_body, indent + '    ')
            # if isinstance(if_body.start, Node) and if_body.end.instruction.find("store") == -1:
            #     last_node = if_body.end
            #     reg = last_node.instruction.split()[1][:-1]
            #     val_of_reg = last_node.state.registers[reg].val
            #     self.output_file.write("      variable = " + val_of_reg + "\n")
            #     self.initial_state.registers[reg] = Register("variable", Type.program_param, Integrity.integer)
            for key in self.decompiler_data.variables.keys():
                reg = key[:key.find("_")]
                r_node = region.end.start
                while not isinstance(r_node, Node):
                    r_node = r_node.start
                if r_node.parent[1].state.registers.get(reg) is not None \
                        and r_node.parent[1].state.registers[reg].version == key and self.decompiler_data.variables[
                    key] in self.decompiler_data.names_of_vars.keys():
                    if self.decompiler_data.variables[key].find("*") == -1:
                        self.decompiler_data.output_file.write(
                            indent + "    " + self.decompiler_data.variables[key] + " = " + r_node.parent[1].state.registers[
                                reg].val + ";\n")
                    else:
                        self.decompiler_data.output_file.write(indent + "    " + self.decompiler_data.variables[key][1:] + " = &" +
                                               r_node.parent[1].state.registers[reg].val + ";\n")
            self.decompiler_data.output_file.write(indent + "}\n")
            # last_if_region = region.start.children[1]
            # and_n2 = last_if_region.children[0]
            # else_start = and_n2.children[0]
            # else_body = else_start.children[0]
            # last_else_region = else_start.children[1]
            else_body = region.start.children[1]
            self.decompiler_data.output_file.write(indent + "else {\n")
            self.make_output(else_body, indent + '    ')
            # if isinstance(else_body.start, Node) and else_body.end.instruction.find("store") == -1:
            #     reg = else_body.end.instruction.split()[1][:-1]
            #     self.output_file.write("      variable = " + else_body.end.state.registers[reg].val + "\n")
            #     self.initial_state.registers[reg] = Register("variable", Type.program_param, Integrity.integer)
            for key in self.decompiler_data.variables.keys():
                reg = key[:key.find("_")]
                if region.end.start.parent[0].state.registers[reg].version == key and self.decompiler_data.variables[
                    key] in self.decompiler_data.names_of_vars.keys():
                    if self.decompiler_data.variables[key].find("*") == -1:
                        self.decompiler_data.output_file.write(
                            indent + "    " + self.decompiler_data.variables[key] + " = " + region.end.start.parent[0].state.registers[
                                reg].val + ";\n")
                    else:
                        self.decompiler_data.output_file.write(indent + "    " + self.decompiler_data.variables[key][1:] + " = &" +
                                               region.end.start.parent[0].state.registers[reg].val + ";\n")
            self.decompiler_data.output_file.write(indent + "}\n")

    def to_opencl(self, node, flag_of_status):
        output_string = ""
        if node.instruction[0][0] == ".":
            if flag_of_status:
                self.decompiler_data.to_node[node.instruction[0][:-1]] = node
                if self.decompiler_data.from_node.get(node.instruction[0][:-1]) is not None:
                    for wait_node in self.decompiler_data.from_node[node.instruction[0][:-1]]:
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
                            "f64", "i32", "i24", "byte"]:
                    # TODO: Дописать
                    if suffix != "":
                        suffix = suffix + "_" + part
                    else:
                        suffix = part
                else:
                    root = root + "_" + part

        prefix_root = prefix + "_" + root
        if instruction_dict.get(prefix_root) is not None:
            return instruction_dict[prefix_root].execute(node, instruction, flag_of_status, suffix)
        elif instruction_dict.get(node.instruction[0]) is not None:
            return instruction_dict[node.instruction[0]].execute(node, instruction, flag_of_status, suffix)
        else:
            self.decompiler_data.output_file.write("Not resolve yet.\n")
