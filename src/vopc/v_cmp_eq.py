from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.opencl_types import make_type
from src.operation_status import OperationStatus
from src.register import Register
from src.type_of_reg import Type


class VCmpEq(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "u32" or suffix == "i32" or suffix == 'f32':
            if suffix != 'f32':
                new_as_type = '(' + make_type(suffix) + ')'
            else:
                new_as_type = 'as_float('
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                if suffix != 'f32':
                    decompiler_data.write(sdst + "(LANEID) = " + new_as_type + src0
                                          + " == " + new_as_type + src1 + " // v_cmp_eq_" + suffix + "\n")
                    return node
                else:
                    decompiler_data.write(sdst + "(LANEID) = as_float(" + src0 + ") == as_float("
                                          + src1 + ") // v_cmp_eq_" + suffix + "\n")
                    return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_flag, src1_flag = make_op(node, src0, src1, " == ", new_as_type, new_as_type)
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.entire)
                decompiler_data.make_version(node.state, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
