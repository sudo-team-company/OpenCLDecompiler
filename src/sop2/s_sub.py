from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class SSub(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'i32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                decompiler_data.write(sdst + " = " + ssrc0 + " - " + ssrc1 + " // s_sub_i32\n")
                decompiler_data.write("long " + temp + " = (long)" + ssrc0 + " - (long)" + ssrc1 + "\n")
                decompiler_data.write("scc = " + temp + " > ((1LL << 31) - 1) || " + temp + " < (-1LL << 31)\n")
                decompiler_data.number_of_temp += 1
                return node

        elif suffix == 'u32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                decompiler_data.write("ulong " + temp + " = (ulong)" + ssrc0
                                      + " - (ulong)" + ssrc1 + " // s_sub_u32\n")
                decompiler_data.write(sdst + " = " + temp + "\n")
                decompiler_data.write("scc = (" + temp + ">>32)!=0\n")
                decompiler_data.number_of_temp += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, src0_reg, src1_reg = make_op(node, ssrc0, ssrc1, " - ", '(ulong)', '(ulong)')
                new_integrity = node.state.registers[ssrc1].integrity
                return make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], suffix, reg_entire=new_integrity)
            if flag_of_status == OperationStatus.to_print:
                return output_string
