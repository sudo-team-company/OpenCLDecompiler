from src.decompiler_data import DecompilerData
from src.expression_manager.expression_manager import ExpressionManager
from src.opencl_types import make_opencl_type


def get_gdata_offset(instruction):
    position = instruction.find("(.gdata+")
    if position == -1:
        return 0
    end_position = instruction.find(")", position)
    return int(instruction[position + 8 : end_position])


def gdata_type_processing():
    decompiler_data = DecompilerData()
    # evaluate gdata type
    for key, val in decompiler_data.names_of_vars.items():
        if "g" in val:
            val = val[1:]  # noqa: PLW2901
        if "gdata" in key:
            decompiler_data.type_gdata[key] = make_opencl_type(val)
        elif "var" in key and key in decompiler_data.var_value:
            name = decompiler_data.var_value[key]
            ExpressionManager().update_variable_type(
                name, ExpressionManager().get_variable_info(key).var_node.value_type_hint
            )
            decompiler_data.type_gdata[name] = make_opencl_type(val)
        decompiler_data.names_of_vars[key] = val
    tmp = {}
    # remove gdata from names_of_vars
    for key in decompiler_data.names_of_vars:
        if "gdata" not in key:
            tmp[key] = decompiler_data.names_of_vars[key]
    decompiler_data.names_of_vars = tmp


def process_global_data(set_of_global_data_instruction, set_of_global_data_bytes):
    decompiler_data = DecompilerData()
    indexes = set()
    for instruction in sorted(set_of_global_data_instruction):
        offset = get_gdata_offset(instruction)
        indexes.add(offset)
        decompiler_data.type_gdata["gdata" + str(offset)] = "undefined_type"
    list_of_indexes = sorted(indexes)
    list_of_indexes.append(-1)
    for index in range(len(list_of_indexes) - 1):
        decompiler_data.global_data["gdata" + str(list_of_indexes[index])] = set_of_global_data_bytes[
            list_of_indexes[index] : list_of_indexes[index + 1]
        ]
