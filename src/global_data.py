from src.decompiler_data import DecompilerData
from src.expression_manager.expression_manager import ExpressionManager
from src.opencl_types import make_opencl_type


def gdata_type_processing():
    decompiler_data = DecompilerData()
    expression_manager = ExpressionManager()

    for key, raw_val in list(decompiler_data.names_of_vars.items()):
        val = raw_val.removeprefix("g")
        if "__gdata" in key:
            decompiler_data.type_gdata[key] = make_opencl_type(val)
        elif "var" in key and key in decompiler_data.var_value:
            name = decompiler_data.var_value[key]
            var_info = expression_manager.get_variable_info(key)
            if var_info is not None:
                expression_manager.update_variable_type(name, var_info.var_node.value_type_hint)
            decompiler_data.type_gdata[name] = make_opencl_type(val)
        decompiler_data.names_of_vars[key] = val

    decompiler_data.names_of_vars = {
        key: val for key, val in decompiler_data.names_of_vars.items() if "__gdata" not in key
    }
