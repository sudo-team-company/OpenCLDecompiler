import copy
from typing import Optional

from src.constants import DEFAULT_REGISTER_SIZE
from src.expression_manager.expression_manager import ExpressionManager, ExpressionNode
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register_type import CONSTANT_VALUES, RegisterSignType, RegisterType


class RegisterContent:
    def __init__(  # noqa: PLR0913
        self,
        value: list[object] | object,
        type_: list | RegisterType,
        size: list | int = DEFAULT_REGISTER_SIZE,
        data_type: list | str | None = None,
        sign: list | RegisterSignType = RegisterSignType.POSITIVE,
        expression_node: list[ExpressionNode] | ExpressionNode = None,
    ):
        if type_ is RegisterType and type_ in CONSTANT_VALUES:
            self._type = type_
            self._value, self._size, self._data_type, self._sign = CONSTANT_VALUES[type_]
            # TODO: remove deviation check
            assert self._value == value or value is None
            assert self._type == type_ or type_ is None
            assert self._size == size or size is None
            assert self._data_type == data_type or data_type is None
            assert self._sign == sign or sign is None
            return
        self._value = value
        self._type = type_
        self._size = size
        self._data_type = data_type
        self._sign = sign
        self._expression_node = expression_node

    def get_value(self) -> object:
        return self._value

    def get_type(self) -> RegisterType:
        return self._type

    def get_size(self) -> int:
        return self._size

    def get_data_type(self) -> str | None:
        return self._data_type

    def get_sign(self) -> RegisterSignType:
        return self._sign

    def get_expression_node(self) -> ExpressionNode:
        return self._expression_node

    def set_expression_node(self, node: ExpressionNode):
        self._expression_node = node

    def maybe_simplify(self) -> Optional["RegisterContent"]:
        return None

    def __invert__(self):
        self._sign = self._sign.__invert__()

    def __and__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # noqa: PLC0415

            return OperationRegisterContent(
                operation=OperationType.BITWISE_AND,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        if isinstance(other, str) and other.startswith("0x"):
            bit_str = f"{int(other, 16):b}"
            if bit_str.count("0") == 0 and len(bit_str) == self.get_size():
                return copy.deepcopy(self)

        raise NotImplementedError

    def __or__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # noqa: PLC0415

            return OperationRegisterContent(
                operation=OperationType.BITWISE_OR,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        raise NotImplementedError

    def __rshift__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # noqa: PLC0415

            return OperationRegisterContent(
                operation=OperationType.R_SHIFT,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        raise NotImplementedError

    def __lshift__(self, other):
        if isinstance(other, int):
            from src.operation_register_content import OperationRegisterContent, OperationType  # noqa: PLC0415

            return OperationRegisterContent(
                operation=OperationType.L_SHIFT,
                register_contents=[
                    copy.deepcopy(self),
                    RegisterContent(
                        value=other,
                        type_=RegisterType.UNKNOWN,
                        size=0,
                        data_type=None,
                        expression_node=ExpressionManager().add_const_node(other, OpenCLTypes.UINT),
                    ),
                ],
            )

        raise NotImplementedError

    def __add__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # noqa: PLC0415

            return OperationRegisterContent(
                operation=OperationType.PLUS,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        raise NotImplementedError

    def __sub__(self, other):
        if isinstance(other, RegisterContent):
            from src.operation_register_content import OperationRegisterContent, OperationType  # noqa: PLC0415

            return OperationRegisterContent(
                operation=OperationType.MINUS,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )

        raise NotImplementedError

    def __mul__(self, other):
        from src.operation_register_content import OperationRegisterContent, OperationType  # noqa: PLC0415

        if isinstance(other, RegisterContent):
            return OperationRegisterContent(
                operation=OperationType.PRODUCT,
                register_contents=[
                    copy.deepcopy(self),
                    copy.deepcopy(other),
                ],
            )
        if isinstance(other, int):
            return OperationRegisterContent(
                operation=OperationType.PRODUCT,
                register_contents=[
                    copy.deepcopy(self),
                    RegisterContent(
                        value=other,
                        type_=RegisterType.INT32,
                        size=0,
                        data_type=None,
                        expression_node=ExpressionManager().add_const_node(other, OpenCLTypes.INT),
                    ),
                ],
            )
        raise NotImplementedError


class EmptyRegisterContent(RegisterContent):
    def __init__(self, size: int):
        super().__init__(None, RegisterType.EMPTY, size)
