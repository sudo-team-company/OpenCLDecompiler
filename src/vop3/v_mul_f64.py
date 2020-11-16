from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class VMulF64(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]
        decompiler_data.output_file.write(vdst + " = as_double(" + src0 + ") * as_double(" + src1 + ")\n")
