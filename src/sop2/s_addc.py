from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import is_reg
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
        if self.suffix == 'u32':
            new_value = make_op(self.node, self.ssrc0, self.ssrc1, " + ", '(ulong)', '(ulong)')
            ssrc0_reg = is_reg(self.ssrc0)
            ssrc1_reg = is_reg(self.ssrc1)
            reg_type = RegisterType.INT32
            if ssrc0_reg:
                reg_type = self.node.state.registers[self.ssrc0].type
                if self.node.state.registers[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    if self.node.state.registers[self.ssrc0].data_type in ['u32', 'i32', 'gu32', 'gi32']:
                        new_value = make_op(self.node, self.ssrc1, "4", " / ", '', '')
                        new_value = make_op(self.node, self.ssrc0, new_value, " + ", '', '')
            elif ssrc1_reg:
                reg_type = self.node.state.registers[self.ssrc1].type
            if self.node.state.registers[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                if self.ssrc0 == self.sdst:
                    data_type = self.node.parent[0].state.registers[self.ssrc0].data_type
                else:
                    data_type = self.node.state.registers[self.ssrc0].data_type
            else:
                data_type = self.suffix
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], data_type,
                                 reg_type=reg_type)
        return super().to_fill_node()
