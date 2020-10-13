from src.base_instruction import BaseInstruction
from src.operation_status import OperationStatus


class SEndpgm(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        output_string = ""
        if flag_of_status == OperationStatus.to_fill_node:
            return node
        return output_string
