from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class SSetGprIdxOff(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        decompiler_data.write("mode = (mode & ~(1U << 27))\n")
