from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class DsRead2(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == "b64":
            v0 = "v0" + str(decompiler_data.number_of_v0)
            v1 = "v1" + str(decompiler_data.number_of_v1)
            vdst = instruction[1]
            addr = instruction[2]
            offset0 = instruction[3][8:]
            offset1 = instruction[4][8:]
            decompiler_data.output_file.write(
                "ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7)\n")
            decompiler_data.output_file.write(
                "ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
            decompiler_data.output_file.write(vdst + " = *" + v0 + " | (ulonglong(*" + v1 + ") << 64)\n")  # uint128????
            decompiler_data.number_of_v0 += 1
            decompiler_data.number_of_v1 += 1
