import copy
import enum
import itertools

from src.constants import DEFAULT_REGISTER_SIZE
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import ExpressionNode, ExpressionOperationType
from src.register_content import RegisterContent, RegisterSignType
from src.register_type import RegisterType


class OperationType(enum.Enum):
    PLUS = "+"
    MINUS = "-"
    PRODUCT = "*"
    DIVISION = "/"
    R_SHIFT = ">>"
    L_SHIFT = "<<"
    BITWISE_AND = "&"
    BITWISE_OR = "|"


OPERATION_TO_PRIORITY = {
    OperationType.PLUS: 9,
    OperationType.MINUS: 9,
    OperationType.PRODUCT: 10,
    OperationType.DIVISION: 10,
    OperationType.R_SHIFT: 8,
    OperationType.L_SHIFT: 8,
    OperationType.BITWISE_AND: 7,
    OperationType.BITWISE_OR: 7,
}

_SUM_SIMPLIFY_COMBINATIONS = [
    *[
        (
            frozenset(
                {
                    RegisterType[f"GLOBAL_OFFSET_{dim}"],
                    RegisterType[f"WORK_ITEM_ID_{dim}"],
                    RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"],
                }
            ),
            (
                f"get_global_id({i})",
                RegisterType[f"GLOBAL_ID_{dim}"],
                RegisterSignType.POSITIVE,
            ),
        )
        for i, dim in enumerate("XYZ")
    ],
    *[
        (
            frozenset(
                {
                    RegisterType[f"GLOBAL_OFFSET_{dim}"],
                    RegisterType[f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"],
                }
            ),
            (
                f"get_global_id({i})",
                RegisterType[f"GLOBAL_ID_{dim}"],
                RegisterSignType.POSITIVE,
            ),
        )
        for i, dim in enumerate("XYZ")
    ],
    *[
        (
            frozenset(
                {
                    RegisterType[f"WORK_ITEM_ID_{dim}"],
                    RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"],
                }
            ),
            (
                f"get_global_id({i})",
                RegisterType[f"GLOBAL_ID_{dim}"],
                RegisterSignType.POSITIVE,
            ),
        )
        for i, dim in enumerate("XYZ")
    ],
    *[
        (
            frozenset(
                {
                    RegisterType[f"NUM_GROUPS_{dim}"],
                    RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"],
                }
            ),
            (
                f"get_global_size({i})",
                RegisterType[f"GLOBAL_SIZE_{dim}"],
                RegisterSignType.POSITIVE,
            ),
        )
        for i, dim in enumerate("XYZ")
    ],
]


class OperationRegisterContent(RegisterContent):
    def __init__(  # noqa: PLR0912, PLR0915
        self,
        operation: OperationType,
        register_contents: list[RegisterContent],
        expression_node: ExpressionNode = None,
    ):
        if len(register_contents) == 0:
            self._operation = operation
            super().__init__(
                value=[], type_=[], data_type=None, size=DEFAULT_REGISTER_SIZE, sign=[], expression_node=None
            )

            return

        if operation == OperationType.MINUS:
            for idx in range(len(register_contents)):
                if idx == 0:
                    continue

                register_contents[idx].__invert__()

            operation = OperationType.PLUS

        is_same_operation = True
        contains_operation_register_content = False

        for register_content in register_contents:
            if not isinstance(register_content, OperationRegisterContent):
                continue

            contains_operation_register_content = True

            if operation != register_content.get_operation():
                is_same_operation = False
                break
        if not contains_operation_register_content:
            values = [content.get_value() for content in register_contents]
            types = [content.get_type() for content in register_contents]
            sizes = [content.get_size() for content in register_contents]
            data_types = [content.get_data_type() for content in register_contents]
            signs = [content.get_sign() for content in register_contents]
        else:
            values = []
            types = []
            sizes = []
            data_types = []
            signs = []

            for register_content in register_contents:
                if not isinstance(register_content, OperationRegisterContent):
                    values.append(register_content.get_value())
                    types.append(register_content.get_type())
                    sizes.append(register_content.get_size())
                    data_types.append(register_content.get_data_type())
                    signs.append(register_content.get_sign())
                elif is_same_operation:
                    values.extend(register_content._value)  # noqa: SLF001
                    types.extend(register_content._type)  # noqa: SLF001
                    sizes.extend(itertools.repeat(register_content._size, len(register_content._value)))  # noqa: SLF001
                    data_types.extend(itertools.repeat(register_content._data_type, len(register_content._value)))  # noqa: SLF001
                    signs.extend(register_content._sign)  # noqa: SLF001
                else:
                    values.append(f"({register_content.get_value()})")
                    types.append(register_content.get_type())
                    sizes.append(register_content.get_size())
                    data_types.append(register_content.get_data_type())
                    signs.append(register_content.get_sign())

        data_types = set(data_types)
        data_type = None if len(data_types) != 1 else data_types.pop()

        if expression_node is None:
            expression_node = ExpressionManager().apply_operation_to_nodes(
                [content.get_expression_node() for content in register_contents],
                ExpressionOperationType.from_string(operation.value),
            )

        super().__init__(
            value=values, type_=types, size=max(sizes), data_type=data_type, sign=signs, expression_node=expression_node
        )
        self._operation = operation

    def get_operation(self) -> OperationType:
        return self._operation

    def get_value(self) -> object:
        joined_string = f" {self._operation.value} ".join(
            [
                f"{'-' if sign == RegisterSignType.NEGATIVE else ''}{value}"
                for value, sign in zip(self._value, self._sign, strict=False)
            ]
        )

        return f"{joined_string}"

    def get_type(self) -> RegisterType:
        return None

    def get_size(self) -> int:
        return self._size

    def get_data_type(self) -> str | None:
        return self._data_type

    def get_sign(self) -> RegisterSignType:
        return None

    def get_expression_node(self) -> ExpressionNode:
        return self._expression_node

    def maybe_simplify(self) -> RegisterContent | None:  # noqa: C901, PLR0915
        def maybe_find_opposite_pos() -> tuple[int, int] | None:
            for i, (val_i, type_i, sign_i) in enumerate(zip(self._value, self._type, self._sign, strict=False)):
                for j, (val_j, type_j, sign_j) in enumerate(zip(self._value, self._type, self._sign, strict=False)):
                    if i >= j:
                        continue

                    if type_i == type_j and val_i == val_j and sign_i != sign_j:
                        return i, j
            return None

        def maybe_find_types_pos(types: tuple[RegisterType]) -> list[int] | None:
            if len(types) == 0:
                return []

            type_to_find = types[0]
            for i, type_ in enumerate(self._type):
                if type_ == type_to_find:
                    rest_pos = maybe_find_types_pos(types[1:])

                    if rest_pos is None:
                        return None

                    result: list[int] = [i]
                    result.extend(rest_pos)

                    return result

            return None

        def create_content_without_specified_pos(pos_list: list[int]):
            new_value = []
            new_type = []
            new_size = []
            new_data_type = []
            new_sign = []
            new_expression_node = self.get_expression_node()

            for i, (value, type_, sign) in enumerate(
                zip(
                    self._value,
                    self._type,
                    self._sign,
                    strict=False,
                )
            ):
                if i in pos_list:
                    continue

                new_value.append(copy.deepcopy(value))
                new_type.append(copy.deepcopy(type_))
                new_size.append(copy.deepcopy(self._size))
                new_data_type.append(copy.deepcopy(self._data_type))
                new_sign.append(copy.deepcopy(sign))

            new_operation_register_content = OperationRegisterContent(
                operation=copy.deepcopy(self._operation),
                register_contents=[],
            )
            new_operation_register_content._value = new_value
            new_operation_register_content._type = new_type
            new_operation_register_content._size = new_size
            new_operation_register_content._data_type = new_data_type
            new_operation_register_content._sign = new_sign
            new_operation_register_content._expression_node = new_expression_node

            return new_operation_register_content

        if len(self._value) == 1:
            return RegisterContent(
                value=self._value[0],
                type_=self._type[0],
                size=self._size[0],
                data_type=self._data_type[0],
                sign=self._sign[0],
                expression_node=self._expression_node,
            )

        maybe_pos = maybe_find_opposite_pos()

        if maybe_pos is not None:
            i, j = maybe_pos
            new_register_content = create_content_without_specified_pos([i, j])
            recursive_new_register_content = new_register_content.maybe_simplify()

            if recursive_new_register_content is not None:
                return recursive_new_register_content

            return new_register_content

        if self._operation == OperationType.PLUS:
            for simplify_combination in _SUM_SIMPLIFY_COMBINATIONS:
                types_to_find, simplification = simplify_combination
                types_to_find_permutations = list(itertools.permutations(types_to_find))

                for permutation in types_to_find_permutations:
                    maybe_pos_list = maybe_find_types_pos(permutation)

                    if maybe_pos_list is not None:
                        new_register_content = create_content_without_specified_pos(maybe_pos_list)
                        simplified_value, simplified_type, simplified_sign = simplification
                        new_register_content._value.append(simplified_value)  # noqa: SLF001
                        new_register_content._type.append(simplified_type)  # noqa: SLF001
                        new_register_content._sign.append(simplified_sign)  # noqa: SLF001
                        new_register_content._size.append(DEFAULT_REGISTER_SIZE)  # noqa: SLF001
                        new_register_content._data_type.append(None)  # noqa: SLF001

                        recursive_new_register_content = new_register_content.maybe_simplify()

                        if recursive_new_register_content is not None:
                            return recursive_new_register_content

                        return new_register_content

        return None
