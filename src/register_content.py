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
        if self.value == 1:
            return RegisterSignType.POSITIVE


class RegisterContent:
    def __init__(
            self,
            value: Union[list[any], any],
            type_: Union[list, RegisterType],
            size: Union[list, int] = DEFAULT_REGISTER_SIZE,
            data_type: Union[list, Optional[str]] = None,
            sign: Union[list, RegisterSignType] = RegisterSignType.POSITIVE,
    ):
        self._value = value
        self._type = type_
        self._size = size
        self._data_type = data_type
        self._sign = sign

    def get_value(self) -> any:
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
            from src.utils.operation_register_content import OperationRegisterContent, OperationType

            return OperationRegisterContent(
                operation=OperationType.BITWISE_AND,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ]
            )

        if isinstance(other, str):
            if other.startswith("0x"):
                bit_str = "{:b}".format(int(other, 16))
                if bit_str.count("0") == 0 and len(bit_str) == self.get_size():
                    return copy.deepcopy(self)

        raise NotImplementedError()

    def __or__(self, other):
        if isinstance(other, RegisterContent):
            from src.utils.operation_register_content import OperationRegisterContent, OperationType

            return OperationRegisterContent(
                operation=OperationType.BITWISE_OR,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ]
            )

        raise NotImplementedError()

    def __rshift__(self, other):
        if isinstance(other, RegisterContent):
            from src.utils.operation_register_content import OperationRegisterContent, OperationType

            return OperationRegisterContent(
                operation=OperationType.R_SHIFT,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ]
            )

        raise NotImplementedError()

    def __lshift__(self, other):
        if isinstance(other, int):
            from src.utils.operation_register_content import OperationRegisterContent, OperationType

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
                ]
            )

        raise NotImplementedError()

    def __add__(self, other):
        if isinstance(other, RegisterContent):
            from src.utils.operation_register_content import OperationRegisterContent, OperationType

            return OperationRegisterContent(
                operation=OperationType.PLUS,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ]
            )

        raise NotImplementedError()

    def __sub__(self, other):
        if isinstance(other, RegisterContent):
            from src.utils.operation_register_content import OperationRegisterContent, OperationType

            return OperationRegisterContent(
                operation=OperationType.MINUS,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ]
            )

        raise NotImplementedError()

    def __mul__(self, other):
        from src.utils.operation_register_content import OperationRegisterContent, OperationType

        if isinstance(other, RegisterContent):
            return OperationRegisterContent(
                operation=OperationType.PRODUCT,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ]
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
                ]
            )

        raise NotImplementedError()


class EmptyRegisterContent(RegisterContent):
    def __init__(self, size: int):
        super().__init__(None, RegisterType.EMPTY, size)
