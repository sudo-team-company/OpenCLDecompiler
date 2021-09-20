from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from


def v_cvt_fill_node(asm_type, from_registers, to_registers, node):
    decompiler_data = DecompilerData()
    decompiler_data.names_of_vars[node.state.registers[from_registers].val] = asm_type
    new_value = node.state.registers[from_registers].val
    reg_type = node.state.registers[from_registers].type
    return make_new_value_for_reg(node, new_value, to_registers, [], asm_type, reg_type=reg_type)


class VCvt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        tab = "    "
        vdst = instruction[1]
        src0 = instruction[2]

        first_to, last_to, name_of_to, name_of_from, first_from, last_from \
            = find_first_last_num_to_from(vdst, src0)
        from_registers = name_of_from + str(first_from)
        to_registers = name_of_to + str(first_to)

        if suffix == "f32_u32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (float)" + src0 + " // v_cvt_f32_u32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return v_cvt_fill_node('u32', from_registers, to_registers, node)

        elif suffix == "f64_i32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(int)" + src0 + " // v_cvt_f64_i32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return v_cvt_fill_node('i32', from_registers, to_registers, node)

        elif suffix == "f64_u32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(uint)" + src0 + " // v_cvt_f64_u32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return v_cvt_fill_node('u32', from_registers, to_registers, node)

        elif suffix == "i32_f64":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (int)(double)" + src0 + " // v_cvt_i32_f64\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return v_cvt_fill_node('f64', from_registers, to_registers, node)

        elif suffix == "u32_f64":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (uint)(double)" + src0 + " // v_cvt_u32_f64\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return v_cvt_fill_node('f64', from_registers, to_registers, node)

        elif suffix == "u32_f32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(instruction[1] + " = 0 // v_cvt_u32_f32\n")
                decompiler_data.write("if (!isnan(as_float(" + src0 + ")))\n")
                decompiler_data.write(tab + vdst + " = (int)min(convert_int_rtz(as_float("
                                      + src0 + ")), 4294967295.0)\n")
                return node

        elif suffix == "i32_f32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (int)(float)" + src0 + " // v_cvt_i32_f32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return v_cvt_fill_node('f32', from_registers, to_registers, node)

        elif suffix == "f32_i32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (float)(int)" + src0 + " // v_cvt_f32_i32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return v_cvt_fill_node('i32', from_registers, to_registers, node)

        if flag_of_status == OperationStatus.to_print:
            return output_string
