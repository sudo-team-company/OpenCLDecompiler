from src.base_instruction import BaseInstruction


class SWaitcnt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        output_string = ""
        if flag_of_status:
            return node
        if node.parent[0].instruction[0].find("ds") != -1:
            output_string = "barrier(CLK_LOCAL_MEM_FENCE)"
        return output_string
