from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.operation_status import OperationStatus


class SMin(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'i32':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = min((int)" + ssrc0 + ", (int)" + ssrc1 + ") // s_min_i32\n")
                decompiler_data.write("scc = (int)" + ssrc0 + " < (int)" + ssrc1 + "\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value = "min((int)" + node.state.registers[ssrc0].val + ", (int)" \
                            + node.state.registers[ssrc1].val + ")"
                return make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string
