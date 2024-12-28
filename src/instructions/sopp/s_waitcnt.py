from src.base_instruction import BaseInstruction


class SWaitcnt(BaseInstruction):
    def to_fill_node(self):
        return self.node

    def to_print(self):
        if "ds" in self.node.parent[0].instruction[0]:
            self.output_string = "barrier(CLK_LOCAL_MEM_FENCE)"
        return self.output_string
