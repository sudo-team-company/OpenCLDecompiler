from src.base_instruction import BaseInstruction


class SAndSaveexec(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        output_string = ""
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            if flag_of_status:
                node.state.registers[sdst] = node.state.registers["exec"]
                node.state.registers["exec"] = node.state.registers[ssrc0]
                return node
            return output_string
