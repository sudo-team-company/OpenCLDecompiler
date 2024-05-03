from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import is_reg
from src.register_type import RegisterType


class VSubNc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        if 'rev' in self.instruction[0]:
            self.vdst, self.src1, self.src0 = self.instruction[1:4]
        else:
            self.vdst, self.src0, self.src1 = self.instruction[1:4]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            self.decompiler_data.write(
                f"{self.vdst} = (uint){self.src0} - (uint){self.src1} // {self.instruction[0]}\n")
            return self.node
        if self.suffix == 'u16':
            self.decompiler_data.write(
                f"{self.vdst} = (ushort){self.src0} - (ushort){self.src1} // {self.instruction[0]}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        reg_type = RegisterType.INT32
        if is_reg(self.src0):
            reg_type = self.node.state.registers[self.src0].integrity
        elif is_reg(self.src1):
            reg_type = self.node.state.registers[self.src1].integrity
        if self.suffix == 'u32':
            new_value = make_op(self.node, self.src0, self.src1, '-', '(uint)', '(uint)', suffix=self.suffix)
            return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix,
                                 reg_type=reg_type)
        if self.suffix == 'u16':
            new_value = make_op(self.node, self.src0, self.src1, '-', '(ushort)', '(ushort)', suffix=self.suffix)
            return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix,
                                 reg_type=reg_type)
        return super().to_fill_node()
