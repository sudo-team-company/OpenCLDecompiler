from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value


class SAddK(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.src0, self.simm16 = self.instruction[1:3]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            temp = "temp" + str(self.decompiler_data.number_of_temp)
            self.decompiler_data.write(f"{temp} = {self.src0}\n")
            self.decompiler_data.write(f"{self.src0} = {self.src0} + {self.simm16} // {self.instruction[0]}\n")
            self.decompiler_data.write(
                f"scc = (({temp} >> 31) == ({self.simm16} >> 15) && ({temp} >> 31) != ({self.src0} >> 31))\n")
            self.decompiler_data.number_of_temp += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'i32':
            new_value = make_op(self.node, self.src0, self.simm16, " + ", '(int)', '(int)')
            data_type = self.suffix
            reg_type = self.node.state.registers[self.src0].type
            return set_reg_value(self.node, new_value, self.src0, [self.src0, self.simm16], data_type,
                                 reg_type=reg_type)
        return super().to_fill_node()
