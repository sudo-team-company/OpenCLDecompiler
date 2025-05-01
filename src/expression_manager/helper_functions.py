import re
from dataclasses import dataclass

from src.expression_manager.expression_node import (
    ExpressionNode,
    ExpressionOperationType,
    ExpressionType,
    ExpressionValueTypeHint,
    TypeAddressSpaceQualifiers,
)
from src.expression_manager.types.opencl_types import OpenCLTypes, check_value_needs_cast
from src.model.kernel_argument import KernelArgument
from src.register_type import CONSTANT_VALUES, RegisterType


@dataclass
class VariableInfo:
    name: str = ""
    var_node: ExpressionNode = None
    value_node: ExpressionNode = None

def create_const_node(value, value_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
    const_node = ExpressionNode()
    const_node.type = ExpressionType.CONST
    const_node.value = value
    const_node.value_type_hint = value_type_hint
    return const_node

def create_var_node(var_name: str, var_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
    var_node = ExpressionNode()
    var_node.type = ExpressionType.VAR
    var_node.value = var_name
    var_node.value_type_hint = var_type_hint
    return var_node

def create_work_item_function_node(reg_type: RegisterType) -> ExpressionNode:
    work_item_function_node = ExpressionNode()
    work_item_function_node.type = ExpressionType.WORK_ITEM_FUNCTION
    work_item_function_node.value = reg_type
    work_item_function_node.value_type_hint = ExpressionValueTypeHint(
        OpenCLTypes.UINT if CONSTANT_VALUES[reg_type][1] == 32 else OpenCLTypes.ULONG)  # noqa: PLR2004
    return work_item_function_node

def create_op_node(
    op: ExpressionOperationType,
    left: ExpressionNode,
    right: ExpressionNode,
    value_type_hint: ExpressionValueTypeHint
) -> ExpressionNode:
    op_node = ExpressionNode()
    op_node.type = ExpressionType.OP
    op_node.value = op
    op_node.value_type_hint = value_type_hint
    op_node.left = left
    op_node.right = right
    left.parent = op_node
    right.parent = op_node
    return op_node

def create_if_ternary_node(
    cond: ExpressionNode,
    s0: ExpressionNode,
    s1: ExpressionNode
) -> ExpressionNode:
    if_ternary_node = ExpressionNode()
    if_ternary_node.type = ExpressionType.IF_TERNARY
    if_ternary_node.value = cond
    if_ternary_node.left = s0
    if_ternary_node.right = s1
    if_ternary_node.value_type_hint = ExpressionValueTypeHint.get_common_type(s0.value_type_hint, s1.value_type_hint)

    s0.parent = if_ternary_node
    s1.parent = if_ternary_node
    return if_ternary_node

def create_permute_node(
    s0: ExpressionNode,
    s1: ExpressionNode
) -> ExpressionNode:
    permute_node = ExpressionNode()
    permute_node.type = ExpressionType.PERMUTE
    permute_node.left = s0
    permute_node.right = s1

    s0.parent = permute_node
    s1.parent = permute_node

    common_type_hint = ExpressionValueTypeHint.get_common_type(s0.value_type_hint, s1.value_type_hint)
    common_type_hint = common_type_hint.set_number_of_components(
        s0.value_type_hint.number_of_components() + s1.value_type_hint.number_of_components())

    permute_node.value_type_hint = common_type_hint
    return permute_node

def create_logical_not_node(
    node: ExpressionNode
) -> ExpressionNode:
    logical_not_node = ExpressionNode()
    logical_not_node.type = ExpressionType.OP
    logical_not_node.value = ExpressionOperationType.NOT
    logical_not_node.value_type_hint = node.value_type_hint
    logical_not_node.left = node
    return logical_not_node

def evaluate_operation(# noqa: C901, PLR0912
        left_value,
        op: ExpressionOperationType,
        right_value,
        value_type_hint: ExpressionValueTypeHint):
    result = None
    if isinstance(left_value, str):
        left_value = int(left_value, base=16)
    if isinstance(right_value, str):
        right_value = int(right_value, base=16)
    match op:
        case ExpressionOperationType.PLUS:
            result = left_value + right_value
        case ExpressionOperationType.MINUS:
            result = left_value - right_value
        case ExpressionOperationType.MUL:
            result = left_value * right_value
        case ExpressionOperationType.DIV:
            # result = left_value // right_value if value_type_hint.is_integer() else left_value / right_value
            result = left_value / right_value
        case ExpressionOperationType.REM:
            result = left_value % right_value
        case ExpressionOperationType.LSHIFT:
            result = left_value << right_value
        case ExpressionOperationType.RSHIFT:
            result = left_value >> right_value
        case ExpressionOperationType.EQ:
            result = left_value == right_value
        case ExpressionOperationType.NE:
            result = left_value != right_value
        case ExpressionOperationType.LT:
            result = left_value < right_value
        case ExpressionOperationType.LE:
            result = left_value <= right_value
        case ExpressionOperationType.GT:
            result = left_value > right_value
        case ExpressionOperationType.GE:
            result = left_value >= right_value
        case ExpressionOperationType.LG:
            result = left_value > right_value or left_value < right_value
        case ExpressionOperationType.NOT:
            result = not left_value
        case ExpressionOperationType.AND:
            result = left_value and right_value
        case ExpressionOperationType.OR:
            result = left_value or right_value
        case ExpressionOperationType.XOR:
            result = left_value ^ right_value
        case ExpressionOperationType.BITWISE_AND:
            result = left_value & right_value
        case ExpressionOperationType.BITWISE_OR:
            result = left_value | right_value
    print("evalute:", left_value, op, right_value, result)
    return result

def parse_variable_name( var_name: str) -> tuple[str, bool]:
    if var_name[0] == "*":
        var_node_name = var_name[1:]
        is_pointer = True
    else:
        var_node_name = var_name
        is_pointer = False
    return (var_node_name, is_pointer)

def get_kernel_argument_type_and_qualifiers(
        arg: KernelArgument
    ) -> tuple[OpenCLTypes, TypeAddressSpaceQualifiers]:
    qualifier = TypeAddressSpaceQualifiers.UNKNOWN
    arg_type_str = arg.type_name
    if arg_type_str.startswith("__global "):
        arg_type_str = arg_type_str.removeprefix("__global ")
        qualifier = TypeAddressSpaceQualifiers.GLOBAL
    elif arg_type_str.startswith("__local "):
        arg_type_str = arg_type_str.removeprefix("__local ")
        qualifier = TypeAddressSpaceQualifiers.LOCAL
    elif arg_type_str.startswith("__private "):
        arg_type_str = arg_type_str.removeprefix("__private ")
        qualifier = TypeAddressSpaceQualifiers.PRIVATE
    elif arg_type_str.startswith("__constant "):
        arg_type_str = arg_type_str.removeprefix("__constant ")
        qualifier = TypeAddressSpaceQualifiers.CONST
    value_type_hint = OpenCLTypes.from_string(arg_type_str)

    return (value_type_hint, qualifier)

def get_sufficient_type_for_const(value, opencl_type_hint: OpenCLTypes) -> tuple[any, ExpressionValueTypeHint]:
    def get_min_sufficient_type_for_integer(value):
        signed = (value < 0)
        types_to_check = ([OpenCLTypes.CHAR, OpenCLTypes.SHORT, OpenCLTypes.INT, OpenCLTypes.LONG] if signed
                            else [OpenCLTypes.UCHAR, OpenCLTypes.USHORT, OpenCLTypes.UINT, OpenCLTypes.ULONG])
        for t in types_to_check:
            abs_max_value = pow(2, t.value.get_size() * 8)
            if signed:
                min_value, max_value = (-1 * abs_max_value / 2, abs_max_value / 2 - 1)
            else:
                min_value, max_value = (0, abs_max_value - 1)
            if value >= min_value and value <= max_value:
                return t
        return OpenCLTypes.UNKNOWN

    value_type_hint = ExpressionValueTypeHint(opencl_type_hint, is_const=True)

    if isinstance(value, str):
        if re.fullmatch(r"[\d]+e[\d]+", value) is not None:
            value_type_hint.opencl_type = OpenCLTypes.DOUBLE
        else:
            try:
                value = int(value)
                value_type_hint.opencl_type = get_min_sufficient_type_for_integer(value)
            except ValueError:
                try:
                    # we want to keep hex numbers as they are, so just find out sufficient type
                    hex_number = int(value, base=16)
                    value_type_hint.opencl_type = get_min_sufficient_type_for_integer(hex_number)
                except ValueError:
                    try:
                        decimals_after_point = len(value) - value.find(".")
                        value = float(value)
                        value_type_hint.opencl_type = OpenCLTypes.FLOAT if decimals_after_point <= 7 else OpenCLTypes.DOUBLE  # noqa: E501, PLR2004
                    except ValueError:
                        pass
    return (value, value_type_hint)

# PRINT functions
def expression_to_string(
        expression_node: ExpressionNode,
        cast_to: ExpressionValueTypeHint) -> str:
    assert expression_node is not None
    if expression_node.type == ExpressionType.OP:
        return op_expression_to_string_updated(expression_node, cast_to)
    # if expression_node.type == ExpressionType.VAR:
    #     return self._var_expression_to_string_updated(expression_node, cast_to)

    # cast_to = get_common_type(cast_to, expression_node.value_type_hint)

    output = ""
    if expression_node.type == ExpressionType.PERMUTE:
        # todo need brackets???
        left_value = expression_to_string(expression_node.left, expression_node.left.value_type_hint)
        right_value = expression_to_string(expression_node.right, expression_node.right.value_type_hint)
        output = f"{left_value}, {right_value}"
    elif expression_node.type == ExpressionType.IF_TERNARY:
        # todo need brackets?
        cond_value = expression_to_string(expression_node.value, cast_to)
        left_value = expression_to_string(expression_node.left, cast_to)
        right_value = expression_to_string(expression_node.right, cast_to)
        output =  f"({cond_value}) ? ({left_value}) : ({right_value})"
    elif expression_node.type == ExpressionType.WORK_ITEM_FUNCTION:
        return work_item_function_expression_to_string(expression_node)
    else:
        output = f"{expression_node.value}"
        if (cast_to.opencl_type not in (OpenCLTypes.UNKNOWN, expression_node.value_type_hint.opencl_type)
            and check_value_needs_cast(expression_node.value, expression_node.value_type_hint.opencl_type, cast_to.opencl_type)):
            output = f"({cast_to!s})" + output
    return output

def op_expression_to_string_updated(
        expression_node: ExpressionNode,
        cast_to: ExpressionValueTypeHint) -> str:
    assert expression_node is not None
    assert expression_node.type == ExpressionType.OP

    operation = expression_node.value
    left_node = expression_node.left
    right_node = expression_node.right

    if operation == ExpressionOperationType.NOT:
        return f"!({expression_to_string(left_node, OpenCLTypes.UNKNOWN)})"

    # special case for: data_ptr + smth => data_ptr[smth]
    if operation == ExpressionOperationType.PLUS and left_node.type == ExpressionType.VAR and left_node.value_type_hint.is_pointer and not left_node.value_type_hint.is_address:
        if expression_node.parent is None:
            return f"{left_node.value!s}[{expression_to_string(right_node, cast_to)}]"
        return f"{left_node.value!s}[{expression_to_string(right_node, cast_to)}"

    left_value = expression_to_string(
        left_node, cast_to
    )
    right_value = expression_to_string(
        right_node, cast_to
    )

    output = ""

    op_needs_additional_brackets = [ExpressionOperationType.DIV, ExpressionOperationType.MUL]
    op_doesnt_need_additional_brackets = [ExpressionOperationType.PLUS, ExpressionOperationType.MINUS]

    def check_needs_brackets_op_node(op: ExpressionOperationType, child_node: ExpressionNode) -> bool:
        if child_node.type == ExpressionType.OP:
            child_op: ExpressionOperationType = child_node.value
            if child_op.is_bitshift_operator() or child_op.is_bitwise_operator():
                return True
            if ExpressionOperationType.are_operations_inverted(op, child_op):
                return True
            if ExpressionOperationType.are_operations_inverted(op, child_op):
                return True
            if op == child_op and op == ExpressionOperationType.MINUS:
                return True
            return op != child_op
        elif child_node.type == ExpressionType.IF_TERNARY:
            return True
        # child_node.type is either CONST, WORK_ITEM_FUNCTION, VAR, PERMUTE
        return False

    if check_needs_brackets_op_node(operation, left_node) and "[" not in left_value:
        output += f"({left_value})"
    else:
        output += left_value

    output += f" {operation.value} "

    if check_needs_brackets_op_node(operation, right_node):
        output += f"({right_value})"
    else:
        output += right_value

    if "[" in left_value:
        output += "]"

    print("output:", output)
    if output == "2 + 0":
        pass
    return output

def var_expression_to_string_updated(var_node: ExpressionNode) -> str:
    assert var_node is not None
    assert var_node.type == ExpressionType.VAR

    var_name_str = var_node.value

    return f"{var_node.value_type_hint!s} {var_name_str}"

def work_item_function_expression_to_string(work_item_function_node: ExpressionNode) -> str:
    reg_type = work_item_function_node.value
    return  f"{CONSTANT_VALUES[reg_type][0]}"
