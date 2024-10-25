from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value, set_reg
from src.register import is_reg
from src.register_type import RegisterType


class SLshr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b32':
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " >> (" + self.ssrc1 + " & 31) // s_lshr_b32\n")
            self.decompiler_data.write("scc = " + self.sdst + "!= 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3:
            try:
                if is_reg(self.ssrc0) and self.ssrc1.isdigit():
                    new_reg = self.node.state[self.ssrc0] >> int(self.ssrc1)
                    new_reg.cast_to(self.suffix)
                    return set_reg(
                        node=self.node,
                        to_reg=self.sdst,
                        from_regs=[self.ssrc0, self.ssrc1],
                        reg=new_reg,
                    )
            except Exception:
                pass

        if self.suffix == 'b32':
            reg_type = self.node.state[self.ssrc0].type
            if self.node.state[self.ssrc0].type == RegisterType.GLOBAL_SIZE_X \
                    and pow(2, int(self.ssrc1)) == self.decompiler_data.config_data.size_of_work_groups[0]:
                new_value = "get_num_groups(0)"
            elif self.node.state[self.ssrc0].type == RegisterType.GLOBAL_SIZE_Y \
                    and pow(2, int(self.ssrc1)) == self.decompiler_data.config_data.size_of_work_groups[1]:
                new_value = "get_num_groups(1)"
            elif self.node.state[self.ssrc0].type == RegisterType.GLOBAL_SIZE_Z \
                    and pow(2, int(self.ssrc1)) == self.decompiler_data.config_data.size_of_work_groups[2]:
                new_value = "get_num_groups(2)"
            else:
                new_value = make_op(self.node, self.ssrc0, str(pow(2, int(self.ssrc1))), '/', suffix=self.suffix)
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix,
                                 reg_type=reg_type)
        return super().to_fill_node()
