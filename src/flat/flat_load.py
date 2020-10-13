from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class FlatLoad(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == "dword":
            vdst = instruction[1]
            vaddr = instruction[2]
            inst_offset = instruction[3] if len(instruction) > 3 else ""
            variable = "var" + str(decompiler_data.num_of_var)
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(vdst, vaddr)
            if flag_of_status == OperationStatus.to_fill_node:
                if inst_offset == "":
                    if first_to == last_to:
                        data_type = node.state.registers[from_registers].type_of_data
                        node.state.registers[to_registers] = \
                            Register(variable, Type.program_param, Integrity.integer)
                        node.state.make_version(decompiler_data.versions, to_registers)
                        node.state.registers[to_registers].type_of_data = data_type
                        #
                        node.state.registers[to_registers].val = variable
                        decompiler_data.num_of_var += 1
                        decompiler_data.variables[node.state.registers[to_registers].version] = variable
                        decompiler_data.names_of_vars[variable] = node.state.registers[from_registers].type_of_data
                return node
            output_string = node.state.registers[to_registers].val + " = " \
                            + node.parent[0].state.registers[from_registers].val
            return output_string

        elif suffix == "dwordx4":
            vdst = instruction[1]
            vaddr = instruction[2]
            inst_offset = instruction[3]
            vm = "vm" + str(decompiler_data.number_of_vm)
            decompiler_data.output_file.write("short* " + vm + " = (" + vaddr + " + " + inst_offset + ")\n")
            decompiler_data.output_file.write(vdst + "[0] = *(uint*)" + vm + "\n")
            decompiler_data.output_file.write(vdst + "[1] = *(uint*)(" + vm + " + 4)\n")
            decompiler_data.output_file.write(vdst + "[2] = *(uint*)(" + vm + " + 8)\n")
            decompiler_data.output_file.write(vdst + "[3] = *(uint*)(" + vm + " + 12)\n")
            decompiler_data.number_of_vm += 1
