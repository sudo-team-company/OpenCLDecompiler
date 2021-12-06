from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import is_sgpr
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
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            new_val = make_op(self.node, self.ssrc0, self.ssrc1, " + ", '(ulong)', '(ulong)')
            ssrc0_reg = is_sgpr(self.ssrc0)
            ssrc1_reg = is_sgpr(self.ssrc1)
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
                        new_value = make_op(self.node, self.ssrc1, "4", " / ", '', '')
                        new_val = make_op(self.node, name, new_value, " + ", '', '')
                        data_type = '4 bytes'
                    else:
                        new_value = make_op(self.node, self.ssrc1, "8", " / ", '', '')
                        new_val = make_op(self.node, name, new_value, " + ", '', '')
                        data_type = '8 bytes'
                elif self.node.state.registers[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT
                    if self.node.state.registers[self.ssrc0].data_type in ['u32', "i32", "gi32", "gu32"]:
                        new_val = make_op(self.node, self.ssrc1, "4", " / ", '', '')
                        new_val = make_op(self.node, self.ssrc0, new_val, " + ", '', '')
                elif RegisterType.KERNEL_ARGUMENT_VALUE in \
                        [self.node.state.registers[self.ssrc0].type, self.node.state.registers[self.ssrc1].type]:
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
                        new_val = make_op(self.node, self.ssrc1, "4", " / ", '', '')
                        new_val = make_op(self.node, self.ssrc0, new_val, " + ", '', '')
            if self.node.state.registers[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                if self.ssrc0 == self.sdst:
                    data_type = self.node.parent[0].state.registers[self.ssrc0].data_type
                else:
                    data_type = self.node.state.registers[self.ssrc0].data_type
            return set_reg_value(self.node, new_val, self.sdst, [self.ssrc0, self.ssrc1], data_type, reg_type=reg_type)
        return super().to_fill_node()
