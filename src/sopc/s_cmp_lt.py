from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, compare_values
from src.operation_status import OperationStatus


class SCmpLt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        ssrc0 = instruction[1]
        ssrc1 = instruction[2]

        if suffix == 'i32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("scc = (int)" + ssrc0 + " < (int)" + ssrc1 + " // s_cmp_lt_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_values(node, "scc", ssrc0, ssrc1, "(int)", "(int)", " < ", suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string
