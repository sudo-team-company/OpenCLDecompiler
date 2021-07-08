from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.opencl_types import most_common_type
from src.operation_status import OperationStatus
from src.register import Register
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
            new_val, src0_reg, src1_reg = make_op(node, src0, src1, " + ", '(ulong)', '(ulong)')
            if flag_of_status == OperationStatus.to_fill_node:
                if src0_reg and src1_reg:
                    if node.state.registers[src0].type == RegisterType.work_group_id_x_local_size_offset and \
                            node.state.registers[src1].type == RegisterType.work_item_id_x or \
                            node.state.registers[src0].type == RegisterType.global_offset_x and \
                            node.state.registers[src1].type == RegisterType.work_group_id_x_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(0)", RegisterType.global_id_x, new_integrity)
                    elif node.state.registers[src0].type == RegisterType.work_group_id_y_local_size_offset and \
                            node.state.registers[src1].type == RegisterType.work_item_id_y or \
                            node.state.registers[src0].type == RegisterType.global_offset_y and \
                            node.state.registers[src1].type == RegisterType.work_group_id_y_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(1)", RegisterType.global_id_y, new_integrity)
                    elif node.state.registers[src0].type == RegisterType.work_group_id_z_local_size_offset and \
                            node.state.registers[src1].type == RegisterType.work_item_id_z or \
                            node.state.registers[src0].type == RegisterType.global_offset_z and \
                            node.state.registers[src1].type == RegisterType.work_group_id_z_work_item_id or \
                            node.state.registers[src1].type == RegisterType.global_offset_z and \
                            node.state.registers[src0].type == RegisterType.work_group_id_z_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(2)", RegisterType.global_id_z, new_integrity)
                    elif node.state.registers[src0].type == RegisterType.paramA:
                        new_integrity = node.state.registers[src1].integrity
                        if '.s' in node.state.registers[src0].val:
                            argument = node.state.registers[src0].val[:-3]
                        else:
                            argument = node.state.registers[src0].val
                        if decompiler_data.type_params.get("*" + argument) == "int" \
                                or decompiler_data.type_params.get("*" + argument) == "uint":
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "4", " / ", '', '')
                            new_val = argument + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                            node.state.registers[vdst].type_of_data = 'i32' \
                                if decompiler_data.type_params.get("*" + argument) == "int" \
                                else 'u32'
                        elif decompiler_data.type_params.get("*" + argument) == "long" \
                                or decompiler_data.type_params.get("*" + argument) == "ulong":
                            new_value, src0_flag, src1_flag = make_op(node, src1, "8", " / ", '', '')
                            new_val = argument + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                            node.state.registers[vdst].type_of_data = 'i64' \
                                if decompiler_data.type_params.get("*" + argument) == "long" \
                                else 'u64'
                        elif decompiler_data.type_params.get("*" + argument) == "char" \
                                or decompiler_data.type_params.get("*" + argument) == "uchar":
                            new_val = argument + "[" + node.state.registers[src1].val + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                        elif decompiler_data.type_params.get("*" + argument) == "float":
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "4", " / ", '', '')
                            new_val = argument + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                            node.state.registers[vdst].type_of_data = 'f32'
                        elif decompiler_data.type_params.get("*" + argument) == "double":
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "8", " / ", '', '')
                            new_val = argument + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                            node.state.registers[vdst].type_of_data = 'f64'
                        elif decompiler_data.type_params.get("*" + argument) == "int2":
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "8", " / ", '', '')
                            new_val = argument + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                            node.state.registers[vdst].type_of_data = 'int2'
                        elif decompiler_data.type_params.get("*" + argument) == "int4":
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "16", " / ", '', '')
                            new_val = argument + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                            node.state.registers[vdst].type_of_data = 'int4'
                        elif decompiler_data.type_params.get("*" + argument) == "int8":
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "32", " / ", '', '')
                            new_val = argument + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                            node.state.registers[vdst].type_of_data = 'int8'
                        else:
                            new_value, src0_flag, src1_flag = make_op(node, src1, "8", " / ", '', '')
                            new_val = argument + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.param_global_id_x, new_integrity)
                            node.state.registers[vdst].type_of_data = 'int2'
                    elif node.state.registers[src0].type == RegisterType.global_data_pointer:
                        type_of_data = node.state.registers[src1].type_of_data
                        name = node.state.registers[src0].val
                        if 'bytes' in type_of_data:
                            position = type_of_data.find(' ')
                            value = type_of_data[:position]
                            new_value, src0_flag, src1_flag = make_op(node, src1, value, " / ", '', '')
                            new_val = name + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, RegisterType.global_data_pointer, Integrity.entire)
                            suffix = type_of_data
                    elif node.state.registers[src0].type == RegisterType.work_group_id_x_local_size and \
                            node.state.registers[src1].type == RegisterType.work_item_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(0) - get_global_offset(0)", RegisterType.work_group_id_x_work_item_id,
                                     new_integrity)
                    elif node.state.registers[src0].type == RegisterType.work_group_id_y_local_size and \
                            node.state.registers[src1].type == RegisterType.work_item_id_y:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(1) - get_global_offset(1)", RegisterType.work_group_id_y_work_item_id,
                                     new_integrity)
                    elif node.state.registers[src0].type == RegisterType.work_group_id_z_local_size and \
                            node.state.registers[src1].type == RegisterType.work_item_id_z:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(2) - get_global_offset(2)", RegisterType.work_group_id_z_work_item_id,
                                     new_integrity)
                    elif node.state.registers[src0].type == RegisterType.work_group_id_x_local_size and \
                            node.state.registers[src1].type == RegisterType.work_item_id_x or \
                            node.state.registers[src1].type == RegisterType.work_group_id_x_local_size and \
                            node.state.registers[src0].type == RegisterType.work_item_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(0) - get_global_offset(0)", RegisterType.unknown, new_integrity)
                    else:
                        type_of_data = node.state.registers[src1].type_of_data
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register(new_val, RegisterType.unknown, new_integrity)
                        node.state.registers[vdst].type_of_data = type_of_data
                else:
                    type_reg = RegisterType.int32
                    if src0_reg:
                        type_reg = node.state.registers[src0].type
                    if src1_reg:
                        type_reg = node.state.registers[src1].type
                    node.state.registers[vdst] = Register(new_val, type_reg, Integrity.entire)
                decompiler_data.make_version(node.state, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                if node.state.registers[vdst].type_of_data is None:
                    node.state.registers[vdst].type_of_data = suffix
                return node
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
            if flag_of_status == OperationStatus.to_fill_node:
                suffix = most_common_type(node.state.registers[from_registers_src0].type_of_data,
                                          node.state.registers[from_registers_src1].type_of_data)
                type_reg = node.state.registers[from_registers_src1].type
                new_val = node.state.registers[from_registers_src1].val
                node.state.registers[to_registers] = Register(new_val, type_reg, Integrity.entire)
                decompiler_data.make_version(node.state, to_registers)
                if node.state.registers[to_registers].type_of_data is None:
                    node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string
