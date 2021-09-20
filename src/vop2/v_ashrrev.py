from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from


class VAshrrev(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]

        if suffix == "i32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (int)" + src1 + " >> (" + src0 + "&31) // v_ashrrev_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value = node.state.registers[src1].val
                reg_type = node.state.registers[src1].type
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        elif suffix == "i64":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (long)" + src1 + " >> (" + src0 + "&63) // v_ashrrev_i64\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(vdst, src1)
                from_registers = name_of_from + str(first_from)
                to_registers = name_of_to + str(first_to)
                if node.state.registers[from_registers].val == "0":
                    node.state.registers[from_registers].val = \
                        node.state.registers[name_of_from + str(first_from + 1)].val
                new_value, src1_flag, src0_flag = make_op(node, from_registers, str(pow(2, int(src0))),
                                                          " / ", '', '(long)')
                reg_type = node.state.registers[from_registers].type
                node = make_new_value_for_reg(node, new_value, to_registers, [from_registers], suffix,
                                              reg_type=reg_type, reg_entire=Integrity.low_part)
                to_registers_1 = name_of_to + str(last_to)
                from_registers_1 = name_of_from + str(last_from)
                node = make_new_value_for_reg(node, new_value, to_registers_1, [from_registers_1], suffix,
                                              reg_type=reg_type, reg_entire=Integrity.high_part)
                return node
            if flag_of_status == OperationStatus.to_print:
                return output_string  # из vop3
