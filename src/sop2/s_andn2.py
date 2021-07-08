from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SAndn2(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " & ~" + ssrc1 + " // s_andn2_b64\n")
                decompiler_data.write("scc" + " = " + sdst + " != 0\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return node
            return output_string
