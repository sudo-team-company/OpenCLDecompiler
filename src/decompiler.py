import copy
from src.regions.functions_for_regions import make_region_graph_from_cfg, process_region_graph
from src.node import Node
from src.node_processor import check_realisation_for_node
from src.decompiler_data import DecompilerData
from src.cfg import change_cfg_for_else_structure, make_cfg_node
from src.code_printer import create_opencl_body
from src.config import process_config
from src.versions import find_max_and_prev_versions, remove_unusable_versions, change_values, check_for_use_new_version
from src.kernel_params import process_kernel_params


def transform_instruction_set(instruction, set_of_instructions, num, row, curr_node):
    decompiler_data = DecompilerData()
    if "s_and_saveexec_b64" in instruction[0] \
            and ("branch" not in set_of_instructions[num + 1]
                 and "branch" not in set_of_instructions[num + 2]
                 and "branch" not in set_of_instructions[num + 3]):
        decompiler_data.num_of_label += 1
        set_of_instructions.insert(num + 1, "s_cbranch_execz ." + str(decompiler_data.num_of_label))
    if 'andn2' in instruction[0] and "." not in set_of_instructions[num - 1]:
        set_of_instructions.insert(num + 1, row)
        new_val = "." + str(decompiler_data.num_of_label) + ":"
        set_of_instructions[num] = new_val
        instruction = [new_val]
    if "andn2" in instruction[0] \
            and ("cbranch" not in set_of_instructions[num + 1]
                 and "cbranch" not in set_of_instructions[num + 2]):
        decompiler_data.num_of_label += 1
        set_of_instructions.insert(num + 1, "s_cbranch_execz ." + str(decompiler_data.num_of_label))
    if instruction[0] == "s_mov_b64" and instruction[1] == "exec" and "." not in curr_node.instruction[0]:
        set_of_instructions.insert(num + 1, row)
        instruction = ["." + str(decompiler_data.num_of_label) + ":"]
    return set_of_instructions, instruction


def check_instruction_set_for_if_else(instruction, curr_node, set_of_instructions,
                                      num, row, last_node, last_node_state):
    decompiler_data = DecompilerData()
    if instruction[0][0] == ".":
        decompiler_data.label = curr_node
        decompiler_data.parents_of_label = curr_node.parent
        decompiler_data.flag_of_else = True
    elif ("andn2" in instruction[0] or
          (num < len(set_of_instructions) and "branch" in set_of_instructions[num])) \
            and decompiler_data.flag_of_else:
        if "andn2" not in instruction[0] and "branch" in set_of_instructions[num]:
            set_of_instructions.insert(num + 1, row)
        return set_of_instructions, last_node, last_node_state
    elif decompiler_data.flag_of_else and "cbranch" in instruction[0]:
        last_node, last_node_state = change_cfg_for_else_structure(curr_node, instruction)
    else:
        decompiler_data.flag_of_else = False
    return set_of_instructions, last_node, last_node_state


def process_single_instruction(set_of_instructions, num, curr_node, last_node_state, last_node):
    decompiler_data = DecompilerData()
    row = set_of_instructions[num]
    instruction = row.strip().replace(',', ' ').split()
    set_of_instructions, instruction = transform_instruction_set(instruction, set_of_instructions, num, row, curr_node)
    curr_node = make_cfg_node(instruction, last_node_state, last_node)
    num += 1
    if not check_realisation_for_node(curr_node, row, set_of_instructions):
        return None
    last_node_state = copy.deepcopy(curr_node.state)
    if last_node is not None and last_node.instruction != "branch" and curr_node not in last_node.children:
        last_node.add_child(curr_node)
    last_node = curr_node
    if last_node is not None and last_node.instruction == "branch":
        last_node_state = copy.deepcopy(decompiler_data.initial_state)
    set_of_instructions, last_node, last_node_state = \
        check_instruction_set_for_if_else(instruction, curr_node, set_of_instructions,
                                          num, row, last_node, last_node_state)
    if instruction[0][0] == "." and len(curr_node.parent) > 1:
        last_node_state = find_max_and_prev_versions(curr_node)
    return num, curr_node, set_of_instructions, last_node, last_node_state


def process_src(name_of_program, set_of_config, set_of_instructions):
    decompiler_data = DecompilerData()
    process_config(set_of_config, name_of_program)
    process_kernel_params(set_of_instructions)
    last_node = Node([""], decompiler_data.initial_state)
    curr_node = last_node
    last_node_state = decompiler_data.initial_state
    decompiler_data.cfg = last_node
    num = 0
    while num < len(set_of_instructions):
        result_for_check = process_single_instruction(set_of_instructions, num, curr_node, last_node_state, last_node)
        if result_for_check is not None:
            num, curr_node, set_of_instructions, last_node, last_node_state = result_for_check
        else:
            return

    check_for_use_new_version()
    remove_unusable_versions()
    if decompiler_data.checked_variables != {} or decompiler_data.variables != {}:
        change_values()
    make_region_graph_from_cfg()
    process_region_graph()
    create_opencl_body()
