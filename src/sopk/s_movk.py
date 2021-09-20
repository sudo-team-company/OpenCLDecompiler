from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.operation_status import OperationStatus


class SMovk(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        simm16 = instruction[2]

        if suffix == 'i32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("scc = " + simm16 + " // s_movk_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return make_new_value_for_reg(node, simm16, sdst, [], suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string
