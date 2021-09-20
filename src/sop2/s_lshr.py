from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class SLshr(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'b32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " >> (" + ssrc1 + " & 31) // s_lshr_b32\n")
                decompiler_data.write("scc = " + sdst + "!= 0\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                reg_type = node.state.registers[ssrc0].type
                if node.state.registers[ssrc0].type == RegisterType.global_size_x \
                        and str(pow(2, int(ssrc1))) == decompiler_data.size_of_work_groups[0]:
                    new_value = "get_num_groups(0)"
                elif node.state.registers[ssrc0].type == RegisterType.global_size_y \
                        and str(pow(2, int(ssrc1))) == decompiler_data.size_of_work_groups[1]:
                    new_value = "get_num_groups(1)"
                elif node.state.registers[ssrc0].type == RegisterType.global_size_z \
                        and str(pow(2, int(ssrc1))) == decompiler_data.size_of_work_groups[2]:
                    new_value = "get_num_groups(2)"
                else:
                    new_value, ssrc0_flag, ssrc1_flag = make_op(node, ssrc0, str(pow(2, int(ssrc1))), " / ", '', '')
                return make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], suffix, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string
