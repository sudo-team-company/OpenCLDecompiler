from src.base_instruction import BaseInstruction


class SBarrier(BaseInstruction):
    def to_fill_node(self):
        return self.node

    def to_print(self):
        self.output_string = "barrier(CLK_LOCAL_MEM_FENCE)"
        return self.output_string
