from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class FlatStoreDwordx4(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        vaddr = instruction[1]
        vdata = instruction[2]
        inst_offset = instruction[3]
        vm = "vm" + str(decompiler_data.number_of_vm)
        decompiler_data.write("short* " + vm + " = (" + vaddr + " + " + inst_offset + ")\n")
        decompiler_data.write("*(uint*)(" + vm + ") = " + vdata + "[0]\n")
        decompiler_data.write("*(uint*)(" + vm + " + 4) = " + vdata + "[1]\n")
        decompiler_data.write("*(uint*)(" + vm + " + 8) = " + vdata + "[2]\n")
        decompiler_data.write("*(uint*)(" + vm + " + 12) = " + vdata + "[3]\n")
        decompiler_data.number_of_vm += 1
