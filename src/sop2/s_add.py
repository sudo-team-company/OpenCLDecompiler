from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg
from src.register_type import RegisterType


class SAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            temp = "temp" + str(self.decompiler_data.number_of_temp)
            self.decompiler_data.write("ulong " + temp + " = (ulong)" + self.ssrc0
                                       + " + (ulong)" + self.ssrc1 + " // s_add_u32\n")
            self.decompiler_data.write(self.sdst + " = " + temp + "\n")
            self.decompiler_data.write("scc = " + temp + " >> 32\n")
            self.decompiler_data.number_of_temp += 1
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            new_val, ssrc0_reg, ssrc1_reg = make_op(self.node, self.ssrc0, self.ssrc1, " + ", '(ulong)', '(ulong)')
            data_type = self.suffix
            if ssrc0_reg and ssrc1_reg:
                if self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE \
                        and self.node.state.registers[self.ssrc1].type == RegisterType.GLOBAL_OFFSET_X:
                    reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE_OFFSET
                elif self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE \
                        and self.node.state.registers[self.ssrc1].type == RegisterType.GLOBAL_OFFSET_Y:
                    reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE_OFFSET
                elif self.node.state.registers[self.ssrc0].type == RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE \
                        and self.node.state.registers[self.ssrc1].type == RegisterType.GLOBAL_OFFSET_Z:
                    reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE_OFFSET
                elif self.node.state.registers[self.ssrc0].type == RegisterType.GLOBAL_DATA_POINTER:
                    name = self.node.state.registers[self.ssrc0].val
                    reg_type = RegisterType.GLOBAL_DATA_POINTER
                    if self.node.state.registers[self.ssrc1].data_type == '4 bytes':
                        new_value, src0_flag, src1_flag = make_op(self.node, self.ssrc1, "4", " / ", '', '')
                        new_val, _, _ = make_op(self.node, name, new_value, " + ", '', '')
                        data_type = '4 bytes'
                    else:
                        new_value, src0_flag, src1_flag = make_op(self.node, self.ssrc1, "8", " / ", '', '')
                        new_val, _, _ = make_op(self.node, name, new_value, " + ", '', '')
                        data_type = '8 bytes'
                elif self.node.state.registers[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT
                    if self.node.state.registers[self.ssrc0].data_type in ['u32', "i32", "gi32", "gu32"]:
                        new_val, _, _ = make_op(self.node, self.ssrc1, "4", " / ", '', '')
                        new_val, _, _ = make_op(self.node, self.ssrc0, new_val, " + ", '', '')
                elif self.node.state.registers[self.ssrc0].type == RegisterType.KERNEL_ARGUMENT_VALUE \
                        or self.node.state.registers[self.ssrc1].type == RegisterType.KERNEL_ARGUMENT_VALUE:
                    reg_type = RegisterType.KERNEL_ARGUMENT_VALUE
                else:
                    reg_type = RegisterType.UNKNOWN
            else:
                reg_type = RegisterType.INT32
                if ssrc0_reg:
                    reg_type = self.node.state.registers[self.ssrc0].type
                if ssrc1_reg:
                    reg_type = self.node.state.registers[self.ssrc1].type
                if self.node.state.registers[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    if self.node.state.registers[self.ssrc0].data_type in ['u32', "i32", "gi32", "gu32"]:
                        new_val, _, _ = make_op(self.node, self.ssrc1, "4", " / ", '', '')
                        new_val, _, _ = make_op(self.node, self.ssrc0, new_val, " + ", '', '')
            if not (self.node.state.registers[self.ssrc0].type == RegisterType.GLOBAL_DATA_POINTER):
                if self.node.state.registers[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    if self.ssrc0 == self.sdst:
                        data_type = self.node.parent[0].state.registers[self.ssrc0].data_type
                    else:
                        data_type = self.node.state.registers[self.ssrc0].data_type
            return make_new_value_for_reg(self.node, new_val, self.sdst, [self.ssrc0, self.ssrc1],
                                          data_type, reg_type=reg_type)
        else:
            return super().to_fill_node()
