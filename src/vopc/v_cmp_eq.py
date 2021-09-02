from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, compare_values
from src.opencl_types import make_opencl_type
from src.operation_status import OperationStatus


class VCmpEq(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "u32" or suffix == "i32" or suffix == 'f32':
            if suffix != 'f32':
                new_as_type = '(' + make_opencl_type(suffix) + ')'
            else:
                new_as_type = 'as_float('
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                if suffix != 'f32':
                    decompiler_data.write(sdst + "(LANEID) = " + new_as_type + src0
                                          + " == " + new_as_type + src1 + " // v_cmp_eq_" + suffix + "\n")
                    return node
                else:
                    decompiler_data.write(sdst + "(LANEID) = as_float(" + src0 + ") == as_float("
                                          + src1 + ") // v_cmp_eq_" + suffix + "\n")
                    return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_values(node, sdst, src0, src1, new_as_type, new_as_type, " == ", suffix)
            return output_string
