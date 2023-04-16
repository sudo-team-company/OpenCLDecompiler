import copy

from src.base_instruction import BaseInstruction


class Label(BaseInstruction):
    def to_fill_node(self):
        label = self.node.instruction[0][:-1]
        self.decompiler_data.set_to_node(label, self.node)
        if self.decompiler_data.from_node.get(label) is not None:
            for from_node in self.decompiler_data.from_node[label]:
                if 'scc1' not in from_node.instruction[0]:
                    from_node.add_child(self.node)
                else:
                    from_node.add_first_child(self.node)
                self.node.add_parent(from_node)
                self.node.state = copy.deepcopy(self.node.parent[-1].state)
        return self.node

    def to_print_unresolved(self):
        self.decompiler_data.write(self.node.instruction[0])
        return self.node