from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, check_reg_for_val, make_new_value_for_reg
from src.operation_status import OperationStatus


class VMin(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ''
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]

        if suffix == "u32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = min(" + src0 + ", " + src1 + ") // v_min_u32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                src0, _ = check_reg_for_val(node, src0)
                src1, _ = check_reg_for_val(node, src1)
                new_value = "min(" + src0 + ", " + src1 + ")"
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string
