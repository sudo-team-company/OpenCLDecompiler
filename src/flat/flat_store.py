from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_elem_from_addr, make_new_type_without_modifier
from src.opencl_types import make_opencl_type
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from


def flat_store_fill_node(node, first_to, last_to, to_registers, from_registers, suffix):
    decompiler_data = DecompilerData()
    if first_to == last_to:
        node.state.registers[to_registers].version = node.parent[0].state.registers[to_registers].version
        node.state.registers[to_registers].type_of_data = suffix
    else:
        if node.state.registers[from_registers].type_of_data is not None \
                and 'bytes' in node.state.registers[from_registers].type_of_data:
            node.state.registers[from_registers].type_of_data = \
                node.state.registers[to_registers].type_of_data
            decompiler_data.names_of_vars[node.state.registers[from_registers].val] = \
                node.state.registers[to_registers].type_of_data
        else:
            if str(node.state.registers[from_registers].type_of_data) not in \
                    node.state.registers[to_registers].type_of_data:
                if node.state.registers[from_registers].val in decompiler_data.names_of_vars:
                    val = node.state.registers[from_registers].val
                    node.state.registers[from_registers].val = \
                        '(' + make_opencl_type(make_new_type_without_modifier(node, to_registers)) + ')' \
                        + node.state.registers[from_registers].val
                    # init var - i32, gdata - i64. var = gdata -> var - i64
                    decompiler_data.names_of_vars[val] = node.state.registers[from_registers].type_of_data
                else:
                    node.state.registers[from_registers].type_of_data = \
                        make_new_type_without_modifier(node, to_registers)
                    decompiler_data.names_of_vars[node.state.registers[from_registers].val] = \
                        node.state.registers[from_registers].type_of_data
    return node


def flat_store_print(node, to_registers, from_registers, name_of_from, last_from):
    decompiler_data = DecompilerData()
    var = node.state.registers[to_registers].val
    if " + " in var:
        var = make_elem_from_addr(var)
    else:
        var = "*(" + make_opencl_type(decompiler_data.names_of_vars[var]) + "*)(" + var + ")"
    if node.state.registers.get(from_registers):
        from_registers_1 = name_of_from + str(last_from)
        if node.state.registers[from_registers].val == "0" and node.state.registers.get(from_registers_1):
            output_string = var + " = " + node.state.registers[from_registers_1].val
        else:
            output_string = var + " = " + node.state.registers[from_registers].val
    else:
        output_string = var + " = " + decompiler_data.initial_state.registers[from_registers].val
    return output_string


class FlatStore(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        vaddr = instruction[1]
        vdata = instruction[2]
        inst_offset = "0" if len(instruction) < 4 else instruction[3]

        first_to, last_to, name_of_to, name_of_from, first_from, last_from \
            = find_first_last_num_to_from(vaddr, vdata)
        from_registers = name_of_from + str(first_from)
        to_registers = name_of_to + str(first_to)

        if suffix in ["dword", "byte"]:
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("*(uint32*)(" + vaddr + " + " + inst_offset
                                      + ") = " + vdata + " // flat_store_dword\n")
                return node

            if flag_of_status == OperationStatus.to_fill_node:
                return flat_store_fill_node(node, first_to, last_to, to_registers, from_registers, suffix)
            if flag_of_status == OperationStatus.to_print:
                return flat_store_print(node, to_registers, from_registers, name_of_from, last_from)

        if suffix == "dwordx2":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("*(ulong*)(" + vaddr + " + " + inst_offset
                                      + " = " + vdata + " // flat_store_dwordx2\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return flat_store_fill_node(node, first_to, last_to, to_registers, from_registers, suffix)
            if flag_of_status == OperationStatus.to_print:
                return flat_store_print(node, to_registers, from_registers, name_of_from, last_from)

        if suffix == "dwordx4":
            if flag_of_status == OperationStatus.to_print_unresolved:
                vm = "vm" + str(decompiler_data.number_of_vm)
                decompiler_data.write(
                    "short* " + vm + " = (" + vaddr + " + " + inst_offset + ") // flat_store_dwordx4\n")
                decompiler_data.write("*(uint*)(" + vm + ") = " + vdata + "[0]\n")
                decompiler_data.write("*(uint*)(" + vm + " + 4) = " + vdata + "[1]\n")
                decompiler_data.write("*(uint*)(" + vm + " + 8) = " + vdata + "[2]\n")
                decompiler_data.write("*(uint*)(" + vm + " + 12) = " + vdata + "[3]\n")
                decompiler_data.number_of_vm += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return flat_store_fill_node(node, first_to, last_to, to_registers, from_registers, suffix)
            if flag_of_status == OperationStatus.to_print:
                return flat_store_print(node, to_registers, from_registers, name_of_from, last_from)
