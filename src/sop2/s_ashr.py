from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class SAshr(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'i32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (int)" + ssrc0 + " >> (" + ssrc1 + " & 31) // s_ashr_i32\n")
                decompiler_data.write("scc = " + sdst + "!=0\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, _, _ = make_op(node, ssrc0, str(pow(2, int(ssrc1))), " / ", '(int)', '')
                node = make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], suffix)
                return node
            if flag_of_status == OperationStatus.to_print:
                return output_string
