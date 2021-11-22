from src.base_instruction import BaseInstruction


class VCmpxEq(BaseInstruction):
    def __int__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'f64':
            self.decompiler_data.write(self.sdst + " = as_double(" + self.src0 +
                                       ") == as_double(" + self.src1 + ") // v_cmpx_eq_f64\n")
            self.decompiler_data.write("exec = " + self.sdst + "\n")
            return self.node
        else:
            return super().to_print_unresolved()
