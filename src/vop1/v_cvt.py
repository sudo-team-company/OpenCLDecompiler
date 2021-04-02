from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class VCvt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        tab = "    "
        if suffix == "f32_u32":
            vdst = instruction[1]
            src0 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (float)" + src0 + " // v_cvt_f32_u32\n")
                return node

        elif suffix == "f64_i32":
            vdst = instruction[1]
            src0 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(int)" + src0 + " // v_cvt_f64_i32\n")
                return node

        elif suffix == "u32_f32":
            vdst = instruction[1]
            src0 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(instruction[1] + " = 0 // v_cvt_u32_f32\n")
                decompiler_data.write("if (!isnan(as_float(" + src0 + ")))\n")
                decompiler_data.write(tab + vdst + " = (int)min(convert_int_rtz(as_float("
                                      + src0 + ")), 4294967295.0)\n")
                return node
