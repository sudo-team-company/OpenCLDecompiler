from src.base_instruction import BaseInstruction


class FlatAtomicAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.vaddr = self.instruction[2]
        self.vdata = self.instruction[3]
        self.inst_offset = self.instruction[4] if len(self.instruction) > 4 else ''

    def to_print_unresolved(self):
        vm = "vm" + str(self.decompiler_data.number_of_vm)
        p = "p" + str(self.decompiler_data.number_of_p)
        self.decompiler_data.write("uint* " + vm + " = (uint*)(" + self.vaddr + " + "
                                   + self.inst_offset + ") // flat_atomic_add\n")
        self.decompiler_data.write(
            "uint " + p + " = *" + vm + "; *" + vm + " = *" + vm + " + " + self.vdata + "; "
            + self.vdst + " = (glc) ? " + p + " : " + self.vdst + '  // atomic\n')
        self.decompiler_data.number_of_vm += 1
        self.decompiler_data.number_of_p += 1
        return self.node
