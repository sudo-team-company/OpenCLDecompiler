from src.base_instruction import BaseInstruction


class SCbranchVccnz(BaseInstruction):
    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write("pc = vcc != 0 ? " + reladdr + " : pc + 4 // s_cbranch_vccnz\n")
        return self.node
