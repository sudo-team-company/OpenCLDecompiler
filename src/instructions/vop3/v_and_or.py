from src.base_instruction import BaseInstruction


class VAndOr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]
        self.src2 = self.instruction[4]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(
                self.vdst + " = (" + self.src0 + " & " + self.src1 + ") | " + self.src2 + " // v_and_or_b32\n"
            )
            return self.node
        return super().to_print_unresolved()
