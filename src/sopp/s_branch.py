from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SBranch(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        reladdr = instruction[1]
        if flag_of_status == OperationStatus.to_print_unresolved:
            decompiler_data.write("pc = " + reladdr + " // s_branch\n")
            decompiler_data.write("goto " + reladdr + "\n")
            return node
        if flag_of_status == OperationStatus.to_fill_node:
            node = DecompilerData().to_fill_node(node, instruction)
            node.instruction = "branch"
            return node
        if flag_of_status == OperationStatus.to_print:
            return output_string
