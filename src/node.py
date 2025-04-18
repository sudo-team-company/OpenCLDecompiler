from src.expression_manager.expression_node import ExpressionNode
from src.register_type import RegisterType
from src.types.opencl_types import OpenCLTypes
from src.expression_manager.expression_manager import ExpressionManager
from src import utils
from src.register import check_and_split_regs, is_range, is_reg

#todo remove it from other place
def check_big_values_new(node, start_register, end_register):
    if node.state[start_register].val == "0xa2000000" and node.state[end_register].val == "0x426d1a94":
        return True, "1e12"
    return False, 0

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

    #todo - maybe this needs to be moved somewhere else
    def get_expression_node(self, reg):
        # if is_reg(reg) or is_range(reg) or reg == "exec":
        if reg in self.state:
            register_content = self.state[reg].register_content
            expr_node = register_content.get_expression_node()
            if expr_node is not None:
                return expr_node
            else:
                if register_content._type != RegisterType.UNKNOWN:
                    return ExpressionManager().add_register_node(register_content._type, register_content._value)
                else:
                    return ExpressionManager().get_empty_node()
        elif is_range(reg):
            start_register, end_register = check_and_split_regs(reg)
            flag_big_value, value = check_big_values_new(self, start_register, end_register)
            if flag_big_value:
                #todo check
                return ExpressionManager().add_const_node(value, OpenCLTypes.ULONG)
            
            register_content = self.state[start_register].register_content
            expr_node = register_content.get_expression_node()
            if expr_node is not None:
                return expr_node
            else:
                return ExpressionManager().add_register_node(register_content._type, register_content._value)
        
        return ExpressionManager().add_const_node(reg, OpenCLTypes.UINT)