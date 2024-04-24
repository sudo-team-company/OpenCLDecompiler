import copy

from src.cfg import make_cfg_node, make_unresolved_node
from src.code_printer import create_opencl_body
from src.decompiler_data import DecompilerData, optimize_names_of_vars
from src.flag_type import FlagType
from src.global_data import process_global_data, gdata_type_processing
from src.graph.control_flow_graph import ControlFlowGraph, CONTROL_FLOW_GRAPH_ENABLED_CONTEXT_KEY
from src.kernel_params import process_kernel_params
from src.logical_variable import ExecCondition
from src.node import Node
from src.node_processor import check_realisation_for_node
from src.regions.functions_for_regions import make_region_graph_from_cfg, process_region_graph
from src.unrolled_loops_processing import process_unrolled_loops
from src.utils import get_context
from src.versions import find_max_and_prev_versions, change_values, check_for_use_new_version

CONTEXT = get_context()


def process_single_instruction(row, state, parents):
    instruction = row.strip().replace(',', ' ').split()
    curr_node = make_cfg_node(instruction, state, parents)
    if not check_realisation_for_node(curr_node, row):
        return None
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


def process_src(  # pylint: disable=R0914
        name_of_program,
        config_data,
        set_of_instructions,
        set_of_global_data_bytes,
        set_of_global_data_instruction,
        *,
        is_rdna3: bool = False,
):
    decompiler_data = DecompilerData()
    decompiler_data.reset(name_of_program)
    if is_rdna3:
        decompiler_data.is_rdna3 = True
    set_of_instructions = [instr.replace("null", "0x0") for instr in set_of_instructions]
    new_set_of_instructions = []
    for instr in set_of_instructions:
        new_set_of_instructions.extend([
            new_instr.strip()
            for new_instr
            in instr.split("::")
        ])
    set_of_instructions = new_set_of_instructions
    initial_set_of_instructions = copy.deepcopy(set_of_instructions)
    process_global_data(set_of_global_data_instruction, set_of_global_data_bytes)
    decompiler_data.set_config_data(config_data)
    if not decompiler_data.is_rdna3:
        process_kernel_params()
    last_node = Node([""], decompiler_data.initial_state)
    decompiler_data.set_cfg(last_node)

    if_and_last_in_if_body_nodes = []
    common_if_else_part_start_index = []
    num = 0

    if decompiler_data.flag_for_decompilation == FlagType.ONLY_CLRX:
        process_src_with_unresolved_instruction(initial_set_of_instructions)
        return
    while num < len(set_of_instructions):
        row = set_of_instructions[num]
        row = row.replace("_e32", "")
        row = row.replace("_e64", "")
        instruction = row.strip().replace(',', ' ').split()
        state = last_node.state
        parents = [last_node]

        if 's_or_saveexec' in instruction[0]:
            common_if_else_part_start_index[-1] = num + 1
        if ('s_andn2' in instruction[0] or 's_xor' in instruction[0]) \
                and 'exec' in instruction[1]:
            if_node = if_and_last_in_if_body_nodes[-1][0]
            state = if_node.state
            parents = [if_node]
            if common_if_else_part_start_index[-1] is not None:
                common_part = set_of_instructions[
                              common_if_else_part_start_index[-1]:num]
                set_of_instructions = set_of_instructions[:num + 1] \
                                      + common_part \
                                      + set_of_instructions[num + 1:]
            if_and_last_in_if_body_nodes[-1].append(last_node)
        if last_node.instruction[0] == 's_branch':
            parents = []

        last_node = process_single_instruction(row, state, parents)
        if last_node is None:
            if decompiler_data.flag_for_decompilation == FlagType.ONLY_OPENCL:
                break
            decompiler_data.flag_for_decompilation = FlagType.ONLY_CLRX
            process_src_with_unresolved_instruction(initial_set_of_instructions)
            return

        if 's_and_saveexec' in instruction[0] or \
                ('s_and_b' in instruction[0] and 'exec' in instruction[1]):
            if_and_last_in_if_body_nodes.append([last_node])
            common_if_else_part_start_index.append(None)
        if ('s_or' in instruction[0] or 's_mov' in instruction[0]) and \
                'exec' in instruction[1] or 's_endpgm' in instruction[0]:
            end_exec_condition = last_node.state.registers["exec"] \
                .exec_condition
            while if_and_last_in_if_body_nodes and \
                    ExecCondition.is_closing_for(
                        end_exec_condition,
                        if_and_last_in_if_body_nodes[-1][0] \
                                .state.registers["exec"].exec_condition):
                if_and_last_in_if_nodes = if_and_last_in_if_body_nodes[-1]
                parent = if_and_last_in_if_nodes[0] \
                    if len(if_and_last_in_if_nodes) == 1 else \
                    if_and_last_in_if_nodes[1]
                parent.add_child(last_node)
                last_node.add_parent(parent)
                if_and_last_in_if_body_nodes.pop()
                common_if_else_part_start_index.pop()
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
    if CONTEXT.get(CONTROL_FLOW_GRAPH_ENABLED_CONTEXT_KEY):
        control_flow_graph = ControlFlowGraph.instance()
        for node in decompiler_data.starts_regions:
            control_flow_graph.build_from_node(
                node=node,
                program_name=decompiler_data.name_of_program,
                program_id=decompiler_data.pragram_id,
            )
        control_flow_graph.render()
    if decompiler_data.checked_variables != {} or decompiler_data.variables != {}:
        change_values()
    process_unrolled_loops()
    create_opencl_body()
