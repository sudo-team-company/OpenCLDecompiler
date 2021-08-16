from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, compare_values
from src.operation_status import OperationStatus


class SCmpGt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'i32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("scc = (int)" + ssrc0 + " > (int)" + ssrc1 + " // s_cmp_gt_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_values(node, "scc", ssrc0, ssrc1, "(int)", "(int)", " > ", suffix)
            return output_string

        elif suffix == 'u32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("scc = " + ssrc0 + " > " + ssrc1 + " // s_cmp_gt_u32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_values(node, "scc", ssrc0, ssrc1, "", "", " > ", suffix)
            return output_string
