import copy

from src.decompiler_data import DecompilerData
from src.node import Node
from src.node_processor import to_opencl
from src.operation_status import OperationStatus


def make_cfg_node(instruction, state):
    for i, instr in enumerate(instruction):
        if instr == "vcc_lo":
            instruction[i] = "vcc"
        if instr == "exec_lo":
            instruction[i] = "exec"
    node = Node(instruction, copy.deepcopy(state))
    return to_opencl(node, OperationStatus.TO_FILL_NODE)


def make_unresolved_node(instruction, last_node_state):
    node = Node(instruction, last_node_state)
    return to_opencl(node, OperationStatus.TO_PRINT_UNRESOLVED)


def change_cfg_for_else_structure(curr_node, instruction):
    decompiler_data = DecompilerData()
    for parents_of_label in decompiler_data.parents_of_label:
        parents_of_label.children.remove(decompiler_data.label)
    last_node = decompiler_data.parents_of_label[1]
    last_node_state = copy.deepcopy(decompiler_data.parents_of_label[1].state)
    from_node = instruction[1]
    decompiler_data.change_cfg_for_else_structure(instruction, curr_node, from_node)
    return last_node, last_node_state
