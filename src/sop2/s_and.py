from src.base_instruction import BaseInstruction
from src.operation_status import OperationStatus


class SAnd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        output_string = ""
        if suffix == 'b32' or suffix == 'b64':
            if flag_of_status == OperationStatus.to_fill_node:
                sdst = instruction[1]
                ssrc0 = instruction[2]
                ssrc1 = instruction[3]
                node.state.registers[sdst] = node.state.registers[ssrc0]
                return node
            return output_string
