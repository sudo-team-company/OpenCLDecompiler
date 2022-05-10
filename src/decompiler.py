import copy

from src.cfg import change_cfg_for_else_structure, make_cfg_node, make_unresolved_node
from src.code_printer import create_opencl_body
from src.decompiler_data import DecompilerData, optimize_names_of_vars
from src.flag_type import FlagType
from src.global_data import process_global_data, gdata_type_processing
from src.kernel_params import process_kernel_params
from src.node import Node
from src.node_processor import check_realisation_for_node
from src.regions.functions_for_regions import make_region_graph_from_cfg, process_region_graph
from src.versions import find_max_and_prev_versions, change_values, check_for_use_new_version


def transform_instruction_set(instruction, set_of_instructions, num, row, curr_node):
    decompiler_data = DecompilerData()
    if "s_and_saveexec_b64" in instruction[0] \
            and ("branch" not in set_of_instructions[num + 1]
                 and "branch" not in set_of_instructions[num + 2]
                 and "branch" not in set_of_instructions[num + 3]):
        decompiler_data.increase_num_of_label()
        set_of_instructions.insert(num + 1, "s_cbranch_execz ." + str(decompiler_data.num_of_label))
    if 'andn2' in instruction[0] and "." not in set_of_instructions[num - 1]:
        set_of_instructions.insert(num + 1, row)
        new_val = "." + str(decompiler_data.num_of_label) + ":"
        set_of_instructions[num] = new_val
        instruction = [new_val]
    if "andn2" in instruction[0] \
            and ("cbranch" not in set_of_instructions[num + 1]
                 and "cbranch" not in set_of_instructions[num + 2]):
        decompiler_data.increase_num_of_label()
        set_of_instructions.insert(num + 1, "s_cbranch_execz ." + str(decompiler_data.num_of_label))
    if instruction[0] == "s_mov_b64" and instruction[1] == "exec" and "." not in curr_node.instruction[0]:
        set_of_instructions.insert(num + 1, row)
        instruction = ["." + str(decompiler_data.num_of_label) + ":"]
    return set_of_instructions, instruction


def check_instruction_set_for_if_else(curr_node, set_of_instructions, num, last_node, last_node_state):
    decompiler_data = DecompilerData()
    instruction = curr_node.instruction
    row = set_of_instructions[num - 1]
    if instruction[0][0] == ".":
        decompiler_data.make_label(curr_node)
    elif "andn2" in instruction[0]:
        decompiler_data.set_flag_of_else(True)
    elif num < len(set_of_instructions) and "andn2" not in instruction[0] \
            and "cbranch" in set_of_instructions[num] and decompiler_data.flag_of_else:
        set_of_instructions.insert(num + 1, row)
    elif decompiler_data.flag_of_else and "cbranch" in instruction[0]:
        last_node, last_node_state = change_cfg_for_else_structure(curr_node, instruction)
    else:
        decompiler_data.set_flag_of_else(False)
    return set_of_instructions, last_node, last_node_state


def process_single_instruction(set_of_instructions, num, curr_node, last_node_state, last_node):
    decompiler_data = DecompilerData()
    row = set_of_instructions[num]
    instruction = row.strip().replace(',', ' ').split()
    set_of_instructions, instruction = transform_instruction_set(instruction, set_of_instructions, num, row, curr_node)
    curr_node = make_cfg_node(instruction, last_node_state, last_node)
    num += 1
    if not check_realisation_for_node(curr_node, row):
        return None
    last_node_state = copy.deepcopy(curr_node.state)
    if last_node is not None and last_node.instruction != "branch" and curr_node not in last_node.children:
        last_node.add_child(curr_node)
    last_node = curr_node
    if last_node is not None and last_node.instruction == "branch":
        last_node_state = copy.deepcopy(decompiler_data.initial_state)
    set_of_instructions, last_node, last_node_state = \
        check_instruction_set_for_if_else(curr_node, set_of_instructions, num, last_node, last_node_state)
    if instruction[0][0] == "." and len(curr_node.parent) > 1:
        last_node_state = find_max_and_prev_versions(curr_node)
    return num, curr_node, set_of_instructions, last_node, last_node_state


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
    curr_node = last_node
    last_node_state = decompiler_data.initial_state
    decompiler_data.set_cfg(last_node)
    num = 0
    if decompiler_data.flag_for_decompilation == FlagType.ONLY_CLRX:
        process_src_with_unresolved_instruction(initial_set_of_instructions)
        return
    while num < len(set_of_instructions):
        result_for_check = process_single_instruction(set_of_instructions, num, curr_node, last_node_state, last_node)
        if result_for_check is not None:
            num, curr_node, set_of_instructions, last_node, last_node_state = result_for_check
        else:
            if decompiler_data.flag_for_decompilation == FlagType.ONLY_OPENCL:
                break
            decompiler_data.flag_for_decompilation = FlagType.ONLY_CLRX
            process_src_with_unresolved_instruction(initial_set_of_instructions)
            return

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
