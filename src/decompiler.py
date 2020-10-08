import copy
from collections import deque
from src.regions.functions_for_regions import process_region_graph
from src.integrity import Integrity
from src.node import Node
from src.regions.region import Region
from src.register import Register
from src.type_of_node import TypeNode
from src.type_of_reg import Type
from src.decompiler_data import DecompilerData
from src.instruction_dict import instruction_dict
from src.versions import update_reg_version, remove_unusable_versions, change_values, check_for_many_versions


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
        self.decompiler_data.from_node[instruction[1]].remove(curr_node)
        from_node = instruction[1]
        if self.decompiler_data.from_node.get(from_node, None) is None:
            self.decompiler_data.from_node[from_node] = []
        for parents_of_label in self.decompiler_data.parents_of_label:
            if parents_of_label != self.decompiler_data.parents_of_label[1]:
                self.decompiler_data.from_node[from_node].append(parents_of_label)
        self.decompiler_data.flag_of_else = False
        return last_node, last_node_state

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
                if instruction[0].find("andn2") == -1 and set_of_instructions[num].find("branch") != -1:
                    set_of_instructions.insert(num + 1, row)
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
                    curr_node = update_reg_version(reg, curr_node, max_version, version_of_reg)
                last_node_state = curr_node.state
        check_for_many_versions()
        remove_unusable_versions()
        if self.decompiler_data.checked_variables != {} or self.decompiler_data.variables != {}:
            change_values()
        self.make_region_graph_from_cfg()
        process_region_graph()
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
        elif asm_type == "b64":
            return "ulong"
        elif asm_type == "dword":
            return "int"
        elif asm_type == "dwordx2":
            return "dwordx2"
        elif asm_type == "f32":
            return "float"

    def make_cfg_node(self, instruction, last_node_state, last_node):
        node = Node(instruction, last_node_state)
        if last_node.instruction != "branch":
            node.add_parent(last_node)
        return self.to_opencl(node, True)

    def make_region_graph_from_cfg(self):
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
