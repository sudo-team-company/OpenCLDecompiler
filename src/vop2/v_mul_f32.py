from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class VMulF32(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "f32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = as_float(" + src0 + ") * as_float(" + src1 + ") // v_mul_f32 \n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_integrity = node.state.registers[src1].integrity
                new_val, src0_reg, src1_reg = make_op(node, src0, src1, " * ", 'as_float(', 'as_float(')
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                decompiler_data.make_version(node.state, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

        if suffix == "i32_i24":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                v0 = "V0" + str(decompiler_data.number_of_v0)
                v1 = "V1" + str(decompiler_data.number_of_v1)
                decompiler_data.write("int " + v0 + " (int)((" + src0 + "&0x7fffff) | ("
                                      + src0 + "&0x800000 ? 0xff800000 : 0)) // v_mul_i32_i24 \n")
                decompiler_data.write("int " + v1 + " (int)((" + src1 + "&0x7fffff) | ("
                                      + src1 + "&0x800000 ? 0xff800000 : 0))\n")
                decompiler_data.write(vdst + " = " + v0 + " * " + v1 + "\n")
                decompiler_data.number_of_v0 += 1
                decompiler_data.number_of_v1 += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_integrity = node.state.registers[src1].integrity
                new_val, src0_reg, src1_reg = make_op(node, src0, src1, " * ", '(int)', '(int)')
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                decompiler_data.make_version(node.state, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
