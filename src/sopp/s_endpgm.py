from base_instruction import BaseInstruction


class SEndpgm(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        if flag_of_status:
            return node
        return output_string
