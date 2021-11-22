from src.base_instruction import BaseInstruction


class SSetreg(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.hwreg = self.instruction[1]
        self.hwregname = self.instruction[2]
        self.bitoffset = self.instruction[3]
        self.bitsize = self.instruction[4]
        self.sdst = self.instruction[5]

    def to_print_unresolved(self):
        if self.suffix == 'b32':
            mask = "mask" + str(self.decompiler_data.number_of_mask)
            self.decompiler_data.write("uint " + mask + " = (1U << " + self.bitsize
                                       + ") - 1U) << " + self.bitoffset + " // s_setreg_b32\n")
            self.decompiler_data.write(self.hwreg + " = (" + self.hwreg + "& ~" + mask + ") | (("
                                       + self.sdst + " << " + self.bitoffset + ") & " + mask + ")\n")
            self.decompiler_data.number_of_mask += 1
            return self.node
        else:
            return super().to_print_unresolved()
