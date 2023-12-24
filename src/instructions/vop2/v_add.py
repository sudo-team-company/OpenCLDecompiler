from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.integrity import Integrity
from src.opencl_types import most_common_type, make_asm_type, evaluate_size
from src.register import check_and_split_regs, is_reg
from src.register_type import RegisterType
from src.sum_register import SumRegister


class VAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        if suffix == 'u32':
            self.sdst = self.instruction[2]
            self.src0 = self.instruction[3]
            self.src1 = self.instruction[4]
        else:
            self.src0 = self.instruction[2]
            self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            temp = "temp" + str(self.decompiler_data.number_of_temp)
            mask = "mask" + str(self.decompiler_data.number_of_mask)
            self.decompiler_data.write("uint " + temp + " = (ulong)" + self.src0 +
                                       " + (ulong)" + self.src1 + " // v_add_u32\n")
            self.decompiler_data.write(self.vdst + " = CLAMP ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
            self.decompiler_data.write(self.sdst + " = 0\n")
            self.decompiler_data.write("ulong " + mask + " = (1ULL<<LANEID)\n")
            self.decompiler_data.write(self.sdst + " = (" + self.sdst + "&~" + mask + ") | (("
                                       + temp + " >> 32) ? " + mask + " : 0)\n")
            self.decompiler_data.number_of_temp += 1
            self.decompiler_data.number_of_mask += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            if self.decompiler_data.is_rdna3:
                if self.node.state.registers[self.src0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT and \
                        self.decompiler_data.type_params.get("*" + self.node.state.registers[self.src0].val):
                    reg_type = self.node.state.registers[self.src1].type
                    data_type = self.node.state.registers[self.src0].data_type
                    data_size, _ = evaluate_size(data_type, True)
                    new_value = make_op(self.node, self.src1, str(data_size), " / ")

                    return set_reg_value(
                        self.node,
                        [
                            self.node.state.registers[self.src0].val,
                            new_value,
                        ],
                        self.vdst,
                        [self.src0, self.src1],
                        self.suffix,
                        reg_type=[
                            self.node.state.registers[self.src0].type,
                            self.node.state.registers[self.src1].type,
                        ],
                        reg_entire=Integrity.ENTIRE,
                        reg_class=SumRegister,
                    )

                try:
                    new_reg = self.node.state.registers[self.src0] + self.node.state.registers[self.src1]
                    return set_reg_value(
                        self.node,
                        new_reg.val,
                        self.vdst,
                        [self.src0, self.src1],
                        self.suffix,
                        reg_type=new_reg.type,
                        reg_entire=Integrity.ENTIRE,
                        reg_class=type(new_reg),
                    )
                except Exception:
                    pass

            new_value = make_op(self.node, self.src0, self.src1, " + ", '(ulong)', '(ulong)')
            src0_reg = is_reg(self.src0)
            src1_reg = is_reg(self.src1)
            data_type = self.suffix
            reg_type = RegisterType.UNKNOWN
            reg_entire = Integrity.ENTIRE
            if src0_reg and src1_reg:
                reg_entire = self.node.state.registers[self.src1].integrity
                if self.node.state.registers[self.src0].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE_OFFSET and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_ITEM_ID_X or \
                        self.node.state.registers[self.src0].type == RegisterType.GLOBAL_OFFSET_X and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_GROUP_ID_X_WORK_ITEM_ID:
                    new_value = "get_global_id(0)"
                    reg_type = RegisterType.GLOBAL_ID_X
                elif self.node.state.registers[self.src0].type == RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE_OFFSET and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_ITEM_ID_Y or \
                        self.node.state.registers[self.src0].type == RegisterType.GLOBAL_OFFSET_Y and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_GROUP_ID_Y_WORK_ITEM_ID:
                    new_value = "get_global_id(1)"
                    reg_type = RegisterType.GLOBAL_ID_Y
                elif self.node.state.registers[self.src0].type == RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE_OFFSET and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_ITEM_ID_Z or \
                        self.node.state.registers[self.src0].type == RegisterType.GLOBAL_OFFSET_Z and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID or \
                        self.node.state.registers[self.src1].type == RegisterType.GLOBAL_OFFSET_Z and \
                        self.node.state.registers[self.src0].type == RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID:
                    new_value = "get_global_id(2)"
                    reg_type = RegisterType.GLOBAL_ID_Z
                elif self.node.state.registers[self.src0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT
                    argument = self.node.state.registers[self.src0].val
                    if self.decompiler_data.type_params.get("*" + argument):
                        data_type = make_asm_type(self.decompiler_data.type_params["*" + argument])
                    else:
                        data_type = self.node.state.registers[self.src0].data_type
                    data_size, _ = evaluate_size(data_type, True)
                    new_value = make_op(self.node, self.src1, str(data_size), " / ")
                    new_value = make_op(self.node, argument, new_value, " + ")
                elif self.node.state.registers[self.src0].type == RegisterType.GLOBAL_DATA_POINTER:
                    data_type = self.node.state.registers[self.src1].data_type
                    name = self.node.state.registers[self.src0].val
                    reg_entire = Integrity.ENTIRE
                    if 'bytes' in data_type:
                        position = data_type.find(' ')
                        value = data_type[:position]
                        new_value = make_op(self.node, self.src1, value, " / ")
                        new_value = make_op(self.node, name, new_value, " + ")
                        reg_type = RegisterType.GLOBAL_DATA_POINTER
                elif self.node.state.registers[self.src0].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_ITEM_ID_X:
                    new_value = "get_global_id(0) - get_global_offset(0)"
                    reg_type = RegisterType.WORK_GROUP_ID_X_WORK_ITEM_ID
                elif self.node.state.registers[self.src0].type == RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_ITEM_ID_Y:
                    new_value = "get_global_id(1) - get_global_offset(1)"
                    reg_type = RegisterType.WORK_GROUP_ID_Y_WORK_ITEM_ID
                elif self.node.state.registers[self.src0].type == RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_ITEM_ID_Z:
                    new_value = "get_global_id(2) - get_global_offset(2)"
                    reg_type = RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID
                elif self.node.state.registers[self.src0].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE and \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_ITEM_ID_X or \
                        self.node.state.registers[self.src1].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE and \
                        self.node.state.registers[self.src0].type == RegisterType.WORK_ITEM_ID_X:
                    new_value = "get_global_id(0) - get_global_offset(0)"
                else:
                    data_type = self.node.state.registers[self.src1].data_type
            else:
                reg_type = RegisterType.INT32
                if src0_reg:
                    reg_type = self.node.state.registers[self.src0].type
                    if self.node.state.registers[self.src0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT:
                        reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT
                        data_type = self.node.state.registers[self.src0].data_type
                        data_size, _ = evaluate_size(data_type, True)
                        new_value = make_op(self.node, self.src1, str(data_size), " / ")
                        new_value = make_op(self.node, self.src0, new_value, " + ")
                if src1_reg:
                    reg_type = self.node.state.registers[self.src1].type
            return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], data_type, reg_type=reg_type,
                                 reg_entire=reg_entire)
        if self.suffix == 'f64':
            # TODO: Сделать честное присвоение в пару
            start_from_src0, _ = check_and_split_regs(self.src0)
            start_from_src1, _ = check_and_split_regs(self.src1)
            start_to_register, _ = check_and_split_regs(self.vdst)
            data_type = most_common_type(self.node.state.registers[start_from_src0].data_type,
                                         self.node.state.registers[start_from_src1].data_type)
            reg_type = self.node.state.registers[start_from_src1].type
            if self.node.state.registers[start_from_src1].val == self.node.state.registers[start_from_src0].val:
                new_value = self.node.state.registers[start_from_src1].val
            else:
                new_value = make_op(self.node, start_from_src0, start_from_src1, " + ", '(double)', '(double)')
            return set_reg_value(self.node, new_value, start_to_register,
                                 [start_from_src0, start_from_src1], data_type, reg_type=reg_type)
        return super().to_fill_node()
