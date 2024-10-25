# pylint: disable=R0401

import copy
import enum
import itertools
from typing import Optional

from src.constants import DEFAULT_REGISTER_SIZE
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
            frozenset({
                RegisterType[f"GLOBAL_OFFSET_{dim}"],
                RegisterType[f"WORK_ITEM_ID_{dim}"],
                RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"],
            }),
            (
                f"get_global_id({i})",
                RegisterType[f"GLOBAL_ID_{dim}"],
                RegisterSignType.POSITIVE,
            )
        )
        for i, dim in enumerate("XYZ")
    ],
    *[
        (
            frozenset({
                RegisterType[f"GLOBAL_OFFSET_{dim}"],
                RegisterType[f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"],
            }),
            (
                f"get_global_id({i})",
                RegisterType[f"GLOBAL_ID_{dim}"],
                RegisterSignType.POSITIVE,
            )
        )
        for i, dim in enumerate("XYZ")
    ],
    *[
        (
            frozenset({
                RegisterType[f"WORK_ITEM_ID_{dim}"],
                RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"],
            }),
            (
                f"get_global_id({i})",
                RegisterType[f"GLOBAL_ID_{dim}"],
                RegisterSignType.POSITIVE,
            )
        )
        for i, dim in enumerate("XYZ")
    ],
    *[
        (
            frozenset({
                RegisterType[f"NUM_GROUPS_{dim}"],
                RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"],
            }),
            (
                f"get_global_size({i})",
                RegisterType[f"GLOBAL_SIZE_{dim}"],
                RegisterSignType.POSITIVE,
            )
        )
        for i, dim in enumerate("XYZ")
    ],
]


class OperationRegisterContent(RegisterContent):
    def __init__(self, operation: OperationType, register_contents: list[RegisterContent]):
        if len(register_contents) == 0:
            self._operation = operation
            super().__init__(
                value=[],
                type_=[],
                size=DEFAULT_REGISTER_SIZE,
                data_type=None,
                sign=[],
            )

            return

        if operation == OperationType.MINUS:
            for idx, _ in enumerate(register_contents):
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
                else:
                    if is_same_operation:
                        values.extend(register_content._value)
                        types.extend(register_content._type)
                        sizes.extend(itertools.repeat(register_content._size, len(register_content._value)))
                        data_types.extend(itertools.repeat(register_content._data_type, len(register_content._value)))
                        signs.extend(register_content._sign)
                    else:
                        values.append(f"({register_content.get_value()})")
                        types.append(register_content.get_type())
                        sizes.append(register_content.get_size())
                        data_types.append(register_content.get_data_type())
                        signs.append(register_content.get_sign())

        data_types = set(data_types)
        if len(data_types) != 1:
            data_type = None
            # raise Exception(f"{OperationRegisterContent.__class__} must consists of elements with same data type")
        else:
            data_type = data_types.pop()

        super().__init__(
            value=values,
            type_=types,
            size=max(sizes),
            data_type=data_type,
            sign=signs,
        )
        self._operation = operation

    def get_operation(self) -> OperationType:
        return self._operation

    def get_value(self) -> any:
        joined_string = f" {self._operation.value} ".join([
            f"{'-' if sign == RegisterSignType.NEGATIVE else ''}{value}"
            for value, sign
            in zip(self._value, self._sign)
        ])

        return f"{joined_string}"

    def get_type(self) -> RegisterType:
        return None

    def get_size(self) -> int:
        return self._size

    def get_data_type(self) -> Optional[str]:
        return self._data_type

    def get_sign(self) -> RegisterSignType:
        return None

    def maybe_simplify(self) -> Optional[RegisterContent]:
        def maybe_find_opposite_pos() -> Optional[tuple[int, int]]:
            for i, (val_i, type_i, sign_i) in enumerate(zip(self._value, self._type, self._sign)):
                for j, (val_j, type_j, sign_j) in enumerate(zip(self._value, self._type, self._sign)):
                    if i >= j:
                        continue

                    if type_i == type_j and val_i == val_j and sign_i != sign_j:
                        return i, j
            return None

        def maybe_find_types_pos(types: tuple[RegisterType]) -> Optional[list[int]]:
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

            for i, (value, type_, sign) in enumerate(zip(
                    self._value,
                    self._type,
                    self._sign,
            )):
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
            new_operation_register_content._value = new_value  # pylint: disable=W0212
            new_operation_register_content._type = new_type  # pylint: disable=W0212
            new_operation_register_content._size = new_size  # pylint: disable=W0212
            new_operation_register_content._data_type = new_data_type  # pylint: disable=W0212
            new_operation_register_content._sign = new_sign  # pylint: disable=W0212

            return new_operation_register_content

        if len(self._value) == 1:
            return RegisterContent(
                value=self._value[0],
                type_=self._type[0],
                size=self._size[0],
                data_type=self._data_type[0],
                sign=self._sign[0],
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
                        new_register_content._value.append(simplified_value)  # pylint: disable=W0212
                        new_register_content._type.append(simplified_type)  # pylint: disable=W0212
                        new_register_content._sign.append(simplified_sign)  # pylint: disable=W0212
                        new_register_content._size.append(DEFAULT_REGISTER_SIZE)  # pylint: disable=W0212
                        new_register_content._data_type.append(None)  # pylint: disable=W0212

                        recursive_new_register_content = new_register_content.maybe_simplify()

                        if recursive_new_register_content is not None:
                            return recursive_new_register_content

                        return new_register_content

        return None
