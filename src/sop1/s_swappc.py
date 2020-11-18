from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class SSwappc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            decompiler_data.write(sdst + " = pc + 4\n")
            decompiler_data.write("pc = " + ssrc0 + "\n")
