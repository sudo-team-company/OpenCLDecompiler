from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg
from src.integrity import Integrity
from src.opencl_types import most_common_type, make_asm_type
from src.register_type import RegisterType
from src.upload import find_first_last_num_to_from


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
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            new_value, src0_reg, src1_reg = make_op(self.node, self.src0, self.src1, " + ", '(ulong)', '(ulong)')
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
                    if '.s' in self.node.state.registers[self.src0].val:
                        argument = self.node.state.registers[self.src0].val[:-3]
                    else:
                        argument = self.node.state.registers[self.src0].val

                    if self.decompiler_data.type_params.get("*" + argument):
                        data_type = make_asm_type(self.decompiler_data.type_params["*" + argument])
                    else:
                        data_type = 'int2'
                    # TODO: Проанализировать, есть ли в "int" и "uint" необходимость
                    if self.decompiler_data.type_params.get("*" + argument) in \
                            ["int", "uint", "__global int", "__global uint", "float", "__global float"]:
                        if "1073741824" in self.node.state.registers[self.src1].val:
                            new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "1073741824", " * ")
                        else:
                            new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "4", ' / ')
                        new_value, _, _ = make_op(self.node, argument, new_value, " + ")
                    elif self.decompiler_data.type_params.get("*" + argument) in \
                            ["long", "ulong", "__global long", "__global ulong",
                             "double", "__global double",
                             "int2", "__global int2"]:
                        if "1073741824" in self.node.state.registers[self.src1].val:
                            new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "1073741824", " * ")
                        else:
                            new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "8", " / ")
                        new_value, _, _ = make_op(self.node, argument, new_value, " + ")
                    elif self.decompiler_data.type_params.get("*" + argument) in \
                            ["char", "uchar", "__global char", "__global uchar"]:
                        new_value, _, _ = make_op(self.node, argument, self.node.state.registers[self.src1].val, " + ")
                        # TODO: Проанализировать, почему нет присвоения типов
                    elif self.decompiler_data.type_params.get("*" + argument) in ["int4", "__global int4"]:
                        if "1073741824" in self.node.state.registers[self.src1].val:
                            new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "1073741824", " * ")
                        else:
                            new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "16", " / ")
                        new_value, _, _ = make_op(self.node, argument, new_value, " + ")
                    elif self.decompiler_data.type_params.get("*" + argument) in ["int8", "__global int8"]:
                        if "1073741824" in self.node.state.registers[self.src1].val:
                            new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "1073741824", " * ")
                        else:
                            new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "32", " / ")
                        new_value, _, _ = make_op(self.node, argument, new_value, " + ")
                    else:
                        new_value, src0_flag, src1_flag = make_op(self.node, self.src1, "8", " / ")
                        new_value, _, _ = make_op(self.node, argument, new_value, " + ")
                elif self.node.state.registers[self.src0].type == RegisterType.GLOBAL_DATA_POINTER:
                    data_type = self.node.state.registers[self.src1].data_type
                    name = self.node.state.registers[self.src0].val
                    reg_entire = Integrity.ENTIRE
                    if 'bytes' in data_type:
                        position = data_type.find(' ')
                        value = data_type[:position]
                        new_value, src0_flag, src1_flag = make_op(self.node, self.src1, value, " / ")
                        new_value, _, _ = make_op(self.node, name, new_value, " + ")
                        data_type = data_type
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
                if src1_reg:
                    reg_type = self.node.state.registers[self.src1].type
            return make_new_value_for_reg(self.node, new_value, self.vdst, [self.src0, self.src1], data_type,
                                          reg_type=reg_type, reg_entire=reg_entire)
        elif self.suffix == 'f64':
            _, _, _, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(self.vdst, self.src0)
            from_registers_src0 = name_of_from + str(first_from)
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(self.vdst, self.src1)
            from_registers_src1 = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            data_type = most_common_type(self.node.state.registers[from_registers_src0].data_type,
                                         self.node.state.registers[from_registers_src1].data_type)
            reg_type = self.node.state.registers[from_registers_src1].type
            new_value = self.node.state.registers[from_registers_src1].val
            return make_new_value_for_reg(self.node, new_value, to_registers,
                                          [from_registers_src0, from_registers_src1],
                                          data_type, reg_type=reg_type)
        else:
            return super().to_fill_node()
