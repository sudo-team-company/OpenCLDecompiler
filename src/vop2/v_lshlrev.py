from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.register_type import RegisterType
from src.upload import find_first_last_num_to_from


class VLshlrev(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]

        if suffix == "b32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = " + src1 + " << (" + src0 + "&31) // v_lshlrev_b32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, _, _ = make_op(node, src1, str(pow(2, int(src0))), " * ", '', '')
                reg_type = node.state.registers[src1].type
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        elif suffix == "b64":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = " + src1 + " << (" + src0 + "&63) // v_lshlrev_b64\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(vdst, src1)
                if "s" in name_of_from or "v" in name_of_from:
                    from_registers = name_of_from + str(first_from)
                else:
                    from_registers = src1
                to_registers = name_of_to + str(first_to)
                to_registers1 = name_of_to + str(last_to)
                from_registers1 = name_of_from + str(first_from + 1)
                new_value0, src1_flag, src0_flag = make_op(node, from_registers, str(pow(2, int(src0))), " * ", '', '')
                new_value1, src1_flag, src0_flag = make_op(node, from_registers1, str(pow(2, int(src0))), " * ", '', '')
                new_integrity0 = Integrity.low_part
                new_integrity1 = Integrity.high_part
                if src0_flag and src1_flag:
                    reg_type = node.state.registers[from_registers].type
                    if not (node.state.registers[from_registers].type
                            in [RegisterType.global_id_x, RegisterType.global_id_y, RegisterType.global_id_z]
                            and node.state.registers[name_of_to + str(first_from + 1)].val == "0"):
                        new_value0 = node.state.registers[from_registers]
                        new_value1 = node.state.registers[from_registers1]
                else:
                    reg_type = RegisterType.int32
                    if src0_flag:
                        reg_type = node.state.registers[src0].type
                    if src1_flag:
                        reg_type = node.state.registers[from_registers].type
                type_of_value = suffix
                if src0_flag:
                    type_of_value = str(pow(2, int(src1))) + ' bytes'
                elif src1_flag:
                    type_of_value = str(pow(2, int(src0))) + ' bytes'
                node = make_new_value_for_reg(node, new_value0, to_registers, [from_registers], type_of_value,
                                              reg_type=reg_type, reg_entire=new_integrity0)
                node = make_new_value_for_reg(node, new_value1, to_registers1, [from_registers1], type_of_value,
                                              reg_type=reg_type, reg_entire=new_integrity1)
                return node
            if flag_of_status == OperationStatus:
                return output_string  # из vop3
