from src import utils

from src import base


class Node:
    def __init__(self, instruction, state):
        self.id = utils.generate_uuid()
        self.instruction: base.Instruction = instruction
        self.children = []
        self.parent = []
        self.state = state

    def add_child(self, child):
        self.children.append(child)

    def add_first_child(self, child):
        self.children.insert(0, child)

    def add_parent(self, parent):
        self.parent.append(parent)
