import copy

from src.cfg import make_cfg_node, make_unresolved_node
from src.code_printer import create_opencl_body
from src.decompiler_data import DecompilerData, optimize_names_of_vars
from src.flag_type import FlagType
from src.global_data import process_global_data, gdata_type_processing
from src.kernel_params import process_kernel_params
from src.node import Node
from src.node_processor import check_realisation_for_node
from src.regions.functions_for_regions import make_region_graph_from_cfg, process_region_graph
from src.versions import find_max_and_prev_versions, change_values, check_for_use_new_version


def process_single_instruction(row ,state, parents):
    instruction = row.strip().replace(',', ' ').split()
    curr_node = make_cfg_node(instruction, state)
    if not check_realisation_for_node(curr_node, row):
        return None
    for parent in parents:
        curr_node.parent.append(parent)
        parent.add_child(curr_node)
    if len(curr_node.parent) > 1:
        find_max_and_prev_versions(curr_node)
    return curr_node


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
        # result_for_check = process_single_instruction(set_of_instructions, num, curr_node, last_node_state, last_node)


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

    branch = []
    saveexec = []
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

        if 's_or_saveexec' in instruction[0]:
            common_if_else_part_start_index[-1] = num + 1
        elif ('s_andn2' in instruction[0] or 's_xor' in instruction[0]) and \
                'exec' in instruction[1]:
            temp = saveexec.pop()
            state = temp.state
            parents = [temp]
            if 's_xor' in instruction[0]:
                common_part = set_of_instructions[
                              common_if_else_part_start_index[-1]:num]
                set_of_instructions = set_of_instructions[:num + 1] + common_part + set_of_instructions[num + 1:]
            saveexec.append(last_node)
        elif ('s_or' in instruction[0] or 's_mov' in instruction[0]) and \
                'exec' in instruction[1]:
            common_if_else_part_start_index.pop()
            parents = [last_node, saveexec.pop()]
        elif instruction[0][0] == '.' and len(branch) > 0:
            label = instruction[0][:-1]
            if branch[-1].instruction[1] == label:
                branch_top = branch.pop()
                parents = [last_node, branch_top]
                state = branch_top.state
                if branch_top.instruction[0] == 's_branch':
                    assert len(branch) >= 1
                    branch.pop()
            else:
                assert 's_branch' in set_of_instructions[num - 1]
                assert branch[-1].instruction[1] in set_of_instructions[num - 1]
                assert len(branch) >= 2
                assert branch[-2].instruction[1] == label
                parents = [branch[-2]]
                state = branch[-2].state

        last_node = process_single_instruction(row, state, parents)
        if last_node is None:
            if decompiler_data.flag_for_decompilation == FlagType.ONLY_OPENCL:
                break
            decompiler_data.flag_for_decompilation = FlagType.ONLY_CLRX
            process_src_with_unresolved_instruction(initial_set_of_instructions)
            return

        if 's_and_saveexec' in instruction[0]:
            saveexec.append(last_node)
            common_if_else_part_start_index.append(None)
        elif 'branch' in instruction[0] and 'execz' not in instruction[0]:
            branch.append(last_node)

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
