from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class SAddc(BaseInstruction):
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
                                      + " + (ulong)" + ssrc1 + " + scc // s_addc_u32\n")
                decompiler_data.write(sdst + " = " + temp + "\n")
                decompiler_data.write("scc = " + temp + " >> 32\n")
                decompiler_data.number_of_temp += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, ssrc0_reg, ssrc1_reg = make_op(node, ssrc0, ssrc1, " + ", '(ulong)', '(ulong)')
                reg_type = RegisterType.int32
                if ssrc0_reg:
                    reg_type = node.state.registers[ssrc0].type
                    if node.state.registers[ssrc0].type == RegisterType.address_kernel_argument:
                        if node.state.registers[ssrc0].type_of_data in ['u32', 'i32', 'gu32', 'gi32']:
                            new_value, _, _ = make_op(node, ssrc1, "4", " / ", '', '')
                            new_value, _, _ = make_op(node, ssrc0, new_value, " + ", '', '')
                elif ssrc1_reg:
                    reg_type = node.state.registers[ssrc1].type
                if node.state.registers[ssrc0].type == RegisterType.address_kernel_argument:
                    if ssrc0 == sdst:
                        type_of_value = node.parent[0].state.registers[ssrc0].type_of_data
                    else:
                        type_of_value = node.state.registers[ssrc0].type_of_data
                else:
                    type_of_value = suffix
                return make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], type_of_value, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string
