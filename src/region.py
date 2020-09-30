from src.type_of_node import TypeNode


class Region:
    def __init__(self, type_of_node, start):
        self.type: TypeNode = type_of_node
        self.start = start
        self.end = start
        self.parent = []
        self.children = []

    def add_child(self, child):
        self.children.append(child)

    def add_parent(self, parent):
        self.parent.append(parent)
