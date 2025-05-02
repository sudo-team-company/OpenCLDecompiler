from src.decompiler_data import DecompilerData, evaluate_from_hex
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import ExpressionNode
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.node import Node
from src.node_processor import to_opencl
from src.operation_status import OperationStatus
from src.region_type import RegionType
from src.regions.region import Region
from src.register import is_reg


def create_opencl_body():
    decompiler_data = DecompilerData()
    write_global_data()
    decompiler_data.write(decompiler_data.get_function_definition())
    decompiler_data.write("{\n")
    for var in sorted(decompiler_data.names_of_vars.keys()):
        if " " not in var:
            if "___" in var:
                var = var[: var.find("___")]  # noqa: PLW2901
            var_info = ExpressionManager().get_variable_info(var)
            type_of_var = str(var_info.var_node.value_type_hint)
            if type_of_var[-1] != "*":
                type_of_var += " "
            decompiler_data.write("    " + type_of_var + var + ";\n")
    offsets = list(decompiler_data.lds_vars.keys())
    offsets.append(decompiler_data.config_data.local_size)
    offsets.sort()
    for key in range(len(offsets) - 1):
        lds_var_node: ExpressionNode = decompiler_data.lds_vars[offsets[key]]
        size_var = int((offsets[key + 1] - offsets[key]) / (lds_var_node.value_type_hint.size_bytes()))
        type_of_var = lds_var_node.value_type_hint.to_string(False)  # noqa: FBT003
        decompiler_data.write(
            "    "
            + type_of_var
            + " "
            + lds_var_node.value
            + "["
            + str(size_var)
            + "]"
            + ";\n"
        )
    make_output_from_region(decompiler_data.improve_cfg, "    ")
    decompiler_data.write("}\n")


def write_global_data():  # noqa: PLR0912
    decompiler_data = DecompilerData()
    expression_manager = ExpressionManager()
    for key, var in sorted(decompiler_data.type_gdata.items()):
        if var in {"uint", "int"}:
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 4, "<i")
        elif var in {"ulong", "long"}:
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 8, "<q")
        elif var == "float":
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 4, "<f")
        elif var == "double":
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 8, "<d")
        elif var in {"int2", "int4", "int8"}:
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 4, "<i")
        else:
            raise NotImplementedError
        var_info = expression_manager.get_variable_info(key)
        decompiler_data.write(var_info.var_node.value_type_hint.to_string(False) + " " + var_info.name + "[] = {")
        if var in {"int2", "int4", "int8"}:
            num = int(var[-1])
            for index, element in enumerate(list_of_gdata_values):
                if index == 0:
                    decompiler_data.write("(" + var + ")(")
                    decompiler_data.write(element)
                elif index % num == 0:
                    decompiler_data.write(", (" + var + ")(")
                    decompiler_data.write(element)
                elif index % num == num - 1:
                    decompiler_data.write(", " + element)
                    decompiler_data.write(")")
                else:
                    decompiler_data.write(", " + element)
        else:
            for index, element in enumerate(list_of_gdata_values):
                if index:
                    decompiler_data.write(", " + element)
                else:
                    decompiler_data.write(element)
        decompiler_data.write("};\n\n")


def make_output_for_loop_vars(curr_node, indent):
    decompiler_data = DecompilerData()
    expression_manager = ExpressionManager()
    key = decompiler_data.loops_nodes_for_variables[curr_node]
    reg = key[: key.find("_")]
    loop_variable = decompiler_data.loops_variables[key]
    loop_variable_node = expression_manager.get_variable_node(loop_variable)
    decompiler_data.write(indent
                          + loop_variable + " = "
                          + expression_manager.expression_to_string(
                              curr_node.state[reg].get_expression_node(),
                              loop_variable_node.value_type_hint)
                          + ";\n")


def make_output_for_linear_region(region, indent):
    decompiler_data = DecompilerData()
    expression_manager = ExpressionManager()
    if isinstance(region.start, Node):
        curr_node = decompiler_data.cfg.children[0] if region.start == decompiler_data.cfg else region.start
        while True:
            new_output = to_opencl(curr_node, OperationStatus.TO_PRINT)
            if decompiler_data.loops_nodes_for_variables.get(curr_node):
                make_output_for_loop_vars(curr_node, indent)
            elif new_output:
                decompiler_data.write(indent + new_output + ";\n")
            if (
                len(curr_node.instruction) > 1
                and is_reg(curr_node.instruction[1])
                and not decompiler_data.loops_nodes_for_variables.get(curr_node)
            ):
                reg = curr_node.instruction[1]

                version = curr_node.state[reg].version
                var = decompiler_data.variables.get(version)
                if (
                    var is not None
                    and var != curr_node.state[reg].val
                    and curr_node.state[reg].val.strip()
                    and (
                        "cmp" not in curr_node.instruction[0]
                        or (decompiler_data.gpu and decompiler_data.gpu.startswith("gfx"))
                    )
                ):  # версия поменялась по сравнению с предком
                    # decompiler_data.write(indent + var + " = " + curr_node.state[reg].val + ";\n")
                    value_type_hint = expression_manager.get_variable_node(var).value_type_hint
                    value_type_hint.opencl_type = OpenCLTypes.UNKNOWN
                    decompiler_data.write(indent
                                          + var
                                          + " = "
                                          + expression_manager.expression_to_string(
                                              curr_node.state[reg].get_expression_node(),
                                              value_type_hint)
                                          + ";\n")
            if curr_node == region.end:
                break
            child = curr_node.children[0]
            if isinstance(child, Region) and child.type == RegionType.UNROLLED_LOOP:
                before, first, last, diff, inside = child.start
                decompiler_data.write(f"    int acc = {before};\n")
                sign = "<=" if first < last else ">="
                decompiler_data.write(f"    for (int i = {first}; i {sign} {last}; {diff}) {{\n")
                decompiler_data.write(f"        acc = {inside};\n")
                decompiler_data.write("    }\n")
                curr_node = curr_node.children[1]
                continue
            curr_node = child
    else:
        curr_region = region.start
        make_output_from_region(curr_region, indent)
        while curr_region != region.end:
            curr_region = curr_region.children[0]
            make_output_from_region(curr_region, indent)


def make_output_from_part_of_if_else(region, indent, num_of_branch):
    branch_body = region.start.children[num_of_branch]
    make_output_from_region(branch_body, indent + "    ")


def make_output_from_if_statement_region(region, indent):
    decompiler_data = DecompilerData()
    decompiler_data.write(indent + "if (")
    decompiler_data.write(to_opencl(region.start.start, OperationStatus.TO_PRINT))
    decompiler_data.write(") {\n")
    make_output_from_part_of_if_else(region, indent, 0)
    decompiler_data.write(indent + "}\n")


def make_output_from_if_else_statement_region(region, indent):
    decompiler_data = DecompilerData()
    make_output_from_if_statement_region(region, indent)
    decompiler_data.write(indent + "else {\n")
    make_output_from_part_of_if_else(region, indent, 1)
    decompiler_data.write(indent + "}\n")


def make_output_from_loop_region(region, indent):
    decompiler_data = DecompilerData()
    decompiler_data.write(indent + "do {\n")
    make_output_from_region(region.start.children[0], indent + "    ")
    decompiler_data.write(indent + "} while (")
    statement = to_opencl(region.end.start, OperationStatus.TO_PRINT)
    if "scc0" in region.end.start.instruction[0]:
        statement = "!(" + statement + ")"
    decompiler_data.write(statement)
    decompiler_data.write(");\n")


def make_output_from_break_region(region, indent):
    decompiler_data = DecompilerData()
    break_node = region.start
    decompiler_data.write(indent + "if (")
    statement = to_opencl(break_node, OperationStatus.TO_PRINT)
    if break_node.instruction[0][-4:] in {"scc0", "vccz"}:
        statement = "!(" + statement + ")"
    decompiler_data.write(statement)
    decompiler_data.write(") {\n")
    decompiler_data.write(indent + "    break;\n")
    decompiler_data.write(indent + "}\n")


def make_output_from_region(region, indent):
    decompiler_data = DecompilerData()
    if region.type == RegionType.LINEAR:
        make_output_for_linear_region(region, indent)
    elif region.type == RegionType.IF_STATEMENT:
        make_output_from_if_statement_region(region, indent)
    elif region.type == RegionType.IF_ELSE_STATEMENT:
        make_output_from_if_else_statement_region(region, indent)
    elif region.type == RegionType.LOOP:
        make_output_from_loop_region(region, indent)
    elif region.type == RegionType.CONTINUE_REGION:
        decompiler_data.write(indent + "continue;\n")
    elif region.type == RegionType.BREAK_REGION:
        make_output_from_break_region(region, indent)
    elif region.type == RegionType.RETURN_REGION:
        decompiler_data.write(indent + "return;\n")
