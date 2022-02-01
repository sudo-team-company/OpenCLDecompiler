from src.base_instruction import BaseInstruction


class SSetGprIdxOn(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.ssrc0 = self.instruction[1]
        self.imm8 = self.instruction[2]

    def to_print_unresolved(self):
        self.decompiler_data.write("mode = (mode & ~(1U << 27)) | (1U << 27) // s_set_gpr_idx_on\n")
        self.decompiler_data.write("m0 = (m0 & 0xffff0f00) | ((" + self.imm8 +
                                   " & 15) << 12) | (" + self.ssrc0 + " & 0xff)\n")
        return self.node
