from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from


class VLdexp(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]
        offset = instruction[3]

        if flag_of_status == OperationStatus.to_fill_node:
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            type_of_value = suffix
            if offset == '32':
                type_of_value = node.state.registers[from_registers].type_of_data
                if type_of_value == 'u32':
                    type_of_value = 'u64'
                elif type_of_value == 'i32':
                    type_of_value = 'i64'
                decompiler_data.names_of_vars[node.state.registers[from_registers].val] = suffix
                reg_type = node.state.registers[from_registers].type
                new_value = node.state.registers[from_registers].val
            return make_new_value_for_reg(node, new_value, to_registers, [], type_of_value, reg_type=reg_type)
        if flag_of_status == OperationStatus:
            return output_string
