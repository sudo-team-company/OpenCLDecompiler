from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, compare_values
from src.operation_status import OperationStatus


class VCmpLg(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]

        if suffix == "i32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (int)" + src0 + " != (int)" + src1 + " // v_cmp_lg_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_values(node, sdst, src0, src1, '(int)', '(int)', " != ", suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        elif suffix == "u32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (uint)" + src0 + " != (uint)" + src1 + " // v_cmp_lg_u32\n")
                return node
