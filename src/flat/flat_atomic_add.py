from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class FlatAtomicAdd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        vdst = instruction[1]
        vaddr = instruction[2]
        vdata = instruction[3]
        inst_offset = instruction[4] if len(instruction) > 4 else ''

        if flag_of_status == OperationStatus.to_print_unresolved:
            vm = "vm" + str(decompiler_data.number_of_vm)
            p = "p" + str(decompiler_data.number_of_p)
            decompiler_data.write("uint* " + vm + " = (uint*)(" + vaddr + " + "
                                  + inst_offset + ") // flat_atomic_add\n")
            decompiler_data.write(
                "uint " + p + " = *" + vm + "; *" + vm + " = *" + vm + " + " + vdata + "; "
                + vdst + " = (glc) ? " + p + " : " + vdst + '  // atomic\n')
            decompiler_data.number_of_vm += 1
            decompiler_data.number_of_p += 1
            return node
