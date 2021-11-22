from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg
from src.register_type import RegisterType
from src.upload import find_first_last_num_to_from


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
        elif self.suffix == 'b64':
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " << (" + self.ssrc1 + " & 63) // s_lshl_b64\n")
            self.decompiler_data.write("scc = " + self.sdst + "!= 0\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'b32':
            new_value, ssrc0_flag, ssrc1_flag = make_op(self.node, self.ssrc0, str(pow(2, int(self.ssrc1))), " * ")
            if self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_X:
                reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
            elif self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_Y:
                reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
            elif self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_Z:
                reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE
            else:
                reg_type = self.node.state.registers[self.ssrc0].type
            return make_new_value_for_reg(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix,
                                          reg_type=reg_type)
        elif self.suffix == 'b64':
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(self.sdst, self.ssrc0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            from_registers1 = name_of_from + str(first_from + 1)
            to_registers1 = name_of_to + str(first_to + 1)
            new_value0, ssrc0_flag0, ssrc1_flag0 = make_op(self.node, from_registers,
                                                           str(pow(2, int(self.ssrc1))), " * ")
            new_value1, ssrc0_flag1, ssrc1_flag1 = make_op(self.node, from_registers1,
                                                           str(pow(2, int(self.ssrc1))), " * ")
            reg_type0 = self.node.state.registers[from_registers].type
            reg_type1 = self.node.state.registers[from_registers1].type
            data_type = self.suffix
            if self.ssrc1 == '3':
                data_type = '8 bytes'
            elif self.ssrc1 == '2':
                data_type = '4 bytes'
            node = make_new_value_for_reg(self.node, new_value0, to_registers, [from_registers, self.ssrc1],
                                          data_type, reg_type=reg_type0)
            node = make_new_value_for_reg(node, new_value1, to_registers1, [from_registers1, self.ssrc1],
                                          data_type, reg_type=reg_type1)
            return node
        else:
            return super().to_fill_node()
