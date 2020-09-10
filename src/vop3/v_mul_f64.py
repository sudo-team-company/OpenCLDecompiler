from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class VMulF64(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]
        decompiler_data.output_file.write(vdst + " = as_double(" + src0 + ") * as_double(" + src1 + ")\n")
