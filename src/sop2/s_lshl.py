from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType
from src.upload import find_first_last_num_to_from


class SLshl(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'b32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " << (" + ssrc1 + " & 31) // s_lshl_b32\n")
                decompiler_data.write("scc = " + sdst + "!= 0\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, ssrc0_flag, ssrc1_flag = make_op(node, ssrc0, str(pow(2, int(ssrc1))), " * ", '', '')
                if node.state.registers[ssrc0].type == RegisterType.work_group_id_x:
                    reg_type = RegisterType.work_group_id_x_local_size
                elif node.state.registers[ssrc0].type == RegisterType.work_group_id_y:
                    reg_type = RegisterType.work_group_id_y_local_size
                elif node.state.registers[ssrc0].type == RegisterType.work_group_id_z:
                    reg_type = RegisterType.work_group_id_z_local_size
                else:
                    reg_type = node.state.registers[ssrc0].type
                return make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], suffix, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        if suffix == 'b64':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " << (" + ssrc1 + " & 63) // s_lshl_b64\n")
                decompiler_data.write("scc = " + sdst + "!= 0\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(sdst, ssrc0)
                from_registers = name_of_from + str(first_from)
                to_registers = name_of_to + str(first_to)
                from_registers1 = name_of_from + str(first_from + 1)
                to_registers1 = name_of_to + str(first_to + 1)
                new_value0, ssrc0_flag0, ssrc1_flag0 = make_op(node, from_registers,
                                                               str(pow(2, int(ssrc1))), " * ", '', '')
                new_value1, ssrc0_flag1, ssrc1_flag1 = make_op(node, from_registers1,
                                                               str(pow(2, int(ssrc1))), " * ", '', '')
                reg_type0 = node.state.registers[from_registers].type
                reg_type1 = node.state.registers[from_registers1].type
                type_of_value = suffix
                if ssrc1 == '3':
                    type_of_value = '8 bytes'
                elif ssrc1 == '2':
                    type_of_value = '4 bytes'
                node = make_new_value_for_reg(node, new_value0, to_registers, [from_registers, ssrc1],
                                              type_of_value, reg_type=reg_type0)
                node = make_new_value_for_reg(node, new_value1, to_registers1, [from_registers1, ssrc1],
                                              type_of_value, reg_type=reg_type1)
                return node
            if flag_of_status == OperationStatus.to_print:
                return output_string
