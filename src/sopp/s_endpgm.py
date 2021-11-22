from src.base_instruction import BaseInstruction


class SEndpgm(BaseInstruction):
    def to_print_unresolved(self):
        return self.node

    def to_fill_node(self):
        return self.node
