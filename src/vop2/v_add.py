from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


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
                    if node.state.registers[src0].type == Type.work_group_id_x_local_size_offset and \
                            node.state.registers[src1].type == Type.work_item_id_x or \
                            node.state.registers[src0].type == Type.global_offset_x and \
                            node.state.registers[src1].type == Type.work_group_id_x_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(0)", Type.global_id_x, new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_y_local_size_offset and \
                            node.state.registers[src1].type == Type.work_item_id_y or \
                            node.state.registers[src0].type == Type.global_offset_y and \
                            node.state.registers[src1].type == Type.work_group_id_y_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(1)", Type.global_id_y, new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_z_local_size_offset and \
                            node.state.registers[src1].type == Type.work_item_id_z or \
                            node.state.registers[src0].type == Type.global_offset_z and \
                            node.state.registers[src1].type == Type.work_group_id_z_work_item_id or \
                            node.state.registers[src1].type == Type.global_offset_z and \
                            node.state.registers[src0].type == Type.work_group_id_z_work_item_id:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register("get_global_id(2)", Type.global_id_z, new_integrity)
                    elif node.state.registers[src0].type == Type.paramA:
                        new_integrity = node.state.registers[src1].integrity
                        if decompiler_data.type_params.get("*" + node.state.registers[src0].val) == "int" \
                                or decompiler_data.type_params.get("*" + node.state.registers[src0].val) == "uint":
                            if "1073741824" in node.state.registers[src1].val:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "1073741824", " * ", '', '')
                            else:
                                new_value, src0_flag, src1_flag = make_op(node, src1, "4", " / ", '', '')
                            new_val = node.state.registers[src0].val + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, Type.param_global_id_x, new_integrity)
                        elif decompiler_data.type_params.get("*" + node.state.registers[src0].val) == "long" \
                                or decompiler_data.type_params.get("*" + node.state.registers[src0].val) == "ulong":
                            new_value, src0_flag, src1_flag = make_op(node, src1, "8", " / ", '', '')
                            new_val = node.state.registers[src0].val + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, Type.param_global_id_x, new_integrity)
                        elif decompiler_data.type_params.get("*" + node.state.registers[src0].val) == "char" \
                                or decompiler_data.type_params.get("*" + node.state.registers[src0].val) == "uchar":
                            new_val = node.state.registers[src0].val + "[" + node.state.registers[src1].val + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, Type.param_global_id_x, new_integrity)
                        elif decompiler_data.type_params.get("*" + node.state.registers[src0].val) == "float":
                            new_value, src0_flag, src1_flag = make_op(node, src1, "4", " / ", '', '')
                            new_val = node.state.registers[src0].val + "[" + new_value + "]"
                            node.state.registers[vdst] = \
                                Register(new_val, Type.param_global_id_x, new_integrity)

                    elif node.state.registers[src0].type == Type.work_group_id_x_local_size and \
                            node.state.registers[src1].type == Type.work_item_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(0) - get_global_offset(0)", Type.work_group_id_x_work_item_id,
                                     new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_y_local_size and \
                            node.state.registers[src1].type == Type.work_item_id_y:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(1) - get_global_offset(1)", Type.work_group_id_y_work_item_id,
                                     new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_z_local_size and \
                            node.state.registers[src1].type == Type.work_item_id_z:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(2) - get_global_offset(2)", Type.work_group_id_z_work_item_id,
                                     new_integrity)
                    elif node.state.registers[src0].type == Type.work_group_id_x_local_size and \
                            node.state.registers[src1].type == Type.work_item_id_x or \
                            node.state.registers[src1].type == Type.work_group_id_x_local_size and \
                            node.state.registers[src0].type == Type.work_item_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register("get_global_id(0) - get_global_offset(0)", Type.unknown, new_integrity)
                    else:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                else:
                    type_reg = Type.int32
                    if src0_reg:
                        type_reg = node.state.registers[src0].type
                    if src1_reg:
                        type_reg = node.state.registers[src1].type
                    node.state.registers[vdst] = Register(new_val, type_reg, Integrity.integer)
                decompiler_data.make_version(node.state, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
