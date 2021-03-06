from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class SCbranchVccnz(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        reladdr = instruction[1]
        decompiler_data.output_file.write("pc = vcc != 0 ? " + reladdr + " : pc + 4")
