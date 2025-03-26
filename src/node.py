from src.types.opencl_types import OpenCLTypes
from src.expression_manager.expression_manager import ExpressionManager
from src import utils
from src.register import is_reg
from src.register_content import CONSTANT_VALUES
from src.register_type import RegisterType


class Node:
    def __init__(self, instruction, state):
        self.id = utils.generate_uuid()
        self.instruction: (str, list[object]) = instruction
        self.children = []
        self.parent = []
        self.state = state
        self.exclude_unrolled: bool = False

    def add_child(self, child):
        self.children.append(child)

    def add_first_child(self, child):
        self.children.insert(0, child)

    def add_parent(self, parent):
        self.parent.append(parent)

    #todo - maybe this needs to be moved somewhere else
    def get_expression_node(self, reg):
        if is_reg(reg):
            register_content = self.state[reg].register_content
            if register_content._expression_node is not None:
                return register_content._expression_node
            else:
                return ExpressionManager().add_register_node(register_content._type, register_content._value)
        else:
            return ExpressionManager().add_const_node(reg, OpenCLTypes.UINT)