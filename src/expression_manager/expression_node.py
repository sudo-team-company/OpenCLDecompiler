from dataclasses import dataclass, field
from enum import Enum, auto
import re

from src.types.opencl_types import *
from src.types.asm_types import *

class ExpressionEvaluationException(Exception):
    pass

class ExpressionType(Enum):
    UNKNOWN = auto()
    OP = auto()
    CONST = auto()
    VAR = auto()
    VAR_PTR = auto()

class ExpressionOperationType(Enum):
    def fromString(s: str):
        for expr_op_type in ExpressionOperationType:
            if s == expr_op_type.value:
                return expr_op_type
            
        assert(False)
        return ExpressionOperationType.UNKNOWN
    
    UNKNOWN = auto()

    PLUS = "+" # +
    MINUS = "-"
    MUL = "*" # *
    DIV = "/"
    REM = "%"

    EQ = "==" # ==
    NE = auto() # !=
    LT = auto() # <
    LE = auto() # <=
    GT = auto() # >
    GE = auto() # >=

    # other logical operator, see https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html

@dataclass
class ExpressionNode:
    left = None
    right = None
    parent = None
    type: ExpressionType = ExpressionType.UNKNOWN
    value: ExpressionOperationType | int | str = None
    value_type_hint : OpenCLTypes = field(default_factory=OpenCLTypes.UNKNOWN)

def expression_to_string_helper(expression_node: ExpressionNode, need_cast: bool = False) -> str:
    if expression_node is None:
        return "BROOO"
    
    match expression_node.type:
        case ExpressionType.OP:
            # special case for: data_ptr + smth => data_ptr[smth]
            if expression_node.value == ExpressionOperationType.PLUS and expression_node.left.type == ExpressionType.VAR_PTR:
                return f"{str(expression_node.left.value)}[{expression_to_string_helper(expression_node.right, False)}]"
            left_value = expression_to_string_helper(expression_node.left, check_nodes_need_cast_to(expression_node.left, expression_node))
            operator = str(expression_node.value.value)
            right_value = expression_to_string_helper(expression_node.right, check_nodes_need_cast_to(expression_node.right, expression_node))
            return f"{left_value} {operator} {right_value}"
        case _:
            ret_str = str(expression_node.value)
            if "-" in ret_str or "+" in ret_str or "*" in ret_str or "/" in ret_str:
                ret_str = f"({ret_str})"
            if need_cast:
                return f"({expression_node.parent.value_type_hint}){ret_str}"
            else:
                return f"{ret_str}"

def expression_to_string(expression_node: ExpressionNode) -> str:
    return expression_to_string_helper(expression_node)


def check_nodes_need_cast_to(expression_node: ExpressionNode, op_node: ExpressionNode) -> bool:
    if expression_node is None or expression_node.value_type_hint == OpenCLTypes.UNKNOWN or op_node is None or op_node.value_type_hint == OpenCLTypes.UNKNOWN:
        return True
    
    from_type: OpenCLType = expression_node.value_type_hint.value
    to_type: OpenCLType = op_node.value_type_hint.value

    if from_type == to_type:
        return False
    
    # if not from_type or not to_type:
    #     if re.fullmatch(r"[+-]?\d+([.,]\d+)?", value) is not None:
    #         return value[0] == "-" and re.fullmatch(r"g?[ub]\d+", from_type) is not None
    #     return (
    #         re.fullmatch(r"0x[\da-f]+", value) is None and re.fullmatch(r"[+-]?[\d,.]+([eE][+-]?\d+)?", value) is None
    #     )

    from_type_size = from_type.size_bytes
    from_type_component_count = from_type.number_of_components
    is_global_from_type = TypeModifiers.GLOBAL in from_type.modifiers

    to_type_size = to_type.size_bytes
    to_type_component_count = to_type.number_of_components
    is_global_to_type = TypeModifiers.GLOBAL in to_type.modifiers

    value = expression_node.value

    # strange case, but still
    if (is_global_from_type and not is_global_to_type) or (not is_global_from_type and is_global_to_type):
        return True
    needs_casting = True
    # same type, different size
    if (
        (from_type.is_signed and to_type.is_signed)
        or (not from_type.is_signed and not to_type.is_signed)
        or (not from_type.is_integer and not to_type.is_integer)
    ):
        needs_casting = (from_type_size > to_type_size) or (from_type_component_count != to_type_component_count)
    # from unsigned type to signed or from signed type to unsigned
    if (not from_type.is_signed and to_type.is_signed) or (
        from_type.is_signed and not to_type.is_signed
    ):
        needs_casting = (
            (
                (value[0] == "-" and value[1:].isnumeric())
                or re.fullmatch(r"\d+", value) is None
                or re.fullmatch(r"0x[\da-f]+", value) is None
            )
            or (from_type_size > to_type_size)
            or (from_type_component_count != to_type_component_count)
        )
    # from float to unsigned
    if not from_type.is_integer and not to_type.is_signed:
        try:
            float_value = float(value)
            needs_casting = (
                (float_value != int(float_value))
                or (float_value < 0)
                or (from_type_size > to_type_size)
                or (from_type_component_count != to_type_component_count)
            )
        except ValueError:
            return True
    # from float to signed
    if not from_type.is_integer and to_type.is_signed:
        try:
            float_value = float(value)
            needs_casting = (
                (float_value != int(float_value))
                or (from_type_size > to_type_size)
                or (from_type_component_count != to_type_component_count)
            )
        except ValueError:
            return True
    return needs_casting