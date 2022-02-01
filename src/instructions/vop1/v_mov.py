from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.register_type import RegisterType


class VMov(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == 'b32':
            self.decompiler_data.write(self.vdst + " = " + self.src0 + " // v_mov_b32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'b32':
            if self.node.state.registers.get(self.src0) is not None:
                data_type = self.node.state.registers[self.src0].data_type
                new_value = self.node.state.registers[self.src0].val
                reg_type = self.node.state.registers[self.src0].type
            else:
                data_type = self.suffix
                new_value = self.src0
                reg_type = RegisterType.INT32
            return set_reg_value(self.node, new_value, self.vdst, [self.src0], data_type, reg_type=reg_type)
        return super().to_fill_node()
