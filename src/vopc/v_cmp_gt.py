from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, compare_values
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from


class VCmpGt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "u64":  # not very correct
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (ulong)" + src0 + " > (uint)" + src1 + " // v_cmp_gt_u64\n")
                # почему uint???
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(src0, src1)
                src0 = name_of_to + str(first_to)
                src1 = name_of_from + str(first_from)
                return compare_values(node, sdst, src0, src1, '(ulong)', '(uint)', " > ", suffix)
            return output_string

        elif suffix == "i32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (int)" + src0 + " > (int)" + src1 + " // v_cmp_gt_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_values(node, sdst, src0, src1, '(int)', '(int)', " > ", suffix)
            return output_string

        elif suffix == "u32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (uint)" + src0 + " > (uint)" + src1 + " // v_cmp_gt_u32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_values(node, sdst, src0, src1, '(uint)', '(uint)', " > ", suffix)
            return output_string
