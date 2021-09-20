from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class VMulF32(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]

        if suffix == "f32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = as_float(" + src0 + ") * as_float(" + src1 + ") // v_mul_f32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_integrity = node.state.registers[src1].integrity
                new_value, src0_reg, src1_reg = make_op(node, src0, src1, " * ", 'as_float(', 'as_float(')
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix, reg_entire=new_integrity)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        if suffix == "i32_i24":
            if flag_of_status == OperationStatus.to_print_unresolved:
                v0 = "V0" + str(decompiler_data.number_of_v0)
                v1 = "V1" + str(decompiler_data.number_of_v1)
                decompiler_data.write("int " + v0 + " (int)((" + src0 + "&0x7fffff) | ("
                                      + src0 + "&0x800000 ? 0xff800000 : 0)) // v_mul_i32_i24\n")
                decompiler_data.write("int " + v1 + " (int)((" + src1 + "&0x7fffff) | ("
                                      + src1 + "&0x800000 ? 0xff800000 : 0))\n")
                decompiler_data.write(vdst + " = " + v0 + " * " + v1 + "\n")
                decompiler_data.number_of_v0 += 1
                decompiler_data.number_of_v1 += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_integrity = node.state.registers[src1].integrity
                new_value, src0_reg, src1_reg = make_op(node, src0, src1, " * ", '(int)', '(int)')
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix, reg_entire=new_integrity)
            if flag_of_status == OperationStatus.to_print:
                return output_string
