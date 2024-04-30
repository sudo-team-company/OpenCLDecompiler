from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value, set_reg
from src.register import is_reg


class VLshlAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            self.decompiler_data.write(
                f"{self.vdst} = ({self.src0} << {self.src1}) + {self.src2} // {self.instruction[0]}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3:
            if is_reg(self.src0) and self.src1.isdigit() and is_reg(self.src2):
                new_reg = self.node.state.registers[self.src0] * int(pow(2, int(self.src1)))
                new_reg = new_reg + self.node.state.registers[self.src2]

                return set_reg(
                    node=self.node,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1, self.src2],
                    reg=new_reg,
                )

        if self.suffix == 'u32':
            if self.src1.isdigit():
                new_value = make_op(self.node, self.src0, str(int(pow(2, int(self.src1)))), '*')
                new_value = make_op(self.node, new_value, self.src2, '+', '(ulong)', '(ulong)')
                return set_reg_value(
                    node=self.node,
                    new_value=new_value,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1, self.src2],
                    data_type=self.suffix,
                )
        return super().to_fill_node()
