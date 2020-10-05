import copy
import re
from collections import deque
from src.integrity import Integrity
from src.node import Node
from src.region import Region
from src.register import Register
from src.type_of_node import TypeNode
from src.type_of_reg import Type
from src.decompiler_data import DecompilerData
from src.instruction_dict import instruction_dict


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
        for parents_of_label in self.decompiler_data.parents_of_label:
            parents_of_label.children.remove(self.decompiler_data.label)
        last_node = self.decompiler_data.parents_of_label[1]
        last_node_state = copy.deepcopy(self.decompiler_data.parents_of_label[1].state)
        if curr_node.parent[0].instruction[0].find("andn2") == -1:
            last_node_state.registers[curr_node.parent[0].instruction[1]] \
                = curr_node.state.registers[curr_node.parent[0].instruction[1]]
        self.decompiler_data.from_node[instruction[1]].remove(curr_node)
        from_node = instruction[1]
        if self.decompiler_data.from_node.get(from_node, None) is None:
            self.decompiler_data.from_node[from_node] = []
        for parents_of_label in self.decompiler_data.parents_of_label:
            if parents_of_label != self.decompiler_data.parents_of_label[1]:
                self.decompiler_data.from_node[from_node].append(parents_of_label)
        self.decompiler_data.flag_of_else = False
        return last_node, last_node_state

    def update_reg_version(self, reg, curr_node, max_version, version_of_reg):
        if len(version_of_reg) == 1:
            if curr_node.state.registers.get(reg) is None or curr_node.state.registers[reg] is None:
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
            self.decompiler_data.versions[reg] = max_version + 1
        return curr_node

    def process_src(self, name_of_program, set_of_config, set_of_instructions):
        self.process_config(set_of_config, name_of_program)
        last_node = Node([""], self.decompiler_data.initial_state)
        last_node_state = self.decompiler_data.initial_state
        self.decompiler_data.cfg = last_node
        num = 0
        while num < len(set_of_instructions):
            row = set_of_instructions[num]
            instruction = row.strip().replace(',', ' ').split()
            if instruction[0].find("s_and_saveexec_b64") != -1 \
                    and (set_of_instructions[num + 1].find("branch") == -1
                         and set_of_instructions[num + 2].find("branch") == -1
                         and set_of_instructions[num + 3].find("branch") == -1):
                self.decompiler_data.num_of_label += 1
                set_of_instructions.insert(num + 1, "s_cbranch_execz ." + str(self.decompiler_data.num_of_label))
            if instruction[0].find("andn2") != -1 and set_of_instructions[num - 1].find(".") == -1:
                set_of_instructions.insert(num + 1, row)
                new_val = "." + str(self.decompiler_data.num_of_label) + ":"
                set_of_instructions[num] = new_val
                instruction = [new_val]
            if instruction[0].find("andn2") != -1 \
                    and (set_of_instructions[num + 1].find("cbranch") == -1
                         and set_of_instructions[num + 2].find("cbranch") == -1):
                self.decompiler_data.num_of_label += 1
                set_of_instructions.insert(num + 1, "s_cbranch_execz ." + str(self.decompiler_data.num_of_label))
            if instruction[0] == "s_mov_b64" and instruction[1] == "exec" and curr_node.instruction[0].find(".") == -1:
                set_of_instructions.insert(num + 1, row)
                instruction = ["." + str(self.decompiler_data.num_of_label) + ":"]
            curr_node = self.make_cfg_node(instruction, last_node_state, last_node)
            num += 1
            if curr_node is None:
                self.decompiler_data.output_file.write("Not resolve yet. " + row + "\n")
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
            elif (instruction[0].find("andn2") != -1 or (num < len(set_of_instructions) and set_of_instructions[num].find("branch") != -1)) and self.decompiler_data.flag_of_else:
                continue
            elif self.decompiler_data.flag_of_else and instruction[0].find("cbranch") != -1:
                    last_node, last_node_state = self.change_cfg_for_else_structure(curr_node, instruction)
            else:
                self.decompiler_data.flag_of_else = False
            if instruction[0][0] == "." and len(curr_node.parent) > 1:
                for reg in curr_node.parent[0].state.registers:
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
                            vals_of_parent = re.split(' |\[|\]|\)|\(',curr_node.parent[0].state.registers[register].val)
                            var_name = curr_node.state.registers[register].val
                            for val in vals_of_parent:
                                if val.find("var") != -1:
                                    var_name = val
                            if var_name.find(" ") == -1 and self.decompiler_data.names_of_vars.get(var_name) is None:
                                if curr_node.parent[0].state.registers[register].val.find("*var") != -1:
                                    self.decompiler_data.names_of_vars[var_name] = \
                                        curr_node.parent[0].state.registers[register].type_of_data
                                else:
                                    self.decompiler_data.names_of_vars[var_name] = \
                                        curr_node.state.registers[register].type_of_data
        self.process_cfg()
        self.decompiler_data.output_file.write("{\n")
        for var in sorted(self.decompiler_data.names_of_vars.keys()):
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

    def update_versions(self, node):
        diff_regs = {}
        parent_0 = node.parent[0].state.registers
        parent_1 = node.parent[1].state.registers
        for key in parent_0.keys():
            if parent_0.get(key) is not None and parent_1.get(key) is not None \
                    and parent_0[key].version != parent_1[key].version and key.find("v") != -1:
                diff_regs[key] = [parent_0[key].version, parent_1[key].version]
        visited = []
        q = deque()
        q.append(node)
        while q:
            curr_node = q.popleft()
            if curr_node not in visited:
                visited.append(curr_node)
                for key in diff_regs:
                    if curr_node.state.registers[key].version == diff_regs[key][1]:
                        curr_node.state.registers[key].prev_version = diff_regs[key]
                    curr_node.state.registers[key].update(key)
                for child in curr_node.children:
                    if child not in visited:
                        q.append(child)

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
                    index = parent.children.index(before_region)
                    parent.children[index] = region
                    region.add_parent(parent)
                if next_region is not None:
                    index = next_region.parent.index(curr_region)
                    next_region.parent[index] = region
                    region.add_child(next_region)
                if next_region is not None and next_region.type != TypeNode.basic and len(curr_region.parent) == 1:
                    region_all = Region(TypeNode.linear, before_region)
                    region_all.end = next_region
                    if start_now == region:
                        start_now = region_all
                    else:
                        parent = before_region.parent[0]
                        index = parent.children.index(region)
                        parent.children[index] = region_all
                        region_all.add_parent(parent)
                    if next_region.children:
                        child = next_region.children[0]
                        index = child.parent.index(next_region)
                        child.parent[index] = region_all
                        region_all.add_child(child)
                return start_now

        if next_region is not None and next_region != TypeNode.basic and len(curr_region.parent) == 1:
            region_all = Region(TypeNode.linear, curr_region)
            region_all.end = next_region
            for prev_r in before_region:
                index = prev_r.children.index(curr_region)
                prev_r.children[index] = region_all
                region_all.add_parent(prev_r)
            if next_region.children:
                child = next_region.children[0]
                index = child.parent.index(next_region)
                child.parent[index] = region_all
                region_all.add_child(child)
        return start_region

    def check_if(self, curr_region):
        if curr_region.type == TypeNode.basic and len(curr_region.children) == 2 \
                and (len(curr_region.children[0].children) > 0
                     and curr_region.children[0].children[0] == curr_region.children[1]
                     or len(curr_region.children[1].children) > 0
                     and curr_region.children[1].children[0] == curr_region.children[0]):
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
            index = before_r[i].children.index(pred_child[i])
            before_r[i].children[index] = region
            region.add_parent(before_r[i])
        if next_r is not None:
            index = next_r.parent.index(pred_parent)
            next_r.parent[index] = region
            region.add_child(next_r)

    def create_new_region(self, prev_reg_1, prev_reg_2, next_reg):
        prev_reg_1.children.remove(next_reg)
        prev_reg_2.children.remove(next_reg)
        position = next_reg.parent.index(prev_reg_1)
        new_fiction_region = Region(TypeNode.linear, next_reg.start)
        next_reg.parent[position] = new_fiction_region
        next_reg.parent.remove(prev_reg_2)
        prev_reg_1.children.append(new_fiction_region)
        prev_reg_2.children.append(new_fiction_region)
        new_fiction_region.parent.append(prev_reg_1)
        new_fiction_region.parent.append(prev_reg_2)
        new_fiction_region.children.append(next_reg)
        return new_fiction_region

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
                    flag_of_continue = False
                    for c_p in curr_node.parent:
                        if c_p not in visited:
                            flag_of_continue = True
                            break
                    if flag_of_continue:
                        visited.remove(curr_node)
                        continue
                    for c_p in curr_node.parent:
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
                        region = Region(TypeNode.ifstatement, curr_region)
                        child0 = curr_region.children[0] if len(curr_region.children[0].parent) == 1 else \
                            curr_region.children[1]
                        child1 = curr_region.children[1] if len(curr_region.children[1].parent) > 1 else \
                            curr_region.children[0]
                        before_r = [curr_region.parent[0]]
                        prev_child = [curr_region]
                        if len(child1.parent) > 2:
                            child1 = self.create_new_region(curr_region, child0, child1)
                        region.end = child1
                        visited.append(child1)
                        visited.append(child0)
                        next_r = child1.children[0] if len(child1.children) > 0 else None
                        self.add_parent_and_child(before_r, next_r, region, prev_child, region.end)
                        start_region = self.union_regions(before_r, region, next_r, start_region)
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
                        if len(region.end.parent) > 2:
                            region.end = self.create_new_region(child0, child1, child0.children[0])
                        prev_child = [curr_region]
                        visited.append(child1)
                        visited.append(child0)
                        visited.append(region.end)
                        before_r = [curr_region.parent[0]]
                        next_r = region.end.children[0]
                        self.add_parent_and_child(before_r, next_r, region, prev_child, region.end)
                        start_region = self.union_regions(before_r, region, next_r, start_region)
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
                if region.start.start.parent[0].state.registers[reg] is not None \
                        and region.start.start.parent[0].state.registers[reg].version == key \
                        and self.decompiler_data.variables[key] in self.decompiler_data.names_of_vars.keys():
                    self.decompiler_data.output_file.write(
                        indent + self.decompiler_data.variables[key] + " = "
                        + region.start.start.parent[0].state.registers[reg].val + ";\n")
            self.decompiler_data.output_file.write(indent + "if (")
            self.decompiler_data.output_file.write(self.to_opencl(region.start.start, False))
            self.decompiler_data.output_file.write(") {\n")
            self.make_output(region.start.children[0], indent + '    ')
            for key in self.decompiler_data.variables.keys():
                reg = key[:key.find("_")]
                r_node = region.end.start
                while not isinstance(r_node, Node):
                    r_node = r_node.start
                if r_node.parent[0].state.registers[reg].version == key \
                        and self.decompiler_data.variables[key] in self.decompiler_data.names_of_vars.keys() \
                        and self.decompiler_data.variables[key] != r_node.parent[0].state.registers[reg].val:
                    self.decompiler_data.output_file.write(indent + "    " + self.decompiler_data.variables[key] + " = "
                                                           + r_node.parent[0].state.registers[reg].val + ";\n")
            self.make_output(region.start.children[1], indent + '    ')
            self.decompiler_data.output_file.write(indent + "}\n")
        elif region.type == TypeNode.ifelsestatement:
            for key in self.decompiler_data.variables.keys():
                reg = key[:key.find("_")]
                if region.start.start.parent[0].state.registers[reg] is not None \
                        and region.start.start.parent[0].state.registers[reg].version == key \
                        and self.decompiler_data.variables[key] in self.decompiler_data.names_of_vars.keys() \
                        and self.decompiler_data.variables[key] != region.start.start.parent[0].state.registers[reg].val:
                    self.decompiler_data.output_file.write(
                        indent + self.decompiler_data.variables[key] + " = "
                        + region.start.start.parent[0].state.registers[reg].val + ";\n")
            self.decompiler_data.output_file.write(indent + "if (")
            self.decompiler_data.output_file.write(self.to_opencl(region.start.start, False))
            self.decompiler_data.output_file.write(") {\n")
            if_body = region.start.children[0]
            self.make_output(if_body, indent + '    ')
            for key in self.decompiler_data.variables.keys():
                reg = key[:key.find("_")]
                r_node_parent = region.start.children[0].end
                while not isinstance(r_node_parent, Node):
                    r_node_parent = r_node_parent.end
                if r_node_parent.state.registers.get(reg) is not None \
                        and r_node_parent.state.registers[reg].version == key \
                        and self.decompiler_data.variables[key] in self.decompiler_data.names_of_vars.keys() \
                        and self.decompiler_data.variables[key] != r_node_parent.state.registers[reg].val \
                        and (region.start.start.parent[0].state.registers[reg] is None
                             or r_node_parent.state.registers[reg].version != region.start.start.parent[0].state.registers[reg].version):
                    if self.decompiler_data.variables[key].find("*") == -1:
                        self.decompiler_data.output_file.write(indent + "    " + self.decompiler_data.variables[key] +
                                                               " = " + r_node_parent.state.registers[reg].val + ";\n")
                    else:
                        self.decompiler_data.output_file.write(
                            indent + "    " + self.decompiler_data.variables[key][1:] + " = &" +
                            r_node_parent.state.registers[reg].val + ";\n")
            self.decompiler_data.output_file.write(indent + "}\n")
            else_body = region.start.children[1]
            self.decompiler_data.output_file.write(indent + "else {\n")
            self.make_output(else_body, indent + '    ')
            for key in self.decompiler_data.variables.keys():
                reg = key[:key.find("_")]
                r_node_parent = region.start.children[1].end
                while not isinstance(r_node_parent, Node):
                    r_node_parent = r_node_parent.end
                if r_node_parent.state.registers.get(reg) is not None \
                        and r_node_parent.state.registers[reg].version == key \
                        and self.decompiler_data.variables[key] in self.decompiler_data.names_of_vars.keys() \
                        and self.decompiler_data.variables[key] != r_node_parent.state.registers[reg].val \
                        and (region.start.start.parent[0].state.registers[reg] is None
                             or r_node_parent.state.registers[reg].version != region.start.start.parent[0].state.registers[reg].version):
                    if self.decompiler_data.variables[key].find("*") == -1:
                        self.decompiler_data.output_file.write(
                            indent + "    " + self.decompiler_data.variables[key] + " = "
                            + r_node_parent.state.registers[reg].val + ";\n")
                    else:
                        self.decompiler_data.output_file.write(indent + "    " + self.decompiler_data.variables[key][1:]
                                                               + " = &" + r_node_parent.state.registers[reg].val + ";\n")
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
            return
