from src.base_instruction import BaseInstruction


class DsWrite2(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.addr = self.instruction[1]
        self.vdata0 = self.instruction[2]
        self.vdata1 = self.instruction[3]
        self.offset0 = self.instruction[4][8:]
        self.offset1 = self.instruction[5][8:]

    def to_print_unresolved(self):
        if self.suffix == "b64":
            v0 = "V0" + str(self.decompiler_data.number_of_v0)
            v1 = "V1" + str(self.decompiler_data.number_of_v1)
            self.decompiler_data.write(
                "ulong* "
                + v0
                + " = (ulong*)(ds + ("
                + self.addr
                + " + "
                + self.offset0
                + " * 8) & ~7) // ds_write2_b64\n"
            )
            self.decompiler_data.write(
                "ulong* " + v1 + " = (ulong*)(ds + (" + self.addr + " + " + self.offset1 + " * 8) & ~7)\n"
            )
            self.decompiler_data.write("*" + v0 + " = " + self.vdata0 + "\n")
            self.decompiler_data.write("*" + v1 + " = " + self.vdata1 + "\n")
            self.decompiler_data.number_of_v0 += 1
            self.decompiler_data.number_of_v1 += 1
            return self.node
        return super().to_print_unresolved()
