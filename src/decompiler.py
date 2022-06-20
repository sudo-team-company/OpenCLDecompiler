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
from src.utils import DriverFormat
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


def transform_rocm_branching(set_of_instructions):
    if DecompilerData().driver_format != DriverFormat.ROCM:
        return set_of_instructions

    markers = [x for x in set_of_instructions if x.startswith("s_and_saveexec_b32 ")]

    if len(markers) == 0 or len(markers) > 1:
        return set_of_instructions
    try:
        s_and_saveexec_b32: str = markers[0]
        _, reg, src = s_and_saveexec_b32.strip().replace(",", " ").split()

        i_if = set_of_instructions.index(f"s_and_saveexec_b32 {reg}, {src}")  # start of "if"
        assert set_of_instructions[i_if - 1].startswith("v_cmp")
        i___ = set_of_instructions.index(f"s_xor_b32       {reg}, exec_lo, {reg}")
        assert i_if + 1 == i___
        i_same = set_of_instructions.index(f"s_or_saveexec_b32 {reg}, {reg}")  # start of same part
        assert i___ < i_same
        i_else = set_of_instructions.index(f"s_xor_b32       exec_lo, exec_lo, {reg}")  # start of else
        assert i_same < i_else
        i_end = set_of_instructions.index(f"s_or_b32        exec_lo, exec_lo, {reg}")  # finish else
        assert i_else < i_end

        label = f"BL{i_if}"
        before_block = set_of_instructions[:i___ + 1]
        if_block = set_of_instructions[i___ + 1:i_else + 1]
        else_block = set_of_instructions[i_same + 1:i_else] + set_of_instructions[i_else + 1:i_end]
        after_block = set_of_instructions[i_end:]

        cmp: str = set_of_instructions[i_if - 1]
        if cmp.startswith("v_cmp_lg_u32    vcc, "):
            _, s0, s1 = cmp.split(", ")
            cmp = f"s_cmp_lg_u32 {s0}, {s1}"
            if s0.isdigit():
                cmp = f"s_cmp_lg_u32 {s1}, {s0}"
        else:
            assert False

        return \
            before_block + [
                cmp,
                f"s_cbranch_scc0  .{label}_1"
            ] + if_block + [
                f"s_branch        .{label}_0",
                f".{label}_1:"
            ] + else_block + [
                f".{label}_0:"
            ] + after_block
    except ValueError:
        pass
    except AssertionError:
        pass
    return set_of_instructions


def process_src(name_of_program, config_data, set_of_instructions, set_of_global_data_bytes,
                set_of_global_data_instruction):
    decompiler_data = DecompilerData()
    decompiler_data.reset(name_of_program)
    initial_set_of_instructions = copy.deepcopy(set_of_instructions)
    set_of_instructions = transform_rocm_branching(set_of_instructions)
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
