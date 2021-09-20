from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType


def v_sub_fill_node(node, src0_reg, src1_reg, src0, src1, vdst, new_value, suffix):
    reg_type = RegisterType.int32
    if src0_reg:
        reg_type = node.state.registers[src0].integrity
    elif src1_reg:
        reg_type = node.state.registers[src1].integrity
    return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix, reg_type=reg_type)


class VSub(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""

        if suffix == "u32":
            vdst = instruction[1]
            vcc = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                mask = "mask" + str(decompiler_data.number_of_mask)
                decompiler_data.write("ulong " + temp + " = (ulong)" + src0 + " - (ulong)" + src1 + " // v_sub_u32\n")
                decompiler_data.write(vdst + " = CLAMP ? (" + temp + ">>32 ? 0 : " + temp + ") : " + temp + "\n")
                decompiler_data.write(vcc + " = 0\n")  # vop2, sdst
                decompiler_data.write("ulong " + mask + " = (1ULL<<LANEID)\n")
                decompiler_data.write(vcc + " = (" + vcc + "&~" + mask + ") | (("
                                      + temp + ">>32) ? " + mask + " : 0)\n")
                decompiler_data.number_of_temp += 1
                decompiler_data.number_of_mask += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_reg, src1_reg = make_op(node, src0, src1, " - ", '(ulong)', '')
                return v_sub_fill_node(node, src0_reg, src1_reg, src0, src1, vdst, new_val, suffix)
            if flag_of_status == OperationStatus:
                return output_string

        if suffix == "f32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = as_float(" + src0 + ") - as_float(" + src1 + ") // v_sub_f32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_reg, src1_reg = make_op(node, src0, src1, " - ", 'as_float(', 'as_float(')
                return v_sub_fill_node(node, src0_reg, src1_reg, src0, src1, vdst, new_val, suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string
