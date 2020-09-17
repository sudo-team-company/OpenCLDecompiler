from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class FlatAtomicAdd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        vdst = instruction[1]
        vaddr = instruction[2]
        vdata = instruction[3]
        vm = "vm" + str(decompiler_data.number_of_vm)
        p = "p" + str(decompiler_data.number_of_p)
        inst_offset = instruction[4]
        decompiler_data.output_file.write("uint* " + vm + " = (uint*)(" + vaddr + " + " + inst_offset + ")\n")
        decompiler_data.output_file.write(
            "uint " + p + " = *" + vm + "; *" + vm + " = *" + vm + " + " + vdata + "; "
            + vdst + " = (glc) ? " + p + " : " + vdst + '\n')
        decompiler_data.number_of_vm += 1
        decompiler_data.number_of_p += 1
