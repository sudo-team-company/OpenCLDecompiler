import copy
import re
import uuid
from dataclasses import dataclass, field
from enum import Enum, auto

from src.expression_manager.types.asm_types import ASMTypes
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
    @staticmethod
    def from_string(s: str):
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

    @staticmethod
    def are_operations_inverted(first: "ExpressionOperationType", second: "ExpressionOperationType"):
        _inv_ops = {
            ExpressionOperationType.PLUS : ExpressionOperationType.MINUS,
            ExpressionOperationType.MINUS : ExpressionOperationType.PLUS,
            ExpressionOperationType.MUL : ExpressionOperationType.DIV,
            ExpressionOperationType.DIV : ExpressionOperationType.MUL,

            ExpressionOperationType.LSHIFT : ExpressionOperationType.RSHIFT,
            ExpressionOperationType.RSHIFT : ExpressionOperationType.LSHIFT,

            ExpressionOperationType.EQ : ExpressionOperationType.NE,
            ExpressionOperationType.NE : ExpressionOperationType.EQ,
            ExpressionOperationType.LT : ExpressionOperationType.GE,
            ExpressionOperationType.GE : ExpressionOperationType.LT,
            ExpressionOperationType.LE : ExpressionOperationType.GT,
            ExpressionOperationType.GT : ExpressionOperationType.LE,
        }
        if first in _inv_ops:
            return _inv_ops[first] == second
        return False


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

class TypeAddressSpaceQualifiers(Enum):
    UNKNOWN = ""
    GLOBAL = "__global"
    LOCAL = "__local"
    CONST = "__constant"
    PRIVATE = "__private"

@dataclass
class ExpressionValueTypeHint:
    opencl_type: OpenCLTypes = field(default_factory=lambda: OpenCLTypes.UNKNOWN)
    qualifier: TypeAddressSpaceQualifiers = field(default_factory=lambda: TypeAddressSpaceQualifiers.UNKNOWN)
    is_const: bool = False
    is_pointer: bool = False
    is_address: bool = False

    def __str__(self):
        qualifier_str = f"{self.qualifier.value} " if self.qualifier != TypeAddressSpaceQualifiers.UNKNOWN else ""
        const_str = "const " if self.is_const else ""
        type_str = str(self.opencl_type)
        pointer_str = "*" if self.is_pointer else ""
        #todo do this more logically
        if self.qualifier == TypeAddressSpaceQualifiers.CONST or self.qualifier == TypeAddressSpaceQualifiers.LOCAL:
            return f"{qualifier_str}{const_str}{type_str}"
        return f"{qualifier_str}{const_str}{type_str}{pointer_str}"

    @staticmethod
    def get_common_type(first: "ExpressionValueTypeHint", second: "ExpressionValueTypeHint") -> "ExpressionValueTypeHint":
        res = ExpressionValueTypeHint()
        res.opencl_type = get_common_type(first.opencl_type, second.opencl_type)
        #todo modifiers and stuff?
        return res

    @staticmethod
    def from_string(type_hint) -> "ExpressionValueTypeHint":
        if isinstance(type_hint, ExpressionValueTypeHint):
            return type_hint

        if not isinstance(type_hint, str):
            return ExpressionValueTypeHint()

        assert type_hint.startswith("g") is False
        assert type_hint.startswith("__global ") is False

        if "b32" in type_hint or "b64" in type_hint:
            type_hint = type_hint.replace("b", "u", 1)

        opencl_type = OpenCLTypes.UNKNOWN
        for e in OpenCLTypes:
            if str(e) == type_hint:
                opencl_type = e
        if opencl_type == OpenCLTypes.UNKNOWN:
            asm_type = ASMTypes.from_string(type_hint)
            if asm_type != ASMTypes.UNKNOWN:
                opencl_type = OpenCLTypes.from_asm_type(asm_type)

        return ExpressionValueTypeHint(opencl_type)

    def size_bytes(self):
        return self.opencl_type.value.get_size()
    
    def number_of_components(self):
        return self.opencl_type.value.number_of_components
    
    def set_number_of_components(self, number_of_components: int) -> "ExpressionValueTypeHint":
        res = copy.deepcopy(self)
        res.opencl_type = self.opencl_type.set_number_of_components(number_of_components)
        return res
    
    def is_integer(self):
        return self.opencl_type.value.is_integer
    
    def is_signed(self):
        return self.opencl_type.value.is_signed
    
    def is_unknown(self):
        return self.opencl_type == OpenCLTypes.UNKNOWN

@dataclass
class ExpressionNode:
    id: uuid.UUID = field(default_factory=lambda: uuid.uuid4())
    left: "ExpressionNode" = None
    right: "ExpressionNode" = None
    parent: "ExpressionNode" = None
    type: ExpressionType = ExpressionType.UNKNOWN
    value: ExpressionOperationType | int | str = None
    value_type_hint: ExpressionValueTypeHint = field(default_factory=lambda: ExpressionValueTypeHint())

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
        if other is None:
            return False
        left_equal = self.left.contents_equal(other.left) if self.left is not None else other.left is None
        right_equal = self.right.contents_equal(other.right) if self.right is not None else other.right is None
        return (
            left_equal and right_equal
            and self.type == other.type
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
    
    def needs_cast(
        self,
        to_hint: ExpressionValueTypeHint) -> bool:
        from_hint = self.value_type_hint
        assert from_hint.is_unknown() == False
        if to_hint.is_unknown():
            return False

        if from_hint == to_hint:
            return False
        
        if from_hint.number_of_components() != to_hint.number_of_components():
            return True

        is_to_type_smaller = from_hint.size_bytes() > to_hint.size_bytes()

        # floating point - floating point
        if not from_hint.is_integer() and not to_hint.is_integer():
            return is_to_type_smaller
        # integer - integer
        if from_hint.is_integer() and to_hint.is_integer():
            if from_hint.is_signed() == to_hint.is_signed():
                return is_to_type_smaller
            # from unsigned type to signed or from signed type to unsigned
            if re.fullmatch(r"0x[\da-f]+", str(self.value)) is not None:
                return False
            if isinstance(self.value, int) and self.value >= 0:
                return False
            return True
        
        # integer -> floating point / floating point -> integer
        # We can deduce it only for const nodes
        if self.type == ExpressionType.CONST:
            # integer -> floating point
            if from_hint.is_integer():
                if re.fullmatch(r"0x[\da-f]+", str(self.value)) is not None:
                    return False
                return is_to_type_smaller

            # floating point -> integer
            if to_hint.is_signed():
                return self.value != int(self.value) or is_to_type_smaller
            # floating point -> unsigned integer
            else:
                return self.value < 0.0 or is_to_type_smaller
        return is_to_type_smaller

    def cast_to(self, to_type: OpenCLTypes) -> "ExpressionNode":
        self.value_type_hint.opencl_type = to_type
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
            return OpenCLTypes.from_string(str(float_type))

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