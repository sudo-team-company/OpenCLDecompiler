from src.base_instruction import BaseInstruction
from src.operation_status import OperationStatus


class SWaitcnt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        output_string = ""
        if flag_of_status == OperationStatus.to_print_unresolved:
            return None
        if flag_of_status == OperationStatus.to_fill_node:
            return node
        if flag_of_status == OperationStatus.to_print:
            if 'ds' in node.parent[0].instruction[0]:
                output_string = "barrier(CLK_LOCAL_MEM_FENCE)"
            return output_string
