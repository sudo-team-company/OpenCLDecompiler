import copy

from src.cfg import make_cfg_node, make_unresolved_node
from src.code_printer import create_opencl_body
from src.decompiler_data import DecompilerData, optimize_names_of_vars
from src.flag_type import FlagType
from src.global_data import process_global_data, gdata_type_processing
from src.kernel_params import process_kernel_params
from src.logical_variable import ExecCondition
from src.node import Node
from src.node_processor import check_realisation_for_node
from src.regions.functions_for_regions import make_region_graph_from_cfg, process_region_graph
from src.versions import find_max_and_prev_versions, change_values, check_for_use_new_version


def process_single_instruction(row, state, parents):
    instruction = row.strip().replace(',', ' ').split()
    curr_node = make_cfg_node(instruction, state, parents)
    if not check_realisation_for_node(curr_node, row):
        return None
    return curr_node


def copy_registers_with_exec_condition(last_state, new_state):
    for reg_name in new_state.registers:
        reg = last_state.registers.get(reg_name)
        if reg is not None and reg.exec_condition is not None:
            new_state.registers[reg_name] = copy.deepcopy(reg)


def process_src_with_unresolved_instruction(set_of_instructions):
    decompiler_data = DecompilerData()
    last_node_state = decompiler_data.initial_state
    num = 0
    while num < len(set_of_instructions):
        row = set_of_instructions[num]
        instruction = row.strip().replace(',', ' ').split()
        num += 1
        curr_node = make_unresolved_node(instruction, last_node_state)
        if curr_node is None:
            decompiler_data.write(row + "\n")


def process_src(name_of_program, config_data, set_of_instructions, set_of_global_data_bytes,
                set_of_global_data_instruction):
    decompiler_data = DecompilerData()
    decompiler_data.reset(name_of_program)
    initial_set_of_instructions = copy.deepcopy(set_of_instructions)
    process_global_data(set_of_global_data_instruction, set_of_global_data_bytes)
    decompiler_data.set_config_data(config_data)
    process_kernel_params(set_of_instructions)
    last_node = Node([""], decompiler_data.initial_state)
    decompiler_data.set_cfg(last_node)

    last_before_if_and_else = []
    common_if_else_part_start_index = []
    num = 0

    if decompiler_data.flag_for_decompilation == FlagType.ONLY_CLRX:
        process_src_with_unresolved_instruction(initial_set_of_instructions)
        return
    while num < len(set_of_instructions):
        row = set_of_instructions[num]
        instruction = row.strip().replace(',', ' ').split()
        state = last_node.state
        parents = [last_node]

        if 's_and_saveexec' in instruction[0] \
                or ('s_and_b' in instruction[0] and 'exec' in instruction[1]):
            last_before_if_and_else.append([last_node])
            common_if_else_part_start_index.append(None)
        if 's_or_saveexec' in instruction[0]:
            common_if_else_part_start_index[-1] = num + 1
        if ('s_andn2' in instruction[0] or 's_xor' in instruction[0]) and \
                'exec' in instruction[1]:
            before_if = last_before_if_and_else[-1][0].children[0]
            state = before_if.state
            parents = [before_if]
            if common_if_else_part_start_index[-1] is not None:
                common_part = set_of_instructions[
                              common_if_else_part_start_index[-1]:num]
                set_of_instructions = set_of_instructions[:num + 1] + common_part + set_of_instructions[num + 1:]
            last_before_if_and_else[-1].append(last_node)
        if last_node.instruction[0] == 's_branch':
            parents = []

        last_node = process_single_instruction(row, state, parents)
        if last_node is None:
            if decompiler_data.flag_for_decompilation == FlagType.ONLY_OPENCL:
                break
            decompiler_data.flag_for_decompilation = FlagType.ONLY_CLRX
            process_src_with_unresolved_instruction(initial_set_of_instructions)
            return

        if ('s_or' in instruction[0] or 's_mov' in instruction[0]) and \
                'exec' in instruction[1] or 's_endpgm' in instruction[0]:
            end_exec_condition = last_node.state.registers["exec"].exec_condition
            while last_before_if_and_else:
                pre_and_if_last_nodes = last_before_if_and_else[-1]
                pre_exec_condition = pre_and_if_last_nodes[0].state.registers["exec"].exec_condition
                if ExecCondition.is_closing_for(end_exec_condition, pre_exec_condition):
                    parent = pre_and_if_last_nodes[0].children[0] \
                        if len(pre_and_if_last_nodes) == 1 else \
                        pre_and_if_last_nodes[1]
                    parent.add_child(last_node)
                    last_node.add_parent(parent)
                    parents.append(parent)
                    last_before_if_and_else.pop()
                    common_if_else_part_start_index.pop()
                else:
                    break
        if len(last_node.parent) > 1:
            find_max_and_prev_versions(last_node)
        num += 1

    optimize_names_of_vars()
    if decompiler_data.global_data:
        gdata_type_processing()
    check_for_use_new_version()
    decompiler_data.remove_unusable_versions()

    make_region_graph_from_cfg()
    process_region_graph()
    if decompiler_data.checked_variables != {} or decompiler_data.variables != {}:
        change_values()
    create_opencl_body()
