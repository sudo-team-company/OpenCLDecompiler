from src.base_instruction import BaseInstruction


class VMulF64(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        self.decompiler_data.write(f"{self.vdst} = (double){self.src0} * (double){self.src1} // {self.name}\n")
        return self.node
