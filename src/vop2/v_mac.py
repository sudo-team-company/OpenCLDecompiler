from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class VMac(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]

        if suffix == "f32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = as_float(" + src0 + ") * as_float("
                                      + src1 + ") + as_float(" + vdst + ") // v_mac_f32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_reg, src1_reg = make_op(node, src0, src1, " * ", 'as_float(', 'as_float(')
                new_value = new_val + " + as_float(" + node.state.registers[vdst].val + ')'
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string
