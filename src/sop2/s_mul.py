from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class SMul(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'i32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " * " + ssrc1 + " // s_mul_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, ssrc0_reg, ssrc1_reg = make_op(node, ssrc0, ssrc1, " * ", '', '')
                reg_type = RegisterType.unknown
                if ssrc0_reg and ssrc1_reg:
                    if node.state.registers[ssrc0].type == RegisterType.local_size_x \
                            and node.state.registers[ssrc1].type == RegisterType.work_group_id_x:
                        reg_type = RegisterType.work_group_id_x_local_size
                    elif node.state.registers[ssrc0].type == RegisterType.local_size_y \
                            and node.state.registers[ssrc1].type == RegisterType.work_group_id_y:
                        reg_type = RegisterType.work_group_id_y_local_size
                    elif node.state.registers[ssrc0].type == RegisterType.local_size_z \
                            and node.state.registers[ssrc1].type == RegisterType.work_group_id_z:
                        reg_type = RegisterType.work_group_id_z_local_size
                return make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], suffix, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string
