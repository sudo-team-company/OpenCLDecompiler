from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class VAlignbit(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            decompiler_data.write(vdst + " = (((ulong)" + src0 + ") << 32) | " + src1 + ") >> (" + src2 + " & 31)\n")
