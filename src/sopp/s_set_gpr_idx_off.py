from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class SSetGprIdxOff(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        decompiler_data.output_file.write("mode = (mode & ~(1U << 27))\n")
