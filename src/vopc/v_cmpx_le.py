from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class VCmpxLe(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == "u32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            decompiler_data.output_file.write(sdst + " = (uint)" + src0 + " <= (uint)" + src1 + "\n")
            decompiler_data.output_file.write("exec = " + " = " + sdst + "\n")
