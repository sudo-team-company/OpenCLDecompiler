from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg
from src.register_type import RegisterType


class SMul(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " * " + self.ssrc1 + " // s_mul_i32\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'i32':
            new_value, ssrc0_reg, ssrc1_reg = make_op(self.node, self.ssrc0, self.ssrc1, " * ")
            reg_type = RegisterType.UNKNOWN
            if ssrc0_reg and ssrc1_reg:
                if self.node.state.registers[self.ssrc0].type == RegisterType.LOCAL_SIZE_X \
                        and self.node.state.registers[self.ssrc1].type == RegisterType.WORK_GROUP_ID_X:
                    reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
                elif self.node.state.registers[self.ssrc0].type == RegisterType.LOCAL_SIZE_Y \
                        and self.node.state.registers[self.ssrc1].type == RegisterType.WORK_GROUP_ID_Y:
                    reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
                elif self.node.state.registers[self.ssrc0].type == RegisterType.LOCAL_SIZE_Z \
                        and self.node.state.registers[self.ssrc1].type == RegisterType.WORK_GROUP_ID_Z:
                    reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE
            return make_new_value_for_reg(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1],
                                          self.suffix, reg_type=reg_type)
        else:
            return super().to_fill_node()
