from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class SSetpc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == 'b64':
            ssrc0 = instruction[1]
            decompiler_data.output_file.write("pc = " + ssrc0 + "\n")
