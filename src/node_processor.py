import copy
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus
from src.instruction_dict import instruction_dict


def check_realisation_for_node(curr_node, row):
    decompiler_data = DecompilerData()
    if curr_node is None:  # check of node
        decompiler_data.write("Not resolved yet. " + row + "\n")
        # for instr in set_of_instructions:
        #     decompiler_data.write(instr + "\n")
        return False
    return True


def process_label_node(node, flag_of_status):
    decompiler_data = DecompilerData()
    if flag_of_status == OperationStatus.to_fill_node:
        decompiler_data.set_to_node(node.instruction[0][:-1], node)
        if decompiler_data.from_node.get(node.instruction[0][:-1]) is not None:
            for wait_node in decompiler_data.from_node[node.instruction[0][:-1]]:
                if node not in wait_node.children:
                    if 'scc1' not in wait_node.instruction[0]:
                        wait_node.add_child(node)
                    else:
                        wait_node.add_first_child(node)
                    node.add_parent(wait_node)
                    node.state = copy.deepcopy(node.parent[-1].state)

        return node
    if flag_of_status == OperationStatus.to_print_unresolved:
        decompiler_data.write(node.instruction[0])
        return node
    return ""


def decode_instruction(node, flag_of_status):
    instruction = node.instruction
    operation = instruction[0]
    parts_of_operation = operation.split('_')
    prefix = parts_of_operation[0]
    suffix = ""
    root = parts_of_operation[1]
    if len(parts_of_operation) >= 3:
        for part in parts_of_operation[2:]:
            if part in ["b32", 'b64', "u32", "u64", "i32", "i64", "dwordx4", "dwordx2", "dword", "f32",
                        "f64", "i32", "i24", "byte", "dwordx8"]:
                # TODO: Дописать
                if suffix != "":
                    suffix = suffix + "_" + part
                else:
                    suffix = part
            else:
                root = root + "_" + part
    prefix_root = prefix + "_" + root
    return_value = None
    if instruction_dict.get(prefix_root):
        return_value = instruction_dict[prefix_root].execute(node, instruction, flag_of_status, suffix)
    elif instruction_dict.get(node.instruction[0]):
        return_value = instruction_dict[node.instruction[0]].execute(node, instruction, flag_of_status, suffix)
    return return_value


def to_opencl(node, flag_of_status):
    output_string = ""
    if node.instruction[0][0] == ".":
        return process_label_node(node, flag_of_status)
    if node.instruction == "branch":
        return output_string
    return decode_instruction(node, flag_of_status)
