from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values, DecompilerData
from src.operation_status import OperationStatus


class SCmpEq(BaseInstruction):
    # think about types and separate
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        ssrc0 = instruction[1]
        ssrc1 = instruction[2]

        if suffix in ['i32', 'u32', 'u64']:
            if suffix == 'u64':
                ssrc0 = ssrc0[0] + ssrc0[2: ssrc0.find(':')]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("scc = " + ssrc0 + "==" + ssrc1 + " // s_cmp_eq_" + suffix + "\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_values(node, "scc", ssrc0, ssrc1, "", "", " == ", suffix)
            return output_string
