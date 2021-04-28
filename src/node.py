class Node:
    def __init__(self, instruction, state, is_gdata_next):
        self.instruction = instruction
        self.children = []
        self.parent = []
        self.state = state
        self.is_gdata_next = is_gdata_next

    def add_child(self, child):
        self.children.append(child)

    def add_first_child(self, child):
        self.children.insert(0, child)

    def add_parent(self, parent):
        self.parent.append(parent)
