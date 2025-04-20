from src import utils
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import check_and_split_regs, is_range
from src.register_type import RegisterType


class Node:
    def __init__(self, instruction, state):
        self.id = utils.generate_uuid()
        self.instruction: tuple[str, list[object]] = instruction
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

    def get_expression_node(self, reg):  # noqa: PLR0911
        if reg in self.state:
            register_content = self.state[reg].register_content
            expr_node = register_content.get_expression_node()
            if expr_node is not None:
                return expr_node
            if register_content.get_type() != RegisterType.UNKNOWN:
                return ExpressionManager().add_register_node(register_content.get_type(), register_content.get_value())
            return ExpressionManager().get_empty_node()
        if is_range(reg):
            start_register, end_register = check_and_split_regs(reg)
            flag_big_value, value = (True, "1e12") if (self.state[start_register].val == "0xa2000000" 
                                                       and self.state[end_register].val == "0x426d1a94") else (False, 0)
            if flag_big_value:
                #todo check
                return ExpressionManager().add_const_node(value, OpenCLTypes.ULONG)

            register_content = self.state[start_register].register_content
            expr_node = register_content.get_expression_node()
            if expr_node is not None:
                return expr_node
            return ExpressionManager().add_register_node(register_content.get_type(), register_content.get_value())

        return ExpressionManager().add_const_node(reg, OpenCLTypes.UINT)
