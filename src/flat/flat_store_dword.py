from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from
from src.opencl_types import make_type


class FlatStoreDword(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        vaddr = instruction[1]
        vdata = instruction[2]
        inst_offset = "0" if len(instruction) < 4 else instruction[3]
        if flag_of_status == OperationStatus.to_print_unresolved:
            decompiler_data.write("*(uint32*)(" + vaddr + " + " + inst_offset
                                  + ") = " + vdata + " // flat_store_dword\n")
            return node
        first_to, last_to, name_of_to, name_of_from, first_from, last_from \
            = find_first_last_num_to_from(vaddr, vdata)
        from_registers = name_of_from + str(first_from)
        to_registers = name_of_to + str(first_to)
        if flag_of_status == OperationStatus.to_fill_node:
            if first_to == last_to:
                node.state.registers[to_registers] = \
                    Register(node.state.registers[vdata].val, node.state.registers[from_registers].type,
                             Integrity.entire)
                node.state.registers[to_registers].version = node.parent[0].state.registers[to_registers].version
                node.state.registers[to_registers].type_of_data = suffix
            else:
                to_now = name_of_to + str(first_to + 1)
                if node.state.registers.get(vdata):
                    if node.state.registers[from_registers].type_of_data is not None \
                            and 'bytes' in node.state.registers[from_registers].type_of_data:
                        node.state.registers[from_registers].type_of_data = \
                            node.state.registers[to_registers].type_of_data
                        decompiler_data.names_of_vars[node.state.registers[from_registers].val] = \
                            node.state.registers[to_registers].type_of_data
                    else:
                        if node.state.registers[from_registers].type_of_data != node.state.registers[to_registers].type_of_data:
                            if node.state.registers[from_registers].val in decompiler_data.names_of_vars:
                                val = node.state.registers[from_registers].val
                                node.state.registers[from_registers].val = \
                                    '(' + make_type(node.state.registers[to_registers].type_of_data) + ')'\
                                    + node.state.registers[from_registers].val
                                decompiler_data.names_of_vars[val] = node.state.registers[from_registers].type_of_data
                            else:
                                node.state.registers[from_registers].type_of_data = \
                                    node.state.registers[to_registers].type_of_data
                                decompiler_data.names_of_vars[node.state.registers[from_registers].val] = \
                                    node.state.registers[from_registers].type_of_data
                    node.state.registers[to_registers] = \
                        Register(node.state.registers[vdata].val, node.state.registers[from_registers].type,
                                 Integrity.low_part)
                    node.state.registers[to_registers].version = \
                        node.parent[0].state.registers[to_registers].version
                    node.state.registers[to_now] = Register(node.state.registers[vdata].val,
                                                            node.state.registers[from_registers].type,
                                                            Integrity.high_part)
                    if node.parent[0].state.registers[to_now] is not None:
                        node.state.registers[to_now].version = node.parent[0].state.registers[to_now].version
                    node.state.registers[to_registers].type_of_data = suffix
                    node.state.registers[to_now].type_of_data = suffix
                else:
                    return node
            return node
        if inst_offset != "0":
            output_string = "*(uint*)(" + node.parent[0].state.registers[to_registers].val \
                            + " + " + inst_offset + ") = " \
                            + node.state.registers[name_of_to + str(first_to)].val
        else:
            var = node.parent[0].state.registers[to_registers].val
            if node.state.registers.get(from_registers):
                output_string = var + " = " + node.state.registers[from_registers].val
            else:
                output_string = var + " = " + decompiler_data.initial_state.registers[from_registers].val
        return output_string
