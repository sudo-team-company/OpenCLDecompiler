from src.base_instruction import BaseInstruction
from src.decompiler_data import make_new_value_for_reg
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
        else:
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
            return make_new_value_for_reg(self.node, new_value, self.vdst, [self.src0], data_type, reg_type=reg_type)
        else:
            return super().to_fill_node()
