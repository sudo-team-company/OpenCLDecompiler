from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SAndSaveexec(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]

        if suffix == 'b64':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + "exec // s_and_saveexec_b64\n")
                decompiler_data.write("exec = " + ssrc0 + " & exec\n")
                decompiler_data.write("scc = exec != 0\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                node.state.registers[sdst] = node.state.registers["exec"]
                node.state.registers["exec"] = node.state.registers[ssrc0]
                return node
            if flag_of_status == OperationStatus.to_print:
                return output_string
