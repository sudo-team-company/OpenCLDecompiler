from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class SGetpc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == 'b64':
            sdst = instruction[1]
            decompiler_data.output_file.write(sdst + " = pc + 4\n")
