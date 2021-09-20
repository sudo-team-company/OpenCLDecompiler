from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.operation_status import OperationStatus


class SCselect(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'b64':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = scc ? " + ssrc0 + " : " + ssrc1 + " // s_cselect_b64\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                if ssrc0 == "exec":
                    ssrc0 = "1"
                new_value = node.state.registers["scc"].val + " ? " + ssrc0 + " : " + ssrc1
                return make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], suffix)
            if flag_of_status == OperationStatus.to_print:
                return output_string
