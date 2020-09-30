from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class GlobalStore(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == "dword":
            vaddr = instruction[1]
            vdata = instruction[2]
            saddr = 0 if instruction[3] == "off" else instruction[3]
            inst_offset = 0 if len(instruction) == 4 else instruction[4]
            decompiler_data.output_file.write(
                "*(uint*)(" + vaddr + " + " + saddr + " + " + inst_offset + ") = " + vdata + "\n")

        elif suffix == "dwordx2":
            vaddr = instruction[1]
            vdata = instruction[2]
            saddr = 0 if instruction[3] == "off" else instruction[3]
            inst_offset = 0 if len(instruction) == 4 else instruction[4]
            decompiler_data.output_file.write(
                "*(ulong*)(" + vaddr + " + " + saddr + " + " + inst_offset + ") = " + vdata + "\n")
