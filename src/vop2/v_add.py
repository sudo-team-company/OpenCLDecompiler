from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.integrity import Integrity
from src.opencl_types import most_common_type, make_asm_type
from src.operation_status import OperationStatus
from src.register_type import RegisterType
from src.upload import find_first_last_num_to_from


class VAdd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""

        if suffix == "u32":
            vdst = instruction[1]
            sdst = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                mask = "mask" + str(decompiler_data.number_of_mask)
                decompiler_data.write("uint " + temp + " = (ulong)" + src0 + " + (ulong)" + src1 + " // v_add_u32\n")
                decompiler_data.write(vdst + " = CLAMP ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
                decompiler_data.write(sdst + " = 0\n")
                decompiler_data.write("ulong " + mask + " = (1ULL<<LANEID)\n")
                decompiler_data.write(sdst + " = (" + sdst + "&~" + mask + ") | (("
                                      + temp + " >> 32) ? " + mask + " : 0)\n")
                decompiler_data.number_of_temp += 1
                decompiler_data.number_of_mask += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, src0_reg, src1_reg = make_op(node, src0, src1, " + ", '(ulong)', '(ulong)')
                type_of_value = suffix
                reg_type = RegisterType.unknown
                new_integrity = Integrity.entire
                if src0_reg and src1_reg:
                    new_integrity = node.state.registers[src1].integrity
                    if node.state.registers[src0].type == RegisterType.work_group_id_x_local_size_offset and \
                            node.state.registers[src1].type == RegisterType.work_item_id_x or \
                            node.state.registers[src0].type == RegisterType.global_offset_x and \
                            node.state.registers[src1].type == RegisterType.work_group_id_x_work_item_id:
                        new_value = "get_global_id(0)"
                        reg_type = RegisterType.global_id_x
                    elif node.state.registers[src0].type == RegisterType.work_group_id_y_local_size_offset and \
                            node.state.registers[src1].type == RegisterType.work_item_id_y or \
                            node.state.registers[src0].type == RegisterType.global_offset_y and \
                            node.state.registers[src1].type == RegisterType.work_group_id_y_work_item_id:
                        new_value = "get_global_id(1)"
                        reg_type = RegisterType.global_id_y
                    elif node.state.registers[src0].type == RegisterType.work_group_id_z_local_size_offset and \
                            node.state.registers[src1].type == RegisterType.work_item_id_z or \
                            node.state.registers[src0].type == RegisterType.global_offset_z and \
                            node.state.registers[src1].type == RegisterType.work_group_id_z_work_item_id or \
                            node.state.registers[src1].type == RegisterType.global_offset_z and \
                            node.state.registers[src0].type == RegisterType.work_group_id_z_work_item_id:
                        new_value = "get_global_id(2)"
                        reg_type = RegisterType.global_id_z
                    elif node.state.registers[src0].type == RegisterType.address_kernel_argument:
                        reg_type = RegisterType.address_kernel_argument_element
                        if '.s' in node.state.registers[src0].val:
                            argument = node.state.registers[src0].val[:-3]
                        else:
                            argument = node.state.registers[src0].val

                        if decompiler_data.type_params.get("*" + argument):
                            type_of_value = make_asm_type(decompiler_data.type_params["*" + argument])
                        else:
                            type_of_value = 'int2'
                        # TODO: Проанализировать, есть ли в "int" и "uint" необходимость
                        if decompiler_data.type_params.get("*" + argument) in \
                                ["int", "uint", "__global int", "__global uint", "float", "__global float"]:
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "4", " / ", '', '')
                            new_value, _, _ = make_op(node, argument, new_value, " + ", '', '')
                        elif decompiler_data.type_params.get("*" + argument) in \
                                ["long", "ulong", "__global long", "__global ulong",
                                 "double", "__global double",
                                 "int2", "__global int2"]:
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "8", " / ", '', '')
                            new_value, _, _ = make_op(node, argument, new_value, " + ", '', '')
                        elif decompiler_data.type_params.get("*" + argument) in \
                                ["char", "uchar", "__global char", "__global uchar"]:
                            new_value, _, _ = make_op(node, argument, node.state.registers[src1].val, " + ", '', '')
                            # TODO: Проанализировать, почему нет присвоения типов
                        elif decompiler_data.type_params.get("*" + argument) in ["int4", "__global int4"]:
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "16", " / ", '', '')
                            new_value, _, _ = make_op(node, argument, new_value, " + ", '', '')
                        elif decompiler_data.type_params.get("*" + argument) in ["int8", "__global int8"]:
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "32", " / ", '', '')
                            new_value, _, _ = make_op(node, argument, new_value, " + ", '', '')
                        else:
                            new_value, src0_flag, src1_flag = make_op(node, src1, "8", " / ", '', '')
                            new_value, _, _ = make_op(node, argument, new_value, " + ", '', '')
                    elif node.state.registers[src0].type == RegisterType.global_data_pointer:
                        type_of_data = node.state.registers[src1].type_of_data
                        name = node.state.registers[src0].val
                        new_integrity = Integrity.entire
                        if 'bytes' in type_of_data:
                            position = type_of_data.find(' ')
                            value = type_of_data[:position]
                            new_value, src0_flag, src1_flag = make_op(node, src1, value, " / ", '', '')
                            new_value, _, _ = make_op(node, name, new_value, " + ", '', '')
                            type_of_value = type_of_data
                            reg_type = RegisterType.global_data_pointer
                    elif node.state.registers[src0].type == RegisterType.work_group_id_x_local_size and \
                            node.state.registers[src1].type == RegisterType.work_item_id_x:
                        new_value = "get_global_id(0) - get_global_offset(0)"
                        reg_type = RegisterType.work_group_id_x_work_item_id
                    elif node.state.registers[src0].type == RegisterType.work_group_id_y_local_size and \
                            node.state.registers[src1].type == RegisterType.work_item_id_y:
                        new_value = "get_global_id(1) - get_global_offset(1)"
                        reg_type = RegisterType.work_group_id_y_work_item_id
                    elif node.state.registers[src0].type == RegisterType.work_group_id_z_local_size and \
                            node.state.registers[src1].type == RegisterType.work_item_id_z:
                        new_value = "get_global_id(2) - get_global_offset(2)"
                        reg_type = RegisterType.work_group_id_z_work_item_id
                    elif node.state.registers[src0].type == RegisterType.work_group_id_x_local_size and \
                            node.state.registers[src1].type == RegisterType.work_item_id_x or \
                            node.state.registers[src1].type == RegisterType.work_group_id_x_local_size and \
                            node.state.registers[src0].type == RegisterType.work_item_id_x:
                        new_value = "get_global_id(0) - get_global_offset(0)"
                    else:
                        type_of_value = node.state.registers[src1].type_of_data
                else:
                    reg_type = RegisterType.int32
                    if src0_reg:
                        reg_type = node.state.registers[src0].type
                    if src1_reg:
                        reg_type = node.state.registers[src1].type
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], type_of_value,
                                              reg_type=reg_type, reg_entire=new_integrity)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        elif suffix == 'f64':
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            _, _, _, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers_src0 = name_of_from + str(first_from)
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src1)
            from_registers_src1 = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            # TODO: to_print_unresolved
            if flag_of_status == OperationStatus.to_fill_node:
                type_of_value = most_common_type(node.state.registers[from_registers_src0].type_of_data,
                                                 node.state.registers[from_registers_src1].type_of_data)
                reg_type = node.state.registers[from_registers_src1].type
                new_value = node.state.registers[from_registers_src1].val
                return make_new_value_for_reg(node, new_value, to_registers, [from_registers_src0, from_registers_src1],
                                              type_of_value, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string
