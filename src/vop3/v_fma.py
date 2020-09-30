from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class VFma(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == "f64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            decompiler_data.output_file.write(
                vdst + " = " + "as_double(" + src0 + ") * as_double(" + src1 + ") + as_double(" + src2 + ")\n")
