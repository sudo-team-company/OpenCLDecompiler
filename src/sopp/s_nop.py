from src.base_instruction import BaseInstruction
from src.operation_status import OperationStatus


class SNop(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        if flag_of_status == OperationStatus.to_print_unresolved:
            return None
        if flag_of_status == OperationStatus.to_fill_node:
            return node
        output_string = ''
        return output_string
