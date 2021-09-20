from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class SAdd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'u32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                decompiler_data.write("ulong " + temp + " = (ulong)" + ssrc0
                                      + " + (ulong)" + ssrc1 + " // s_add_u32\n")
                decompiler_data.write(sdst + " = " + temp + "\n")
                decompiler_data.write("scc = " + temp + " >> 32\n")
                decompiler_data.number_of_temp += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, ssrc0_reg, ssrc1_reg = make_op(node, ssrc0, ssrc1, " + ", '(ulong)', '(ulong)')
                type_of_value = suffix
                if ssrc0_reg and ssrc1_reg:
                    if node.state.registers[ssrc0].type == RegisterType.work_group_id_x_local_size \
                            and node.state.registers[ssrc1].type == RegisterType.global_offset_x:
                        reg_type = RegisterType.work_group_id_x_local_size_offset
                    elif node.state.registers[ssrc0].type == RegisterType.work_group_id_y_local_size \
                            and node.state.registers[ssrc1].type == RegisterType.global_offset_y:
                        reg_type = RegisterType.work_group_id_y_local_size_offset
                    elif node.state.registers[ssrc0].type == RegisterType.work_group_id_z_local_size \
                            and node.state.registers[ssrc1].type == RegisterType.global_offset_z:
                        reg_type = RegisterType.work_group_id_z_local_size_offset
                    elif node.state.registers[ssrc0].type == RegisterType.global_data_pointer:
                        name = node.state.registers[ssrc0].val
                        reg_type = RegisterType.global_data_pointer
                        if node.state.registers[ssrc1].type_of_data == '4 bytes':
                            new_value, src0_flag, src1_flag = make_op(node, ssrc1, "4", " / ", '', '')
                            new_val, _, _ = make_op(node, name, new_value, " + ", '', '')
                            type_of_value = '4 bytes'
                        else:
                            new_value, src0_flag, src1_flag = make_op(node, ssrc1, "8", " / ", '', '')
                            new_val, _, _ = make_op(node, name, new_value, " + ", '', '')
                            type_of_value = '8 bytes'
                    elif node.state.registers[ssrc0].type == RegisterType.address_kernel_argument:
                        reg_type = RegisterType.address_kernel_argument
                        if node.state.registers[ssrc0].type_of_data in ['u32', "i32", "gi32", "gu32"]:
                            new_val, _, _ = make_op(node, ssrc1, "4", " / ", '', '')
                            new_val, _, _ = make_op(node, ssrc0, new_val, " + ", '', '')
                    elif node.state.registers[ssrc0].type == RegisterType.kernel_argument_value \
                            or node.state.registers[ssrc1].type == RegisterType.kernel_argument_value:
                        reg_type = RegisterType.kernel_argument_value
                    else:
                        reg_type = RegisterType.unknown
                else:
                    reg_type = RegisterType.int32
                    if ssrc0_reg:
                        reg_type = node.state.registers[ssrc0].type
                    if ssrc1_reg:
                        reg_type = node.state.registers[ssrc1].type
                    if node.state.registers[ssrc0].type == RegisterType.address_kernel_argument:
                        if node.state.registers[ssrc0].type_of_data in ['u32', "i32", "gi32", "gu32"]:
                            new_val, _, _ = make_op(node, ssrc1, "4", " / ", '', '')
                            new_val, _, _ = make_op(node, ssrc0, new_val, " + ", '', '')
                if not (node.state.registers[ssrc0].type == RegisterType.global_data_pointer):
                    if node.state.registers[ssrc0].type == RegisterType.address_kernel_argument:
                        if ssrc0 == sdst:
                            type_of_value = node.parent[0].state.registers[ssrc0].type_of_data
                        else:
                            type_of_value = node.state.registers[ssrc0].type_of_data
                return make_new_value_for_reg(node, new_val, sdst, [ssrc0, ssrc1], type_of_value, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string
