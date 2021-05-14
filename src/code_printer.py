from src.decompiler_data import DecompilerData, evaluate_from_hex
from src.node import Node
from src.node_processor import to_opencl
from src.opencl_types import make_type
from src.operation_status import OperationStatus
from src.type_of_node import TypeNode


def create_opencl_body():
    decompiler_data = DecompilerData()
    write_global_data()
    decompiler_data.write(decompiler_data.configuration_output)
    decompiler_data.write("{\n")
    for var in sorted(decompiler_data.names_of_vars.keys()):
        type_of_var = make_type(decompiler_data.names_of_vars[var])
        decompiler_data.write("    " + type_of_var + " " + var + ";\n")
    offsets = list(decompiler_data.lds_vars.keys())
    offsets.append(decompiler_data.localsize)
    offsets.sort()
    for key in range(len(offsets) - 1):
        size_var = int(
            (offsets[key + 1] - offsets[key]) / (int(decompiler_data.lds_vars[offsets[key]][1][1:]) / 8))
        type_of_var = make_type(decompiler_data.lds_vars[offsets[key]][1])
        decompiler_data.write("    __local " + type_of_var + " " + decompiler_data.lds_vars[offsets[key]][0] + "["
                              + str(size_var) + "]" + ";\n")
    make_output_from_region(decompiler_data.improve_cfg, '    ')
    decompiler_data.write("}\n")


def write_global_data():
    decompiler_data = DecompilerData()
    for key, var in sorted(decompiler_data.type_gdata.items()):
        if var in ('uint', 'int'):
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 4, '>i')
        elif var in ('ulong', 'long'):
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 8, '>q')
        elif var == 'float':
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 4, '>f')
        elif var == 'double':
            list_of_gdata_values = evaluate_from_hex(decompiler_data.global_data[key], 8, '>d')
        decompiler_data.write("__constant " + var + " " + key + "[] = {")
        for index, element in enumerate(list_of_gdata_values):
            if index:
                decompiler_data.write(', ' + str(element))
            else:
                decompiler_data.write(str(element))
        decompiler_data.write("};\n\n")


def make_output_for_circle_vars(curr_node, indent):
    decompiler_data = DecompilerData()
    key = decompiler_data.circles_nodes_for_variables[curr_node]
    reg = key[:key.find("_")]
    decompiler_data.write(indent + decompiler_data.circles_variables[key] + " = "
                          + curr_node.state.registers[reg].val + ";\n")


def make_output_for_linear_region(region, indent):
    decompiler_data = DecompilerData()
    if isinstance(region.start, Node):
        if region.start == decompiler_data.cfg:
            curr_node = decompiler_data.cfg.children[0]
        else:
            curr_node = region.start
        while True:
            new_output = to_opencl(curr_node, OperationStatus.to_print)
            if new_output != "" and new_output is not None:
                decompiler_data.write(indent + new_output + ";\n")
            if decompiler_data.circles_nodes_for_variables.get(curr_node):
                make_output_for_circle_vars(curr_node, indent)
            if curr_node == region.end:
                break
            curr_node = curr_node.children[0]
        # new_output = to_opencl(curr_node, OperationStatus.to_print)
        # if new_output != "":
        #     decompiler_data.write(indent + new_output + ";\n")
        # else:
        #     make_output_for_circle_vars(curr_node, indent)
    else:
        curr_region = region.start
        make_output_from_region(curr_region, indent)
        while curr_region != region.end:
            curr_region = curr_region.children[0]
            make_output_from_region(curr_region, indent)


def make_output_from_if_statement_region(region, indent):
    decompiler_data = DecompilerData()
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        if region.start.start.parent[0].state.registers[reg] is not None \
                and region.start.start.parent[0].state.registers[reg].version == key \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys():
            decompiler_data.write(
                indent + decompiler_data.variables[key] + " = "
                + region.start.start.parent[0].state.registers[reg].val + ";\n")
    decompiler_data.write(indent + "if (")
    decompiler_data.write(to_opencl(region.start.start, OperationStatus.to_print))
    decompiler_data.write(") {\n")
    make_output_from_region(region.start.children[0], indent + '    ')
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        r_node = region.end.start
        while not isinstance(r_node, Node):
            r_node = r_node.start
        if r_node.parent[0].state.registers[reg].version == key \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys() \
                and decompiler_data.variables[key] != r_node.parent[0].state.registers[reg].val:
            decompiler_data.write(indent + "    " + decompiler_data.variables[key] + " = "
                                  + r_node.parent[0].state.registers[reg].val + ";\n")
    make_output_from_region(region.start.children[1], indent + '    ')
    decompiler_data.write(indent + "}\n")


def make_output_from_if_else_statement_region(region, indent):
    decompiler_data = DecompilerData()
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        if region.start.start.parent[0].state.registers[reg] is not None \
                and region.start.start.parent[0].state.registers[reg].version == key \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys() \
                and decompiler_data.variables[key] != region.start.start.parent[0].state.registers[reg].val:
            decompiler_data.write(
                indent + decompiler_data.variables[key] + " = "
                + region.start.start.parent[0].state.registers[reg].val + ";\n")
    decompiler_data.write(indent + "if (")
    decompiler_data.write(to_opencl(region.start.start, OperationStatus.to_print))
    decompiler_data.write(") {\n")
    if_body = region.start.children[0]
    make_output_from_region(if_body, indent + '    ')
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        r_node_parent = region.start.children[0].end
        while not isinstance(r_node_parent, Node):
            r_node_parent = r_node_parent.end
        if r_node_parent.state.registers.get(reg) is not None \
                and r_node_parent.state.registers[reg].version == key \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys() \
                and decompiler_data.variables[key] != r_node_parent.state.registers[reg].val \
                and (region.start.start.parent[0].state.registers[reg] is None
                     or r_node_parent.state.registers[reg].version != region.start.start.parent[0].state.registers[
                         reg].version):
            if '*' not in decompiler_data.variables[key]:
                decompiler_data.write(indent + "    " + decompiler_data.variables[key] +
                                      " = " + r_node_parent.state.registers[reg].val + ";\n")
            else:
                decompiler_data.write(
                    indent + "    " + decompiler_data.variables[key][1:] + " = &" +
                    r_node_parent.state.registers[reg].val + ";\n")
    decompiler_data.write(indent + "}\n")
    else_body = region.start.children[1]
    decompiler_data.write(indent + "else {\n")
    make_output_from_region(else_body, indent + '    ')
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        r_node_parent = region.start.children[1].end
        while not isinstance(r_node_parent, Node):
            r_node_parent = r_node_parent.end
        if r_node_parent.state.registers.get(reg) is not None \
                and r_node_parent.state.registers[reg].version == key \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys() \
                and decompiler_data.variables[key] != r_node_parent.state.registers[reg].val \
                and (region.start.start.parent[0].state.registers[reg] is None
                     or r_node_parent.state.registers[reg].version != region.start.start.parent[0].state.registers[
                         reg].version):
            if '*' not in decompiler_data.variables[key]:
                decompiler_data.write(
                    indent + "    " + decompiler_data.variables[key] + " = "
                    + r_node_parent.state.registers[reg].val + ";\n")
            else:
                decompiler_data.write(indent + "    " + decompiler_data.variables[key][1:]
                                      + " = &" + r_node_parent.state.registers[reg].val + ";\n")
    decompiler_data.write(indent + "}\n")


def make_output_from_circle_region(region, indent):
    decompiler_data = DecompilerData()
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        if region.start.start.parent[0].state.registers[reg] is not None \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys():
            decompiler_data.write(
                indent + decompiler_data.variables[key] + " = "
                + region.start.start.parent[0].state.registers[reg].val + ";\n")
    decompiler_data.write(indent + "do {\n")
    make_output_from_region(region.start.children[0], indent + '    ')
    # for key in decompiler_data.circles_variables.keys():
    #     reg = key[:key.find("_")]
    #     r_node = region.end.start
    #     while not isinstance(r_node, Node):
    #         r_node = r_node.start
    #     if r_node.parent[0].state.registers[reg].version == key \
    #             and decompiler_data.circles_variables[key] in decompiler_data.names_of_vars.keys() \
    #             and decompiler_data.circles_variables[key] != r_node.parent[0].state.registers[reg].val:
    #         decompiler_data.write(indent + "    " + decompiler_data.circles_variables[key] + " = "
    #                               + r_node.parent[0].state.registers[reg].val + ";\n")
    decompiler_data.write(indent + "} while (")
    decompiler_data.write(to_opencl(region.end.start, OperationStatus.to_print))
    decompiler_data.write(");\n")


def make_output_from_region(region, indent):
    decompiler_data = DecompilerData()
    if region.type == TypeNode.linear:
        make_output_for_linear_region(region, indent)
    elif region.type == TypeNode.ifstatement:
        make_output_from_if_statement_region(region, indent)
    elif region.type == TypeNode.ifelsestatement:
        make_output_from_if_else_statement_region(region, indent)
    elif region.type == TypeNode.circle:
        make_output_from_circle_region(region, indent)
    elif region.type == TypeNode.continueregion:
        decompiler_data.write(indent + "continue;\n")
    elif region.type == TypeNode.breakregion:
        decompiler_data.write(indent + "break;\n")
