from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class SBfe(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
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
                    node.state.registers[sdst] = Register("get_work_dim()", Type.work_dim, Integrity.entire)
                elif ssrc1 == '0x100010':
                    node.state.registers[sdst] = Register("get_local_size(1)", Type.local_size_y, Integrity.entire)
                else:
                    print("Unknown pattern in s_bfe")
                decompiler_data.make_version(node.state, sdst)
                return node
            return output_string

        if suffix == "i32":
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
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
            return output_string
