from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class SSetGprIdxOn(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        ssrc0 = instruction[1]
        imm8 = instruction[2]
        decompiler_data.output_file.write("mode = (mode & ~(1U << 27)) | (1U << 27)\n")
        decompiler_data.output_file.write(
            "m0 = (m0 & 0xffff0f00) | ((" + imm8 + " & 15) << 12) | (" + ssrc0 + " & 0xff)\n")
