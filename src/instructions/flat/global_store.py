from src.instructions.flat.flat_store import FlatStore
from src.register import check_and_split_regs


class GlobalStore(FlatStore):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vaddr = self.instruction[1]
        self.vdata = self.instruction[2]
        if self.instruction[3] != "off":
            raise NotImplementedError(
                f"Only 'off' as saddr implemented for global_store instructions. "
                f"Current instruction: '{' '.join(self.instruction)}'"
            )
        self.saddr = "0"
        self.inst_offset = "0" if len(self.instruction) == 4 else self.instruction[4]

        self.to_registers, _ = check_and_split_regs(self.vaddr)
        self.from_registers, self.from_registers_1 = check_and_split_regs(self.vdata)

    def to_print_unresolved(self):
        if self.suffix == "dword":
            self.decompiler_data.write("*(uint*)(" + self.vaddr + " + " + self.saddr + " + " + self.inst_offset
                                       + ") = " + self.vdata + " // global_store_dword\n")
            return self.node
        if self.suffix == "dwordx2":
            self.decompiler_data.write("*(ulong*)(" + self.vaddr + " + " + self.saddr + " + " + self.inst_offset
                                       + ") = " + self.vdata + " // global_store_dwordx2\n")
            return self.node
        return super().to_print_unresolved()
