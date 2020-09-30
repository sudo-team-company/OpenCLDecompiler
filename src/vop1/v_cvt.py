from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class VCvt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        tab = "    "
        if suffix == "f32_u32":
            vdst = instruction[1]
            src0 = instruction[2]
            decompiler_data.output_file.write(vdst + " = (float)" + src0 + "\n")

        elif suffix == "f64_i32":
            vdst = instruction[1]
            src0 = instruction[2]
            decompiler_data.output_file.write(vdst + " = (double)(int)" + src0 + "\n")

        elif suffix == "u32_f32":
            vdst = instruction[1]
            src0 = instruction[2]
            decompiler_data.output_file.write(instruction[1] + " = 0\n")
            decompiler_data.output_file.write("if (!isnan(as_float(" + src0 + ")))\n")
            decompiler_data.output_file.write(
                tab + vdst + " = (int)min(convert_int_rtz(as_float(" + src0 + ")), 4294967295.0)\n")
