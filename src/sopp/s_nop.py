from src.base_instruction import BaseInstruction
from src.operation_status import OperationStatus


class SNop(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        output_string = ''
        if flag_of_status == OperationStatus.to_print_unresolved:
            return None
        if flag_of_status == OperationStatus.to_fill_node:
            return node
        if flag_of_status == OperationStatus.to_print:
            return output_string
