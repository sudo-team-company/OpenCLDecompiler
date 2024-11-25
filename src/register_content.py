# pylint: disable=R1705

import copy
import enum
from typing import Optional, Union

from src.constants import DEFAULT_REGISTER_SIZE
from src.register_type import RegisterType


class RegisterSignType(enum.Enum):
    POSITIVE = 0
    NEGATIVE = 1

    def __invert__(self):
        if self.value == 0:
            return RegisterSignType.NEGATIVE
        elif self.value == 1:
            return RegisterSignType.POSITIVE
        else:
            raise Exception()


# Data for known register values
CONSTANT_VALUES: dict[RegisterType, (str, int, str, RegisterSignType)] = {
    RegisterType.WORK_DIM: ("get_work_dim()", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_SIZE_X: ("get_global_size(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_SIZE_Y: ("get_global_size(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_SIZE_Z: ("get_global_size(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_ID_X: ("get_global_id(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_ID_Y: ("get_global_id(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_ID_Z: ("get_global_id(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.LOCAL_SIZE_X: ("get_local_size(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.LOCAL_SIZE_Y: ("get_local_size(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.LOCAL_SIZE_Z: ("get_local_size(2)", 32, "u32", RegisterSignType.POSITIVE),
    # u32 get_enqueued_local_size(0)
    # u32 get_enqueued_local_size(1)
    # u32 get_enqueued_local_size(2)
    RegisterType.WORK_ITEM_ID_X: ("get_local_id(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_ITEM_ID_Y: ("get_local_id(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_ITEM_ID_Z: ("get_local_id(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.NUM_GROUPS_X: ("get_num_groups(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.NUM_GROUPS_Y: ("get_num_groups(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.NUM_GROUPS_Z: ("get_num_groups(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_GROUP_ID_X: ("get_group_id(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_GROUP_ID_Y: ("get_group_id(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_GROUP_ID_Z: ("get_group_id(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_OFFSET_X: ("get_global_offset(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_OFFSET_Y: ("get_global_offset(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_OFFSET_Z: ("get_global_offset(0)", 32, "u32", RegisterSignType.POSITIVE),
    # u32 get_global_linear_id()
    # u32 get_local_linear_id()
    # u32 get_sub_group_size()
    # u32 get_max_sub_group_size()
    # u32 get_num_sub_groups()
    # u32 get_enqueued_num_sub_groups()
    # u32 get_sub_group_id()
    # u32 get_sub_group_local_id()
}


class RegisterContent:
    def __init__(
        self,
        value: Union[list[object], object],
        type_: Union[list, RegisterType],
        size: Union[list, int] = DEFAULT_REGISTER_SIZE,
        data_type: Union[list, Optional[str]] = None,
        sign: Union[list, RegisterSignType] = RegisterSignType.POSITIVE,
    ):
        if type_ is RegisterType and type_ in CONSTANT_VALUES:
            self._type = type_
            self._value, self._size, self._data_type, self._sign = CONSTANT_VALUES[type_]
            # TODO: remove deviation check
            assert (
                (self._value == value or value is None)
                and (self._type == type_ or type_ is None)
                and (self._size == size or size is None)
                and (self._data_type == data_type or data_type is None)
                and (self._sign == sign or sign is None)
            )
            return
        self._value = value
        self._type = type_
        self._size = size
        self._data_type = data_type
        self._sign = sign

    def get_value(self) -> object:
        return self._value

    def get_type(self) -> RegisterType:
        return self._type

    def get_size(self) -> int:
        return self._size

    def get_data_type(self) -> Optional[str]:
        return self._data_type

    def get_sign(self) -> RegisterSignType:
        return self._sign

    def maybe_simplify(self) -> Optional["RegisterContent"]:
        return None

    def __invert__(self):
        self._sign = self._sign.__invert__()

    def __and__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # pylint: disable=C0415

            return OperationRegisterContent(
                operation=OperationType.BITWISE_AND,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        if isinstance(other, str):
            if other.startswith("0x"):
                bit_str = "{:b}".format(int(other, 16))  # pylint: disable=C0209
                if bit_str.count("0") == 0 and len(bit_str) == self.get_size():
                    return copy.deepcopy(self)

        raise NotImplementedError()

    def __or__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # pylint: disable=C0415

            return OperationRegisterContent(
                operation=OperationType.BITWISE_OR,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        raise NotImplementedError()

    def __rshift__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # pylint: disable=C0415

            return OperationRegisterContent(
                operation=OperationType.R_SHIFT,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        raise NotImplementedError()

    def __lshift__(self, other):
        if isinstance(other, int):
            from src.operation_register_content import OperationRegisterContent, OperationType  # pylint: disable=C0415

            return OperationRegisterContent(
                operation=OperationType.L_SHIFT,
                register_contents=[
                    copy.deepcopy(self),
                    RegisterContent(
                        value=other,
                        type_=RegisterType.UNKNOWN,
                        size=0,
                        data_type=None,
                    ),
                ],
            )

        raise NotImplementedError()

    def __add__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # pylint: disable=C0415

            return OperationRegisterContent(
                operation=OperationType.PLUS,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        raise NotImplementedError()

    def __sub__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # pylint: disable=C0415

            return OperationRegisterContent(
                operation=OperationType.MINUS,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        raise NotImplementedError()

    def __mul__(self, other):
        from src.operation_register_content import OperationRegisterContent, OperationType  # pylint: disable=C0415

        if isinstance(other, RegisterContent):
            return OperationRegisterContent(
                operation=OperationType.PRODUCT,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )
        elif isinstance(other, int):
            return OperationRegisterContent(
                operation=OperationType.PRODUCT,
                register_contents=[
                    copy.deepcopy(self),
                    RegisterContent(
                        value=other,
                        type_=RegisterType.INT32,
                        size=0,
                        data_type=None,
                    ),
                ],
            )
        else:
            raise NotImplementedError()


class EmptyRegisterContent(RegisterContent):
    def __init__(self, size: int):
        super().__init__(None, RegisterType.EMPTY, size)
