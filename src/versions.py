import copy
import re
from collections import deque

from src.expression_manager.expression_node import expression_to_string
from src.types.opencl_types import OpenCLTypes
from src.decompiler_data import DecompilerData
from src.expression_manager.expression_manager import ExpressionManager
from src.register_type import RegisterType


def find_max_and_prev_versions(curr_node):
    for reg in curr_node.state:
        if reg in {"vcc", "scc", "exec"}:
            continue
        prev_versions_of_reg = set()
        max_version = 0
        for parent in curr_node.parent:
            if reg in parent.state and parent.state[reg].version is not None:
                parent_version = parent.state[reg].version
                prev_versions_of_reg.add(parent_version)
                if len(prev_versions_of_reg) == 0 or int(parent_version[parent_version.find("_") + 1 :]) > max_version:
                    max_version = int(parent_version[parent_version.find("_") + 1 :])
        if len(prev_versions_of_reg) > 1:
            curr_node = update_reg_version(reg, curr_node, max_version, prev_versions_of_reg)
    return curr_node.state


def update_reg_version(reg, curr_node, max_version, prev_versions_of_reg):
    decompiler_data = DecompilerData()
    curr_node.state[reg].add_version(reg, max_version)
    curr_node.state[reg].prev_version = list(prev_versions_of_reg)
    variable = "var" + str(decompiler_data.num_of_var)
    for prev in prev_versions_of_reg:
        if decompiler_data.checked_variables.get(prev):
            old_var = decompiler_data.checked_variables[prev]
            decompiler_data.checked_variables[prev] = variable
            decompiler_data.variables = {k: v.replace(old_var, variable) for k, v in decompiler_data.variables.items()}
    curr_node.state[reg].register_content._value = variable  # noqa: SLF001
    #todo do we need additional checks?
    curr_node.state[reg].register_content._expression_node = ExpressionManager().add_variable_node(variable, OpenCLTypes.UINT)
    if curr_node.state[reg].type in {
        RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT,
        RegisterType.ADDRESS_KERNEL_ARGUMENT,
    }:
        decompiler_data.address_params.add(variable)
    decompiler_data.update_reg_version(prev_versions_of_reg, variable, curr_node, reg, max_version)
    return curr_node


def check_for_use_new_version_in_one_instruction(curr_node):
    for num_of_reg in range(1, len(curr_node.instruction)):
        register = curr_node.instruction[num_of_reg]
        if (
            (re.match(r"(flat|global)_store", curr_node.instruction[0]) or num_of_reg > 1)
            and len(register) > 1
            and "cnd" not in curr_node.instruction[0]
        ):
            if register[1] == "[":
                register = register[0] + register[2 : register.find(":")]
            parent_register = curr_node.parent[0].state.get(register)
            if parent_register is not None:
                decompiler_data = DecompilerData()
                checked_version = parent_register.version
                if decompiler_data.checked_variables.get(checked_version) is not None:
                    var = decompiler_data.checked_variables[checked_version]
                    data_type = parent_register.data_type
                    if data_type is not None and decompiler_data.names_of_vars.get(var) is None:
                        decompiler_data.names_of_vars[var] = data_type


def check_for_use_new_version():
    queue = deque()
    queue.append(DecompilerData().cfg)
    visited = []

    while len(queue) > 0:
        node = queue.popleft()
        visited.append(node)
        if len(node.parent) == 1:
            check_for_use_new_version_in_one_instruction(node)
        for child in node.children:
            if child not in visited:
                queue.append(child)


def update_value_for_reg(first_reg, curr_node):
    for child in curr_node.children:
        if len(child.parent) < 2 and curr_node.state[first_reg].version == child.state[first_reg].version:  # noqa: PLR2004
            child.state[first_reg] = copy.deepcopy(curr_node.state[first_reg])
            update_value_for_reg(first_reg, child)


def update_val_from_changes(curr_node, register, changes, check_version, num_of_reg, first_reg):  # noqa: PLR0913
    instruction = curr_node.instruction
    if (
        register in curr_node.state
        and changes.get(check_version)
        and curr_node.state[register].data_type is not None
        and (register != "vcc" or "and_saveexec" in instruction[0])
    ):
        if re.match(r"(flat|global)_store", instruction[0]):
            if num_of_reg == 1:
                node_state = curr_node.parent[0].state
            else:
                node_state = curr_node.state
                first_reg = register
        elif "and_saveexec" in instruction[0]:
            node_state = curr_node.state
            first_reg = "exec"
        else:
            node_state = curr_node.state
            if first_reg != register:
                node_state[register].register_content._value = node_state[register].val.replace(  # noqa: SLF001
                    changes[check_version][1], changes[check_version][0]
                )

                node_state[register].register_content._expression_node = node_state[register].register_content._expression_node.replace(
                    changes[check_version + "_expr_node"][1], changes[check_version + "_expr_node"][0]) # noqa: SLF001
                
        copy_val_prev = node_state[first_reg].val
        copy_expr_node_prev = copy.deepcopy(node_state[first_reg].register_content._expression_node)
        node_state[first_reg].register_content._value = node_state[first_reg].val.replace(  # noqa: SLF001
            changes[check_version][1], changes[check_version][0]
        )

        node_state[first_reg].register_content._expression_node = node_state[first_reg].register_content._expression_node.replace(
                    changes[check_version + "_expr_node"][1], changes[check_version + "_expr_node"][0]) # noqa: SLF001
        
        copy_val_last = node_state[first_reg].val
        copy_expr_node_last = node_state[first_reg].register_content._expression_node

        if copy_val_prev != copy_val_last:
            print(expression_to_string(copy_expr_node_prev), expression_to_string(copy_expr_node_last))
            assert(copy_expr_node_prev != copy_expr_node_last)

            if changes.get(node_state[first_reg].version) is not None:
                copy_val_prev = changes[node_state[first_reg].version][1]

            if changes.get(node_state[first_reg].version + "_expr_node") is not None:
                copy_expr_node_prev = changes[node_state[first_reg].version + "_expr_node"][1]

            changes[node_state[first_reg].version] = [copy_val_last, copy_val_prev]
            changes[node_state[first_reg].version + "_expr_node"] = [copy_expr_node_last, copy_expr_node_prev]
            update_value_for_reg(first_reg, curr_node)
    return changes


def update_val_from_checked_variables(curr_node, register, check_version, first_reg, changes):
    decompiler_data = DecompilerData()
    instruction = curr_node.instruction
    if (
        register in curr_node.state
        and decompiler_data.variables.get(check_version) is not None
        and curr_node.state[register].data_type is not None
        and (register != "vcc" or "and_saveexec" in instruction[0])
    ):
        if curr_node.instruction[0] == "flat_store_dword":
            pass
        val_reg = curr_node.state[register].val
        expr_node = curr_node.state[register].register_content._expression_node
        if register == first_reg:
            if changes.get(curr_node.parent[0].state[first_reg].version) is None:
                val_reg = curr_node.parent[0].state[first_reg].val
                expr_node = curr_node.parent[0].state[first_reg].register_content._expression_node
            else:
                val_reg = changes[curr_node.parent[0].state[first_reg].version][0]
                expr_node = changes[curr_node.parent[0].state[first_reg].version + "_expr_node"][0] #todo store expr node in changes
        copy_val_prev = curr_node.state[first_reg].val
        copy_expr_node_prev = copy.deepcopy(curr_node.state[first_reg].register_content._expression_node)
        if decompiler_data.checked_variables.get(check_version) is not None:

            #todo move that to checked_variables...
            tmp_var_node = ExpressionManager().add_variable_node(decompiler_data.checked_variables[check_version], OpenCLTypes.UINT)
            if re.match(r"(flat|global)_(store|load)", instruction[0]):
                curr_node.state[register].register_content._expression_node = curr_node.state[register].register_content._expression_node.replace(expr_node, tmp_var_node)
            else:
                curr_node.state[first_reg].register_content._expression_node = curr_node.state[first_reg].register_content._expression_node.replace(expr_node, tmp_var_node)

            if curr_node.state[first_reg].val.find(val_reg) != -1:
                curr_node.state[first_reg].register_content._value = curr_node.state[first_reg].val.replace(  # noqa: SLF001
                    val_reg, decompiler_data.checked_variables[check_version]
                )
            elif re.match(r"(flat|global)_(store|load)", instruction[0]):
                curr_node.state[register].register_content._value = curr_node.state[register].val.replace(  # noqa: SLF001
                    val_reg, decompiler_data.checked_variables[check_version]
                )
                # а тут наоборот, наверное, надо сделать присвоение для первого регистра
        elif curr_node.state[first_reg].val.find(val_reg) != -1 and first_reg in {"vcc", "scc", "exec"}:
            curr_node.state[first_reg].register_content._value = curr_node.state[first_reg].val.replace(  # noqa: SLF001
                val_reg, decompiler_data.variables[check_version]
            )

            tmp_var_node = ExpressionManager().add_variable_node(decompiler_data.variables[check_version], OpenCLTypes.UINT)
            curr_node.state[first_reg].register_content._expression_node = curr_node.state[first_reg].register_content._expression_node.replace(expr_node, tmp_var_node)
        elif re.match(r"(flat|global)_store", instruction[0]):
            curr_node.state[register].register_content._value = curr_node.state[register].val.replace(  # noqa: SLF001
                val_reg, decompiler_data.variables[check_version]
            )
            #todo need it here?
            tmp_var_node = ExpressionManager().add_variable_node(decompiler_data.variables[check_version], OpenCLTypes.UINT)
            curr_node.state[register].register_content._expression_node = curr_node.state[register].register_content._expression_node.replace(expr_node, tmp_var_node)

        copy_val_last = curr_node.state[first_reg].val
        copy_expr_node_last = copy.deepcopy(curr_node.state[first_reg].register_content._expression_node)
        if copy_val_prev != copy_val_last:
            assert(copy_expr_node_last != copy_expr_node_prev)
            changes[curr_node.state[first_reg].version] = [copy_val_last, copy_val_prev]
            changes[curr_node.state[first_reg].version + "_expr_node"] = [copy_expr_node_last, copy_expr_node_prev]
            update_value_for_reg(first_reg, curr_node)


def change_values_for_one_instruction(curr_node, changes):
    for num_of_reg in range(1, len(curr_node.instruction)):
        register = curr_node.instruction[num_of_reg]
        if (
            (
                re.match(r"(flat|global)_store", curr_node.instruction[0])
                or num_of_reg > 1
                or "s_cmp" in curr_node.instruction[0]
            )
            and len(register) > 1
            and "cnd" not in curr_node.instruction[0]
        ):
            if (
                register[1] == "["
                and "s_or" not in curr_node.instruction[0]
                and "s_and" not in curr_node.instruction[0]
            ):
                register = register[0] + register[2 : register.find(":")]
            
            first_reg = curr_node.instruction[1]

            if "s_cmp" in curr_node.instruction[0]:
                first_reg = "scc"

            if (
                first_reg[1] == "["
                and "s_or" not in curr_node.instruction[0]
                and "s_and" not in curr_node.instruction[0]
            ):
                first_reg = first_reg[0] + first_reg[2 : first_reg.find(":")]

            if register in curr_node.state:
                check_version = curr_node.state[register].version
            else:
                continue

            if register == first_reg:
                if register in curr_node.parent[0].state:
                    check_version = curr_node.parent[0].state[register].version
                else:
                    continue

            changes = update_val_from_changes(curr_node, register, changes, check_version, num_of_reg, first_reg)
            update_val_from_checked_variables(curr_node, register, check_version, first_reg, changes)
    if "select" in curr_node.instruction[0]:
        first_reg = curr_node.instruction[1]
        check_version = curr_node.state["scc"].version
        changes = update_val_from_changes(curr_node, "scc", changes, check_version, 0, first_reg)
        update_val_from_checked_variables(curr_node, "scc", check_version, first_reg, changes)


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
            if len(curr_node.parent) < 2:  # noqa: PLR2004
                instruction = curr_node.instruction
                if (instruction != "c_branch" or curr_node in decompiler_data.back_edges) and len(instruction) > 1:
                    change_values_for_one_instruction(curr_node, changes)
            else:
                flag_of_continue = False
                for c_p in curr_node.parent:
                    if c_p not in visited and curr_node not in decompiler_data.loops:
                        flag_of_continue = True
                        break
                if flag_of_continue:
                    visited.remove(curr_node)
                    continue
            for child in curr_node.children:
                if child not in visited:
                    queue.append(child)
