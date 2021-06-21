from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus
from src.decompiler_data import update_register
from src.upload import find_first_last_num_to_from


class VCvt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        tab = "    "
        if suffix == "f32_u32":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (float)" + src0 + " // v_cvt_f32_u32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('u32', from_registers, to_registers, node)

        elif suffix == "f64_i32":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(int)" + src0 + " // v_cvt_f64_i32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('i32', from_registers, to_registers, node)

        elif suffix == "f64_u32":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(uint)" + src0 + " // v_cvt_f64_u32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('u32', from_registers, to_registers, node)

        elif suffix == "i32_f64":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (int)(double)" + src0 + " // v_cvt_i32_f64\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('f64', from_registers, to_registers, node)

        elif suffix == "u32_f64":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (uint)(double)" + src0 + " // v_cvt_u32_f64\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('f64', from_registers, to_registers, node)

        elif suffix == "u32_f32":
            vdst = instruction[1]
            src0 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(instruction[1] + " = 0 // v_cvt_u32_f32\n")
                decompiler_data.write("if (!isnan(as_float(" + src0 + ")))\n")
                decompiler_data.write(tab + vdst + " = (int)min(convert_int_rtz(as_float("
                                      + src0 + ")), 4294967295.0)\n")
                return node

        elif suffix == "i32_f32":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (int)(float)" + src0 + " // v_cvt_i32_f32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('f32', from_registers, to_registers, node)

        elif suffix == "f32_i32":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (float)(int)" + src0 + " // v_cvt_f32_i32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('i32', from_registers, to_registers, node)
        return output_string
