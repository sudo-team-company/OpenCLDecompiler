import copy

from src.decompiler_data import DecompilerData
from src.instruction_dict import instruction_dict
from src.operation_status import OperationStatus


def check_realisation_for_node(curr_node, row):
    decompiler_data = DecompilerData()
    if curr_node is None:  # check of node
        decompiler_data.write("Not resolved yet. " + row + "\n")
        return False
    return True


def process_label_node(node, flag_of_status):
    decompiler_data = DecompilerData()
    if flag_of_status == OperationStatus.TO_FILL_NODE:
        return node
    if flag_of_status == OperationStatus.TO_PRINT_UNRESOLVED:
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
            if part in ["b16", "b32", 'b64',
                        "u8", "u16", "u24", "u32", "u64",
                        "i4", "i16", "i24", "i32", "i64",
                        "f16", "f32", "f64",
                        "byte", "ubyte", "ubyte0", "ubyte1", "ubyte2", "ubyte3", "sbyte",
                        "ushort", "sshort", "short",
                        "dword", "dwordx2", "dwordx4", "dwordx8", "dwordx16"]:
                if suffix != "":
                    suffix = suffix + "_" + part
                else:
                    suffix = part
            else:
                root = root + "_" + part
    prefix_root = prefix + "_" + root
    return_value = None
    if instruction_dict.get(prefix_root):
        return_value = instruction_dict[prefix_root](node, suffix).execute(flag_of_status)
    elif instruction_dict.get(node.instruction[0]):
        return_value = instruction_dict[node.instruction[0]](node, suffix).execute(flag_of_status)
    return return_value


def to_opencl(node, flag_of_status):
    if node.instruction[0][0] == ".":
        return process_label_node(node, flag_of_status)
    return decode_instruction(node, flag_of_status)
