from src.base_instruction import BaseInstruction
from src.operation_status import OperationStatus
from src.decompiler_data import DecompilerData


class SAnd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'b32' or suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " & " + ssrc1 + " // s_and_" + suffix + " \n")
                decompiler_data.write("scc" + " = " + sdst + " != 0\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                node.state.registers[sdst] = node.state.registers[ssrc0]
                return node
            return output_string
