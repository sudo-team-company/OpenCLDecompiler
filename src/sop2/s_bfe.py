from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class SBfe(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'u32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                tab = "    "
                shift = "shift" + str(decompiler_data.number_of_shift)
                length = "length" + str(decompiler_data.number_of_length)
                decompiler_data.write("uchar " + shift + " = " + ssrc1 + " & 31 // s_bfe_u32\n")
                decompiler_data.write("uchar " + length + " = (" + ssrc1 + ">>16) & 07xf\n")
                decompiler_data.write("if (" + length + "==0)\n")
                decompiler_data.write(tab + sdst + " = 0\n")
                decompiler_data.write("if (" + shift + " + " + length + " < 32)\n")
                decompiler_data.write(tab + sdst + " = " + ssrc0 + " << (32 - " + shift + " - " + length
                                      + ") >> (32 - " + length + ")\n")
                decompiler_data.write("else\n")
                decompiler_data.write(tab + sdst + " = " + ssrc0 + " >> " + shift + "\n")
                decompiler_data.write("scc = " + sdst + " != 0\n")
                decompiler_data.number_of_length += 1
                decompiler_data.number_of_shift += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                if ssrc1 == "0x20010":
                    new_value = "get_work_dim()"
                    reg_type = RegisterType.work_dim
                elif ssrc1 == '0x100010':
                    new_value = "get_local_size(1)"
                    reg_type = RegisterType.local_size_y
                else:
                    print("Unknown pattern in s_bfe")
                    raise NotImplementedError()
                return make_new_value_for_reg(node, new_value, sdst, [], suffix, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        if suffix == "i32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                tab = "    "
                shift = "shift" + str(decompiler_data.number_of_shift)
                length = "length" + str(decompiler_data.number_of_length)
                decompiler_data.write("uchar " + shift + " = " + ssrc1 + " & 31 // s_bfe_i32\n")
                decompiler_data.write("uchar " + length + " = (" + ssrc1 + ">>16) & 07xf\n")
                decompiler_data.write("if (" + length + "==0)\n")
                decompiler_data.write(tab + sdst + " = 0\n")
                decompiler_data.write("if (" + shift + " + " + length + " < 32)\n")
                decompiler_data.write(tab + sdst + " = (int)" + ssrc0 + " << (32 - " + shift + " - " + length
                                      + ") >> (32 - " + length + ")\n")
                decompiler_data.write("else\n")
                decompiler_data.write(tab + sdst + " = (int)" + ssrc0 + " >> " + shift + "\n")
                decompiler_data.write("scc = " + sdst + " != 0\n")
                decompiler_data.number_of_length += 1
                decompiler_data.number_of_shift += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return node
            if flag_of_status == OperationStatus.to_print:
                return output_string
