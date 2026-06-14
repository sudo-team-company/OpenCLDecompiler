from src import utils
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import BaseReg, RegOrVal_ty, Val, expand_register_names, is_range
from src.register_type import RegisterType


class Node:
    def __init__(self, instruction, operands, state):
        self.id = utils.generate_uuid()
        self.instruction: str = instruction
        self.operands: tuple[RegOrVal_ty, ...] = operands
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

    def get_from_state(self, reg):
        assert isinstance(reg, BaseReg)
        return self.state.get(reg.name)

    def get_or_add_expression_node(self, reg, instruction_type_hint: OpenCLTypes):  # noqa: PLR0911
        assert isinstance(reg, BaseReg | Val)

        if reg.name in self.state:
            register_content = self.state[reg.name].register_content
            expr_node = register_content.get_expression_node()
            if expr_node is not None:
                return expr_node
            if register_content.get_type() != RegisterType.UNKNOWN:
                return ExpressionManager().add_register_node(register_content.get_type(), register_content.get_value())
            return ExpressionManager().get_empty_node()
        if is_range(reg):
            regs = expand_register_names(reg)
            start_register, end_register = regs[0], regs[-1]

            def check_big_values_new(node, start_register, end_register):
                if node.state[start_register].val == "0xa2000000" and node.state[end_register].val == "0x426d1a94":
                    return True, "1e12"
                return False, 0

            flag_big_value, value = check_big_values_new(self, start_register, end_register)
            if flag_big_value:
                return ExpressionManager().add_const_node(value, instruction_type_hint)

            register_content = self.state[start_register].register_content
            expr_node = register_content.get_expression_node()
            if expr_node is not None:
                return expr_node
            return ExpressionManager().add_register_node(register_content.get_type(), register_content.get_value())

        return ExpressionManager().add_const_node(reg.name, instruction_type_hint)
