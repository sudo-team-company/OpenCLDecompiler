from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class SCselect(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            decompiler_data.output_file.write(sdst + " = scc ? " + ssrc0 + " : " + ssrc1 + "\n")
