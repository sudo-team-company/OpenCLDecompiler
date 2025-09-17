from src.base_instruction import BaseInstruction


class VCmpxEq(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "f64":
            self.decompiler_data.write(
                f"{self.sdst} = as_double({self.src0}) == as_double({self.src1}) // {self.name}\n"
            )
            self.decompiler_data.write(f"exec = {self.sdst}\n")
            return self.node
        return super().to_print_unresolved()
