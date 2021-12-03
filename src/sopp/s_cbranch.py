from src.base_instruction import BaseInstruction


class SCbranch(BaseInstruction):
    def to_fill_node(self):
        return self.decompiler_data.to_fill_branch_node(self.node, self.instruction)

    def to_print(self):
        raise NotImplementedError
