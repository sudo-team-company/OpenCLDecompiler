from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
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
                return update_register('u32', 'float', from_registers, to_registers, node)

        elif suffix == "f64_i32":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(int)" + from_registers + " // v_cvt_f64_i32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('i32', 'double', from_registers, to_registers, node)
        elif suffix == "f64_u32":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(int)" + from_registers + " // v_cvt_f64_i32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('u32', 'double', from_registers, to_registers, node)
        elif suffix == "i32_f64":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(int)" + from_registers + " // v_cvt_f64_i32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('f64', 'int', from_registers, to_registers, node)
        elif suffix == "u32_f64":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (double)(int)" + from_registers + " // v_cvt_f64_i32\n")
                return node
            elif flag_of_status == OperationStatus.to_fill_node:
                return update_register('f64', 'uint', from_registers, to_registers, node)
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
            if flag_of_status == OperationStatus.to_fill_node:
                return update_register('f32', 'int', from_registers, to_registers, node)
        elif suffix == "f32_i32":
            vdst = instruction[1]
            src0 = instruction[2]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src0)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_fill_node:
                return update_register('i32', 'float', from_registers, to_registers, node)
        return output_string


def update_register(asm_type, opencl_type, from_registers, to_registers, node):
    decompiler_data = DecompilerData()
    decompiler_data.names_of_vars[node.state.registers[from_registers].val] = asm_type
    new_val = node.state.registers[from_registers].val
    type = node.state.registers[from_registers].type
    node.state.registers[to_registers] = Register(new_val, type, Integrity.entire)
    node.state.registers[to_registers].type_of_data = asm_type
    return node
