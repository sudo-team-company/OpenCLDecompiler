from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class SCmpGe(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == 'i32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            decompiler_data.output_file.write("scc = (int)" + ssrc0 + " >= (int)" + ssrc1 + "\n")

        elif suffix == 'u32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            decompiler_data.output_file.write("scc = " + ssrc0 + " >= " + ssrc1 + "\n")
