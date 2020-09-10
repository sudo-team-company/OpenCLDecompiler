from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class DsWrite2(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        if suffix == "b64":
            v0 = "v0" + str(decompiler_data.number_of_v0)
            v1 = "v1" + str(decompiler_data.number_of_v1)
            addr = instruction[1]
            vdata0 = instruction[2]
            vdata1 = instruction[3]
            offset0 = instruction[4][8:]
            offset1 = instruction[5][8:]
            decompiler_data.output_file.write(
                "ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7)\n")
            decompiler_data.output_file.write(
                "ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
            decompiler_data.output_file.write("*" + v0 + " = " + vdata0 + "\n")
            decompiler_data.output_file.write("*" + v1 + " = " + vdata1 + "\n")
            decompiler_data.number_of_v0 += 1
            decompiler_data.number_of_v1 += 1