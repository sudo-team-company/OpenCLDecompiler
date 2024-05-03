from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value, set_reg


class SMulk(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.simm16 = self.instruction[2][self.instruction[2].find("x") + 1:]
        self.unmodified_simm16 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            self.decompiler_data.write(self.sdst + " = " + self.sdst + " * " + self.simm16 + " // s_mulk_i32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3:
            try:
                simm16 = self.unmodified_simm16
                if str(simm16).startswith("0x"):
                    simm16 = str(int(simm16, 16))

                if simm16.isdigit():
                    simm16 = int(simm16)
                    max_bit_number = 4 * len(self.simm16) - 1
                    max_bit = simm16 & (1 << max_bit_number)
                    if max_bit != 0:
                        simm16 = simm16 ^ ((1 << (max_bit_number + 1)) - 1)
                        simm16 += 1
                        simm16 *= -1

                    new_reg = self.node.state.registers[self.sdst] * simm16
                    new_reg.cast_to(self.suffix)
                    return set_reg(
                        node=self.node,
                        to_reg=self.sdst,
                        from_regs=[self.sdst],
                        reg=new_reg,
                    )
            except Exception:
                pass

        if self.suffix == 'i32':
            new_value = make_op(self.node, self.sdst, self.simm16, '*', suffix=self.suffix)
            return set_reg_value(self.node, new_value, self.sdst, [self.sdst], self.suffix)
        return super().to_fill_node()
