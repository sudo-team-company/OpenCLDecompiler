import copy
import re
import uuid
from dataclasses import dataclass, field
from enum import Enum, auto

from src.expression_manager.types.opencl_types import OpenCLType, OpenCLTypes


class ExpressionEvaluationExceptionError(Exception):
    pass

class ExpressionType(Enum):
    UNKNOWN = auto()
    OP = auto()
    CONST = auto()
    WORK_ITEM_FUNCTION = auto()
    VAR = auto()
    PERMUTE = auto()
    IF_TERNARY = auto()


class ExpressionOperationType(Enum):
    def from_string(s: str):  # noqa: N805
        for expr_op_type in ExpressionOperationType:
            if s == expr_op_type.value:
                return expr_op_type

        assert False  # noqa: PT015
        return ExpressionOperationType.UNKNOWN

    def is_compare_operator(self):
        return (
            self == ExpressionOperationType.EQ  # noqa: PLR1714
            or self == ExpressionOperationType.NE
            or self == ExpressionOperationType.LT
            or self == ExpressionOperationType.LE
            or self == ExpressionOperationType.GT
            or self == ExpressionOperationType.GE
            or self == ExpressionOperationType.LG
        )

    def is_logical_operator(self):
        return (
            self == ExpressionOperationType.NOT  # noqa: PLR1714
            or self == ExpressionOperationType.AND
            or self == ExpressionOperationType.OR
            or self == ExpressionOperationType.XOR
        )

    def is_bitshift_operator(self):
        return self in (ExpressionOperationType.LSHIFT, ExpressionOperationType.RSHIFT)

    def is_bitwise_operator(self):
        return self in (ExpressionOperationType.BITWISE_AND, ExpressionOperationType.BITWISE_OR)

    UNKNOWN = "UNKNOWN"

    PLUS = "+"  # +
    MINUS = "-"
    MUL = "*"  # *
    DIV = "/"
    REM = "%"

    LSHIFT = "<<"
    RSHIFT = ">>"

    EQ = "=="  # ==
    NE = "!="  # !=
    LT = "<"  # <
    LE = "<="  # <=
    GT = ">"  # >
    GE = ">="  # >=
    LG = "<>"  # <>

    NOT = "!"
    AND = "&&"
    OR = "||"
    XOR = "^"

    BITWISE_AND = "&"
    BITWISE_OR = "|"

    # other logical operator, see https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html


@dataclass
class ExpressionNode:
    id: uuid.UUID = field(default_factory=lambda: uuid.uuid4())
    left: "ExpressionNode" = None
    right: "ExpressionNode" = None
    parent: "ExpressionNode" = None
    type: ExpressionType = ExpressionType.UNKNOWN
    value: ExpressionOperationType | int | str = None
    value_type_hint: OpenCLTypes = field(default_factory=lambda: OpenCLTypes.UNKNOWN)

    def __str__(self):
        return (
            f"Node {self.id}:\n"
            f"\tleft: {str(self.left.id) if self.left is not None else "None"}\n"
            f"\tright: {str(self.right.id) if self.right is not None else "None"}\n"
            f"\tparent: {str(self.parent.id) if self.parent is not None else "None"}\n"
            f"\ttype: {self.type!s}\n"
            f"\tvalue: {self.value!s}\n"
            f"\tvalue_type_hint: {self.value_type_hint}"
        )

    def __eq__(self, other: "ExpressionNode"):
        return (
            self.id == other.id
            and self.left == other.left
            and self.right == other.right
            and self.type == other.type
            and self.value == other.value
            and self.value_type_hint == other.value_type_hint
        )
    
    def contents_equal(self, other: "ExpressionNode"):
        return (
            self.type == other.type
            and self.value == other.value
            and self.value_type_hint == other.value_type_hint
        )

    def __add__(self, other: "ExpressionNode"):
        op_node = ExpressionNode()
        op_node.type = ExpressionType.OP
        op_node.value = ExpressionOperationType.PLUS
        op_node.value_type_hint = get_common_type(self.value_type_hint, other.value_type_hint)
        op_node.left = self
        op_node.right = other

        self.parent = op_node
        other.parent = op_node

        return op_node

    def invert(self) -> "ExpressionNode":
        return self

    def cast_to(self, to_type: OpenCLTypes) -> "ExpressionNode":  # noqa: ARG002
        return self

    def replace(self, from_node: "ExpressionNode", to_node: "ExpressionNode") -> "ExpressionNode":
        from src.expression_manager.expression_manager import ExpressionManager
        assert from_node is not None
        assert to_node is not None

        print("self:", ExpressionManager().expression_to_string(self))
        print("from_node:", ExpressionManager().expression_to_string(from_node))
        print("to_node:", ExpressionManager().expression_to_string(to_node))
        print("equal from", ExpressionManager().expression_to_string(self) == ExpressionManager().expression_to_string(from_node), self == from_node)
        print("equal to", ExpressionManager().expression_to_string(self) == ExpressionManager().expression_to_string(to_node), self == to_node)

        if self == to_node:
            return self

        if self == from_node:
            if self.parent is not None:
                if self.parent.left == self:
                    self.parent.left = to_node
                elif self.parent.right == self:
                    self.parent.right = to_node
            to_node.parent = self.parent
            self = to_node
            return self

        if self.type == ExpressionType.OP:
            if self.left is not None:
                self.left = self.left.replace(from_node, to_node)
            if self.right is not None:
                self.right = self.right.replace(from_node, to_node)
        elif self.type == ExpressionType.IF_TERNARY:
            if self.value is not None:
                self.value = self.value.replace(from_node, to_node)
            if self.left is not None:
                self.left = self.left.replace(from_node, to_node)
            if self.right is not None:
                self.right = self.right.replace(from_node, to_node)

        return self

# def update_types(expression_node: ExpressionNode):
#     if expression_node is None:
#         return

#     match expression_node.type:
#         case ExpressionType.OP:
#             update_types(expression_node.left)
#             update_types(expression_node.right)
#             expression_node.value_type_hint = get_common_type(expression_node.left.value_type_hint, expression_node.right.value_type_hint)
#             return

# def check_op_node_needs_cast(op_node: ExpressionNode) -> tuple[bool, bool]:
#     assert(op_node.type == ExpressionType.OP)

#     to_type = op_node.value_type_hint
#     left_node: ExpressionNode = op_node.left

#     match left_node.type:
#         case ExpressionType.OP:
#             left_child_needs_cast = check_op_node_needs_cast(left_node)
#         case _:

#     right_node: ExpressionNode = op_node.right

#     left_node_needs_cast = True
#     if left_node.type == ExpressionType.OP:
#         left_node_needs_cast = check_nodes_need_cast_to(left_node)


#     right_node_needs_cast = True

#     return (check_nodes_need_cast_to(left_node, to_type), check_nodes_need_cast_to(right_node, to_type))


# todo check with C99 standard
def get_common_type(first: OpenCLTypes, second: OpenCLTypes) -> OpenCLTypes:
    if first == OpenCLTypes.UNKNOWN and second == OpenCLTypes.UNKNOWN:
        return OpenCLTypes.UNKNOWN
    elif first == OpenCLTypes.UNKNOWN:
        return second
    elif second == OpenCLTypes.UNKNOWN:
        return first

    if first == second:
        return first

    first_type: OpenCLType = copy.deepcopy(first.value)
    second_type: OpenCLType = copy.deepcopy(second.value)

    # integer/float or float/integer
    if (first_type.is_integer and not second_type.is_integer) or (not first_type.is_integer and second_type.is_integer):
        int_type = first_type if first_type.is_integer else second_type
        float_type = second_type if first_type.is_integer else first_type

        if int_type.get_size() == float_type.get_size():
            return float_type

        float_type.number_of_components = max(float_type.number_of_components, int_type.number_of_components)
        float_type.size_bytes = max(float_type.size_bytes, int_type.size_bytes)

        return OpenCLTypes.from_string(str(float_type))

    # interger/integer

    if first_type.is_signed == second_type.is_signed:
        first_type.number_of_components = max(first_type.number_of_components, second_type.number_of_components)
        first_type.size_bytes = max(first_type.size_bytes, second_type.size_bytes)

        return OpenCLTypes.from_string(str(first_type))

    if (first_type.is_signed and not second_type.is_signed) or (not first_type.is_signed and second_type.is_signed):
        signed_type = first_type if first_type.is_signed else second_type
        unsigned_type = second_type if first_type.is_signed else first_type

        signed_type.number_of_components = max(signed_type.number_of_components, unsigned_type.number_of_components)
        unsigned_type.number_of_components = signed_type.number_of_components
        if unsigned_type.size_bytes >= signed_type.size_bytes:
            return OpenCLTypes.from_string(str(unsigned_type))
        else:
            max_signed_value = pow(2, signed_type.size_bytes * 8) - 1
            max_unsigned_value = pow(2, unsigned_type.size_bytes * 8) - 1

            if max_signed_value >= max_unsigned_value:
                return OpenCLTypes.from_string(str(signed_type))
            else:
                signed_type.is_signed = False
                return OpenCLTypes.from_string(str(signed_type))

    return OpenCLTypes.UNKNOWN


def get_expresion_type(expression_node: ExpressionNode) -> OpenCLTypes:
    match expression_node.type:
        case ExpressionType.OP:
            left_type = get_expresion_type(expression_node.left)
            right_type = get_expresion_type(expression_node.right)
            return get_common_type(left_type, right_type)
        case _:
            return expression_node.value_type_hint


def check_nodes_need_cast_to(expression_node: ExpressionNode, op_node: ExpressionNode) -> bool:
    if (
        expression_node is None
        or expression_node.value_type_hint == OpenCLTypes.UNKNOWN
        or op_node is None
        or op_node.value_type_hint == OpenCLTypes.UNKNOWN
    ):
        return True

    if expression_node.type == ExpressionType.OP:
        # todo fix that
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
    #todo check from get_variable_info???
    is_global_from_type = False #TypeModifiers.GLOBAL in from_type.modifiers

    to_type_size = to_type.size_bytes
    to_type_component_count = to_type.number_of_components
    is_global_to_type = False #TypeModifiers.GLOBAL in to_type.modifiers

    value = str(expression_node.value)

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

    # todo float/intergers and combinations separately!!!

    # from unsigned type to signed or from signed type to unsigned
    if (not from_type.is_signed and to_type.is_signed) or (from_type.is_signed and not to_type.is_signed):
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