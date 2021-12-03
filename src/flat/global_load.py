from src.base_instruction import BaseInstruction


class GlobalLoad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.vaddr = self.instruction[2]
        self.saddr = "0" if self.instruction[3] == "off" else self.instruction[3]
        self.inst_offset = "0" if len(self.instruction) == 4 else self.instruction[4]

    def to_print_unresolved(self):
        if self.suffix == "dword":
            self.decompiler_data.write(self.vdst + " = *(uint*)(" + self.vaddr + " + " + self.saddr + " + "
                                       + self.inst_offset + ") // global_load_dword\n")
            return self.node
        if self.suffix == "dwordx2":
            self.decompiler_data.write(self.vdst + " = *(ulong*)(" + self.vaddr + " + " + self.saddr + " + "
                                       + self.inst_offset + ")  // global_load_dwordx2\n")
            return self.node
        return super().to_print_unresolved()
