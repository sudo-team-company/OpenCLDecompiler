from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value, set_reg
from src.register import is_sgpr, is_reg
from src.register_type import RegisterType


class SAddc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            temp = "temp" + str(self.decompiler_data.number_of_temp)
            self.decompiler_data.write("ulong " + temp + " = (ulong)" + self.ssrc0
                                       + " + (ulong)" + self.ssrc1 + " + scc // s_addc_u32\n")
            self.decompiler_data.write(self.sdst + " = " + temp + "\n")
            self.decompiler_data.write("scc = " + temp + " >> 32\n")
            self.decompiler_data.number_of_temp += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3:
            if is_reg(self.ssrc0) and is_reg(self.ssrc1):
                new_reg = self.node.state.registers[self.ssrc0] + self.node.state.registers[self.ssrc1]

                return set_reg(
                    node=self.node,
                    to_reg=self.sdst,
                    from_regs=[self.ssrc0, self.ssrc1],
                    reg=new_reg,
                )

        if self.suffix == 'u32':
            new_value = make_op(self.node, self.ssrc0, self.ssrc1, '+', '(ulong)', '(ulong)', suffix=self.suffix)
            ssrc0_reg = is_sgpr(self.ssrc0)
            ssrc1_reg = is_sgpr(self.ssrc1)
            reg_type = RegisterType.INT32
            data_type = self.suffix
            if self.ssrc0.isdigit() and int(self.ssrc0) == 0 and ssrc1_reg:
                new_value = self.node.state.registers[self.ssrc1].val
                reg_type = self.node.state.registers[self.ssrc1].type
            if self.ssrc1.isdigit() and int(self.ssrc1) == 0 and ssrc0_reg:
                new_value = self.node.state.registers[self.ssrc0].val
                reg_type = self.node.state.registers[self.ssrc0].type
            if ssrc0_reg:
                if self.node.state.registers[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    if self.node.state.registers[self.ssrc0].data_type in ['u32', 'i32', 'gu32', 'gi32']:
                        new_value = make_op(self.node, self.ssrc1, '4', '/', suffix=self.suffix)
                        new_value = make_op(self.node, self.ssrc0, new_value, '+', suffix=self.suffix)
                    if self.ssrc0 == self.sdst:
                        data_type = self.node.parent[0].state.registers[self.ssrc0].data_type
                    else:
                        data_type = self.node.state.registers[self.ssrc0].data_type
                    reg_type = self.node.state.registers[self.ssrc0].type
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], data_type,
                                 reg_type=reg_type)
        return super().to_fill_node()
