import copy

from src.node import Node
from src.node_processor import to_opencl
from src.operation_status import OperationStatus


def make_cfg_node(instruction, state, parents):
    for i, instr in enumerate(instruction):
        if instr == "vcc_lo":
            instruction[i] = "vcc"
        if instr == "exec_lo":
            instruction[i] = "exec"
    node = Node(instruction, copy.deepcopy(state))
    for parent in parents:
        node.parent.append(parent)
        parent.add_child(node)
    return to_opencl(node, OperationStatus.TO_FILL_NODE)


def make_unresolved_node(instruction, last_node_state):
    node = Node(instruction, last_node_state)
    return to_opencl(node, OperationStatus.TO_PRINT_UNRESOLVED)
