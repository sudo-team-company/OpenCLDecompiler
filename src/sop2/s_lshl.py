from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import check_and_split_regs
from src.register_type import RegisterType


class SLshl(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b32':
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " << (" + self.ssrc1 + " & 31) // s_lshl_b32\n")
            self.decompiler_data.write("scc = " + self.sdst + "!= 0\n")
            return self.node
        if self.suffix == 'b64':
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " << (" + self.ssrc1 + " & 63) // s_lshl_b64\n")
            self.decompiler_data.write("scc = " + self.sdst + "!= 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'b32':
            new_value, _, _ = make_op(self.node, self.ssrc0, str(pow(2, int(self.ssrc1))), " * ")
            if self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_X:
                reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
            elif self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_Y:
                reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
            elif self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_Z:
                reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE
            else:
                reg_type = self.node.state.registers[self.ssrc0].type
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix,
                                 reg_type=reg_type)
        if self.suffix == 'b64':
            start_to_register, end_to_register = check_and_split_regs(self.sdst)
            start_from_register, end_from_register = check_and_split_regs(self.ssrc0)
            new_value0, _, _ = make_op(self.node, start_from_register, str(pow(2, int(self.ssrc1))), " * ")
            new_value1, _, _ = make_op(self.node, end_from_register, str(pow(2, int(self.ssrc1))), " * ")
            reg_type0 = self.node.state.registers[start_from_register].type
            reg_type1 = self.node.state.registers[end_from_register].type
            data_type = self.suffix
            if self.ssrc1 == '3':
                data_type = '8 bytes'
            elif self.ssrc1 == '2':
                data_type = '4 bytes'
            node = set_reg_value(self.node, new_value0, start_to_register, [start_from_register, self.ssrc1], data_type,
                                 reg_type=reg_type0)
            node = set_reg_value(node, new_value1, end_to_register, [end_from_register, self.ssrc1], data_type,
                                 reg_type=reg_type1)
            return node
        return super().to_fill_node()
