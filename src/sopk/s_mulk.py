from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class SMulk(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        simm16 = instruction[2][instruction[2].find("x") + 1:]

        if suffix == 'i32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + sdst + " * " + simm16 + " // s_mulk_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, sdst_flag, simm16_flag = make_op(node, sdst, simm16, " * ", '', '')
                return make_new_value_for_reg(node, new_value, sdst, [sdst], suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string
