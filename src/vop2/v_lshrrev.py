from src.base_instruction import BaseInstruction


class VLshrrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b64':
            self.decompiler_data.write(self.vdst + " = " + self.src1 + " >> ("
                                       + self.src0 + " & 63) // v_lshrrev_b64\n")
            return self.node
