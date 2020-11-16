from collections import deque
from src.type_of_reg import Type
from src.decompiler_data import DecompilerData


def make_version(state, parent, reg):
    decompiler_data = DecompilerData()
    if reg not in decompiler_data.versions:
        decompiler_data.versions[reg] = 0
    state.registers[reg].add_version(reg, parent[reg])
    parent[reg] += 1


def find_max_and_prev_versions(curr_node):
    for reg in curr_node.parent[0].state.registers:
        version_of_reg = set()
        max_version = 0
        for parent in curr_node.parent:
            if parent.state.registers.get(reg) is not None \
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
    return curr_node.state


def update_reg_version(reg, curr_node, max_version, version_of_reg):
    decompiler_data = DecompilerData()
    if len(version_of_reg) == 1:
        if curr_node.state.registers.get(reg) is None or curr_node.state.registers[reg] is None:
            for parent in curr_node.parent:
                if parent.state.registers[reg] is not None:
                    curr_node.state.registers[reg] = parent.state.registers[reg]
                    break
    elif len(version_of_reg) > 1:
        curr_node.state.registers[reg].version = reg + "_" + str(max_version + 1)
        curr_node.state.registers[reg].prev_version = list(version_of_reg)
        variable = "var" + str(decompiler_data.num_of_var)
        if curr_node.state.registers[reg].type == Type.param_global_id_x:
            variable = "*" + variable
        curr_node.state.registers[reg].val = variable
        decompiler_data.num_of_var += 1
        for ver in version_of_reg:
            decompiler_data.variables[ver] = variable
        decompiler_data.checked_variables[curr_node.state.registers[reg].version] = variable
        decompiler_data.versions[reg] = max_version + 1
    return curr_node


def check_for_use_new_version_in_one_instruction(curr_node, instruction):
    decompiler_data = DecompilerData()
    for num_of_reg in range(1, len(curr_node.instruction)):
        register = curr_node.instruction[num_of_reg]
        if ("flat_store" in curr_node.instruction[0]
            or num_of_reg > 1) \
                and len(register) > 1 \
                and "cnd" not in curr_node.instruction[0]:
            if register[1] == "[":
                register = register[0] + register[2: register.find(":")]
            first_reg = curr_node.instruction[1]
            if first_reg[1] == "[":
                first_reg = first_reg[0] + first_reg[2: first_reg.find(":")]
            if curr_node.state.registers.get(register) is not None:
                checked_version = curr_node.state.registers[register].version
            else:
                continue
            if first_reg == register:
                checked_version = curr_node.parent[0].state.registers[register].version
            if curr_node.state.registers.get(register) is not None \
                    and decompiler_data.checked_variables.get(checked_version) is not None \
                    and curr_node.state.registers[register].type_of_data is not None \
                    and (register != "vcc" or "and_saveexec" in instruction[0]):
                var_name = decompiler_data.checked_variables[checked_version]
                if decompiler_data.names_of_vars.get(var_name) is None:
                    if decompiler_data.checked_variables.get(
                            curr_node.parent[0].state.registers[register].version) is not None:
                        decompiler_data.names_of_vars[var_name] = \
                            curr_node.parent[0].state.registers[register].type_of_data
                    else:
                        decompiler_data.names_of_vars[var_name] = \
                            curr_node.state.registers[register].type_of_data


def check_for_use_new_version():
    decompiler_data = DecompilerData()
    curr_node = decompiler_data.cfg
    visited = [curr_node]
    queue = deque()
    queue.append(curr_node.children[0])
    while queue:
        curr_node = queue.popleft()
        if curr_node not in visited:
            visited.append(curr_node)
            if len(curr_node.parent) < 2:
                if decompiler_data.checked_variables != {}:
                    instruction = curr_node.instruction
                    if instruction != "branch" and len(instruction) > 1:
                        check_for_use_new_version_in_one_instruction(curr_node, instruction)
            else:
                flag_of_continue = False
                for c_p in curr_node.parent:
                    if c_p not in visited:
                        flag_of_continue = True
                        break
                if flag_of_continue:
                    visited.remove(curr_node)
                    continue
            for child in curr_node.children:
                if child not in visited:
                    queue.append(child)


def remove_unusable_versions():
    decompiler_data = DecompilerData()
    keys = []
    for key in decompiler_data.variables.keys():
        if decompiler_data.variables[key] not in decompiler_data.names_of_vars.keys():
            keys.append(key)
    for key in keys:
        decompiler_data.variables.pop(key)


def update_value_for_reg(first_reg, curr_node):
    for child in curr_node.children:
        if len(child.parent) < 2 \
                and curr_node.state.registers[first_reg].version == child.state.registers[first_reg].version:
            child.state.registers[first_reg] = curr_node.state.registers[first_reg]
            update_value_for_reg(first_reg, child)


def update_val_from_changes(curr_node, register, changes, check_version, num_of_reg, first_reg):
    instruction = curr_node.instruction
    if curr_node.state.registers.get(register) is not None \
            and changes.get(check_version) \
            and curr_node.state.registers[register].type_of_data is not None \
            and (register != "vcc" or "and_saveexec" in instruction[0]):
        if "flat_store" in instruction[0]:
            if num_of_reg == 1:
                node_registers = curr_node.parent[0].state.registers
            else:
                node_registers = curr_node.state.registers
                first_reg = register
        elif "and_saveexec" in instruction[0]:
            node_registers = curr_node.state.registers
            first_reg = "exec"
        else:
            node_registers = curr_node.state.registers
        copy_val_prev = node_registers[first_reg].val
        node_registers[first_reg].val = node_registers[first_reg].val.replace(
            changes[check_version][1],
            changes[check_version][0])
        copy_val_last = node_registers[first_reg].val
        if copy_val_prev != copy_val_last:
            changes[node_registers[first_reg].version] = [copy_val_last, copy_val_prev]
            update_value_for_reg(first_reg, curr_node)
    return changes


def update_val_from_checked_variables(curr_node, register, check_version, first_reg, changes):
    decompiler_data = DecompilerData()
    instruction = curr_node.instruction
    if curr_node.state.registers.get(register) is not None \
            and decompiler_data.variables.get(check_version) is not None \
            and curr_node.state.registers[register].type_of_data is not None \
            and (register != "vcc" or "and_saveexec" in instruction[0]):
        val_reg = curr_node.state.registers[register].val
        if register == first_reg:
            val_reg = curr_node.parent[0].state.registers[first_reg].val
        copy_val_prev = curr_node.state.registers[first_reg].val
        if decompiler_data.checked_variables.get(check_version) is not None:
            curr_node.state.registers[first_reg].val = \
                curr_node.state.registers[first_reg].val.replace(val_reg,
                                                                 decompiler_data.checked_variables[check_version])
        else:
            curr_node.state.registers[first_reg].val = \
                curr_node.state.registers[first_reg].val.replace(val_reg, decompiler_data.variables[check_version])
        copy_val_last = curr_node.state.registers[first_reg].val
        if copy_val_prev != copy_val_last:
            changes[curr_node.state.registers[first_reg].version] = [copy_val_last, copy_val_prev]
            update_value_for_reg(first_reg, curr_node)


def change_values_for_one_instruction(curr_node, changes):
    for num_of_reg in range(1, len(curr_node.instruction)):
        register = curr_node.instruction[num_of_reg]
        if ("flat_store" in curr_node.instruction[0] or num_of_reg > 1) and len(register) > 1 \
                and "cnd" not in curr_node.instruction[0]:
            if register[1] == "[":
                register = register[0] + register[2: register.find(":")]
            first_reg = curr_node.instruction[1]
            if first_reg[1] == "[":
                first_reg = first_reg[0] + first_reg[2: first_reg.find(":")]
            if curr_node.state.registers.get(register) is not None:
                check_version = curr_node.state.registers[register].version
            else:
                continue
            if register == first_reg:
                if curr_node.parent[0].state.registers.get(register) is not None:
                    check_version = curr_node.parent[0].state.registers[register].version
                else:
                    continue
            changes = update_val_from_changes(curr_node, register, changes, check_version, num_of_reg,
                                              first_reg)
            update_val_from_checked_variables(curr_node, register, check_version, first_reg, changes)


def change_values():
    decompiler_data = DecompilerData()
    changes = {}
    curr_node = decompiler_data.cfg
    visited = [curr_node]
    queue = deque()
    queue.append(curr_node.children[0])
    while queue:
        curr_node = queue.popleft()
        if curr_node not in visited:
            visited.append(curr_node)
            if len(curr_node.parent) < 2:
                instruction = curr_node.instruction
                if instruction != "branch" and len(instruction) > 1:
                    change_values_for_one_instruction(curr_node, changes)
            else:
                flag_of_continue = False
                for c_p in curr_node.parent:
                    if c_p not in visited:
                        flag_of_continue = True
                        break
                if flag_of_continue:
                    visited.remove(curr_node)
                    continue
            for child in curr_node.children:
                if child not in visited:
                    queue.append(child)
