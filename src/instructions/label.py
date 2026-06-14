import copy

from src.base_instruction import BaseInstruction


class Label(BaseInstruction):
    def to_fill_node(self):
        label = self.node.instruction
        self.decompiler_data.set_to_node(label, self.node)
        if self.decompiler_data.from_node.get(label) is not None:
            for from_node in self.decompiler_data.from_node[label]:
                from_node.add_child(self.node)
                self.node.add_parent(from_node)
                self.node.state = copy.deepcopy(self.node.parent[-1].state)
        return self.node
