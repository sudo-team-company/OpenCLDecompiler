from src.base_instruction import BaseInstruction


class SSendmsg(BaseInstruction):
    def to_fill_node(self):
        return self.node
