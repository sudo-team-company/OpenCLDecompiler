from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class SNot(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            decompiler_data.write(sdst + " = ~" + ssrc0 + "\n")
            decompiler_data.write("scc = " + sdst + " != 0\n")
