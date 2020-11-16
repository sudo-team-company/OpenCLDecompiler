from src.decompiler_data import DecompilerData
from src.node import Node
from src.node_processor import to_opencl
from src.opencl_types import make_type
from src.operation_status import OperationStatus
from src.type_of_node import TypeNode


def create_opencl_body():
    decompiler_data = DecompilerData()
    decompiler_data.output_file.write("{\n")
    for var in sorted(decompiler_data.names_of_vars.keys()):
        type_of_var = make_type(decompiler_data.names_of_vars[var])
        decompiler_data.output_file.write("    " + type_of_var + " " + var + ";\n")
    offsets = list(decompiler_data.lds_vars.keys())
    offsets.append(decompiler_data.localsize)
    offsets.sort()
    for key in range(len(offsets) - 1):
        size_var = int(
            (offsets[key + 1] - offsets[key]) / (int(decompiler_data.lds_vars[offsets[key]][1][1:]) / 8))
        type_of_var = make_type(decompiler_data.lds_vars[offsets[key]][1])
        decompiler_data.output_file.write(
            "    __local " + type_of_var + " " + decompiler_data.lds_vars[offsets[key]][0] + "[" + str(
                size_var) + "]" + ";\n")
    make_output_from_region(decompiler_data.improve_cfg, '    ')
    decompiler_data.output_file.write("}\n")


def make_output_for_linear_region(region, indent):
    decompiler_data = DecompilerData()
    if isinstance(region.start, Node):
        reg = region.start
        if region.start == decompiler_data.cfg:
            reg = decompiler_data.cfg.children[0]
        while reg != region.end:
            new_output = to_opencl(reg, OperationStatus.to_print)
            if new_output != "":
                decompiler_data.output_file.write(indent + new_output + ";\n")
            reg = reg.children[0]
        new_output = to_opencl(reg, OperationStatus.to_print)
        if new_output != "":
            decompiler_data.output_file.write(indent + new_output + ";\n")
    else:
        reg = region.start
        make_output_from_region(reg, indent)
        while reg != region.end:
            reg = reg.children[0]
            make_output_from_region(reg, indent)


def make_output_from_if_statement_region(region, indent):
    decompiler_data = DecompilerData()
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        if region.start.start.parent[0].state.registers[reg] is not None \
                and region.start.start.parent[0].state.registers[reg].version == key \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys():
            decompiler_data.output_file.write(
                indent + decompiler_data.variables[key] + " = "
                + region.start.start.parent[0].state.registers[reg].val + ";\n")
    decompiler_data.output_file.write(indent + "if (")
    decompiler_data.output_file.write(to_opencl(region.start.start, OperationStatus.to_print))
    decompiler_data.output_file.write(") {\n")
    make_output_from_region(region.start.children[0], indent + '    ')
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        r_node = region.end.start
        while not isinstance(r_node, Node):
            r_node = r_node.start
        if r_node.parent[0].state.registers[reg].version == key \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys() \
                and decompiler_data.variables[key] != r_node.parent[0].state.registers[reg].val:
            decompiler_data.output_file.write(indent + "    " + decompiler_data.variables[key] + " = "
                                              + r_node.parent[0].state.registers[reg].val + ";\n")
    make_output_from_region(region.start.children[1], indent + '    ')
    decompiler_data.output_file.write(indent + "}\n")


def make_output_from_if_else_statement_region(region, indent):
    decompiler_data = DecompilerData()
    for key in decompiler_data.variables.keys():
        reg = key[:key.find("_")]
        if region.start.start.parent[0].state.registers[reg] is not None \
                and region.start.start.parent[0].state.registers[reg].version == key \
                and decompiler_data.variables[key] in decompiler_data.names_of_vars.keys() \
                and decompiler_data.variables[key] != region.start.start.parent[0].state.registers[reg].val:
            decompiler_data.output_file.write(
                indent + decompiler_data.variables[key] + " = "
                + region.start.start.parent[0].state.registers[reg].val + ";\n")
    decompiler_data.output_file.write(indent + "if (")
    decompiler_data.output_file.write(to_opencl(region.start.start, OperationStatus.to_print))
    decompiler_data.output_file.write(") {\n")
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
                decompiler_data.output_file.write(indent + "    " + decompiler_data.variables[key] +
                                                  " = " + r_node_parent.state.registers[reg].val + ";\n")
            else:
                decompiler_data.output_file.write(
                    indent + "    " + decompiler_data.variables[key][1:] + " = &" +
                    r_node_parent.state.registers[reg].val + ";\n")
    decompiler_data.output_file.write(indent + "}\n")
    else_body = region.start.children[1]
    decompiler_data.output_file.write(indent + "else {\n")
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
                decompiler_data.output_file.write(
                    indent + "    " + decompiler_data.variables[key] + " = "
                    + r_node_parent.state.registers[reg].val + ";\n")
            else:
                decompiler_data.output_file.write(indent + "    " + decompiler_data.variables[key][1:]
                                                  + " = &" + r_node_parent.state.registers[reg].val + ";\n")
    decompiler_data.output_file.write(indent + "}\n")


def make_output_from_region(region, indent):
    if region.type == TypeNode.linear:
        make_output_for_linear_region(region, indent)
    elif region.type == TypeNode.ifstatement:
        make_output_from_if_statement_region(region, indent)
    elif region.type == TypeNode.ifelsestatement:
        make_output_from_if_else_statement_region(region, indent)
