import copy
import re
import uuid
from dataclasses import dataclass, field
from enum import Enum, auto

from src.expression_manager.types.asm_types import ASMTypes
from src.expression_manager.types.opencl_types import OpenCLType, OpenCLTypes


class ExpressionType(Enum):
    UNKNOWN = auto()
    OP = auto()
    CONST = auto()
    WORK_ITEM_FUNCTION = auto()
    VAR = auto()
    PERMUTE = auto()
    IF_TERNARY = auto()
    MIN = auto()


class ExpressionOperationType(Enum):
    @staticmethod
    def from_string(s: str):
        for expr_op_type in ExpressionOperationType:
            if s == expr_op_type.value:
                return expr_op_type
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
    def get_inverted_operation(op: "ExpressionOperationType"):
        _inv_ops = {
            ExpressionOperationType.PLUS: ExpressionOperationType.MINUS,
            ExpressionOperationType.MINUS: ExpressionOperationType.PLUS,
            ExpressionOperationType.MUL: ExpressionOperationType.DIV,
            ExpressionOperationType.DIV: ExpressionOperationType.MUL,
            ExpressionOperationType.LSHIFT: ExpressionOperationType.RSHIFT,
            ExpressionOperationType.RSHIFT: ExpressionOperationType.LSHIFT,
            ExpressionOperationType.EQ: ExpressionOperationType.NE,
            ExpressionOperationType.NE: ExpressionOperationType.EQ,
            ExpressionOperationType.LT: ExpressionOperationType.GE,
            ExpressionOperationType.GE: ExpressionOperationType.LT,
            ExpressionOperationType.LE: ExpressionOperationType.GT,
            ExpressionOperationType.GT: ExpressionOperationType.LE,
        }
        if op in _inv_ops:
            return _inv_ops[op]
        return ExpressionOperationType.UNKNOWN

    @staticmethod
    def are_operations_inverted(first: "ExpressionOperationType", second: "ExpressionOperationType"):
        first_inverted = ExpressionOperationType.get_inverted_operation(first)
        if first_inverted != ExpressionOperationType.UNKNOWN:
            return first_inverted == second
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

    MIN = "min"


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
        pointer_str = " *" if self.is_pointer else ""
        return f"{qualifier_str}{const_str}{type_str}{pointer_str}"

    def to_string_arr(self):
        return str(self)[:-2] if self.is_pointer else str(self)

    @staticmethod
    def get_common_type(
        first: "ExpressionValueTypeHint", second: "ExpressionValueTypeHint"
    ) -> "ExpressionValueTypeHint":
        res = ExpressionValueTypeHint()
        res.opencl_type = get_common_type(first.opencl_type, second.opencl_type)
        res.qualifier = first.qualifier if first.qualifier == second.qualifier else TypeAddressSpaceQualifiers.UNKNOWN
        res.is_const = first.is_const and second.is_const
        res.is_pointer = first.is_pointer and second.is_pointer
        res.is_address = first.is_address and second.is_address
        return res

    @staticmethod
    def from_string(type_hint) -> "ExpressionValueTypeHint":
        if isinstance(type_hint, ExpressionValueTypeHint):
            return type_hint

        if not isinstance(type_hint, str):
            return ExpressionValueTypeHint()

        qualifier = TypeAddressSpaceQualifiers.UNKNOWN
        if type_hint.startswith("g"):
            type_hint = type_hint.removeprefix("g")
            qualifier = TypeAddressSpaceQualifiers.GLOBAL
        if type_hint.startswith("__global "):
            type_hint = type_hint.removeprefix("__global ")
            qualifier = TypeAddressSpaceQualifiers.GLOBAL

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

        return ExpressionValueTypeHint(opencl_type, qualifier)

    def size_bytes(self):
        return self.opencl_type.value.get_size()

    def number_of_components(self):
        return self.opencl_type.value.number_of_components

    def set_number_of_components(self, number_of_components: int) -> "ExpressionValueTypeHint":
        res = copy.deepcopy(self)
        res.opencl_type = self.opencl_type.set_number_of_components(number_of_components)
        return res

    def set_is_integer(self, is_integer: bool) -> "ExpressionValueTypeHint":  # noqa: FBT001
        res = copy.deepcopy(self)
        res.opencl_type = self.opencl_type.set_is_integer(is_integer)
        return res

    def set_is_const(self, is_const: bool) -> "ExpressionValueTypeHint":  # noqa: FBT001
        res = copy.deepcopy(self)
        res.is_const = is_const
        return res

    def is_vector_type(self):
        return self.number_of_components() > 1

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
            f"\tleft: {str(self.left.id) if self.left is not None else 'None'}\n"
            f"\tright: {str(self.right.id) if self.right is not None else 'None'}\n"
            f"\tparent: {str(self.parent.id) if self.parent is not None else 'None'}\n"
            f"\ttype: {self.type!s}\n"
            f"\tvalue: {self.value!s}\n"
            f"\tvalue_type_hint: {self.value_type_hint!s}"
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

    def __hash__(self):
        return hash(str(self.id))

    def contents_equal(self, other: "ExpressionNode"):
        if other is None:
            return False
        left_equal = self.left.contents_equal(other.left) if self.left is not None else other.left is None
        right_equal = self.right.contents_equal(other.right) if self.right is not None else other.right is None
        return (
            left_equal
            and right_equal
            and self.type == other.type
            and self.value == other.value
            and self.value_type_hint == other.value_type_hint
        )

    def invert(self) -> "ExpressionNode":
        return self

    def needs_cast(  # noqa: PLR0911, PLR0912
        self, to_hint: ExpressionValueTypeHint
    ) -> bool:
        from_hint = self.value_type_hint
        if from_hint.is_unknown():
            return not to_hint.is_unknown()
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
            if re.fullmatch(r"-?\d+.\d+", str(self.value)) is not None:
                return False
            if re.fullmatch(r"0x[\da-f]+", str(self.value)) is not None:
                return False
            return not (isinstance(self.value, int) and self.value >= 0)

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
            return self.value < 0.0 or is_to_type_smaller
        return is_to_type_smaller

    def cast_to(self, to_type: OpenCLTypes) -> "ExpressionNode":
        self.value_type_hint.opencl_type = to_type
        return self

    def replace(self, from_node: "ExpressionNode", to_node: "ExpressionNode") -> "ExpressionNode":
        assert from_node is not None
        assert to_node is not None

        if self.contents_equal(to_node):
            return self

        if self.contents_equal(from_node):
            if self.parent is not None:
                if self.parent.left == self:
                    self.parent.left = to_node
                elif self.parent.right == self:
                    self.parent.right = to_node
            to_node.parent = self.parent
            return to_node

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


def get_common_type(first: OpenCLTypes, second: OpenCLTypes) -> OpenCLTypes:
    if first == second:
        return first
    if first == OpenCLTypes.UNKNOWN:
        return second
    if second == OpenCLTypes.UNKNOWN:
        return first

    first_type: OpenCLType = copy.deepcopy(first.value)
    second_type: OpenCLType = copy.deepcopy(second.value)

    # integer/float or float/integer
    if (first_type.is_integer and not second_type.is_integer) or (not first_type.is_integer and second_type.is_integer):
        int_type = first_type if first_type.is_integer else second_type
        float_type = second_type if first_type.is_integer else first_type

        if int_type.get_size() == float_type.get_size():
            result_type = OpenCLTypes.from_string(str(float_type))
        else:
            float_type.number_of_components = max(float_type.number_of_components, int_type.number_of_components)
            float_type.size_bytes = max(float_type.size_bytes, int_type.size_bytes)
            result_type = OpenCLTypes.from_string(str(float_type))
    # interger/integer
    elif first_type.is_signed == second_type.is_signed:
        first_type.number_of_components = max(first_type.number_of_components, second_type.number_of_components)
        first_type.size_bytes = max(first_type.size_bytes, second_type.size_bytes)
        result_type = OpenCLTypes.from_string(str(first_type))
    elif (first_type.is_signed and not second_type.is_signed) or (not first_type.is_signed and second_type.is_signed):
        signed_type = first_type if first_type.is_signed else second_type
        unsigned_type = second_type if first_type.is_signed else first_type

        signed_type.number_of_components = max(signed_type.number_of_components, unsigned_type.number_of_components)
        unsigned_type.number_of_components = signed_type.number_of_components
        if unsigned_type.size_bytes >= signed_type.size_bytes:
            result_type = OpenCLTypes.from_string(str(unsigned_type))
        else:
            max_signed_value = pow(2, signed_type.size_bytes * 8) - 1
            max_unsigned_value = pow(2, unsigned_type.size_bytes * 8) - 1

            if max_signed_value >= max_unsigned_value:
                result_type = OpenCLTypes.from_string(str(signed_type))
            else:
                signed_type.is_signed = False
                result_type = OpenCLTypes.from_string(str(signed_type))

    return result_type
