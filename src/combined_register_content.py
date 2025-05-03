from collections.abc import Iterable

from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import ExpressionNode
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register_content import EmptyRegisterContent, RegisterContent, RegisterSignType
from src.register_type import RegisterType


class CombinedRegisterContent(RegisterContent):
    def __init__(self, register_contents: Iterable[RegisterContent], expression_node: Iterable[ExpressionNode] = None):
        if expression_node is not None:
            assert len(expression_node) == len(register_contents)
        super().__init__(
            value=[content.get_value() for content in register_contents],
            type_=[content.get_type() for content in register_contents],
            size=[content.get_size() for content in register_contents],
            data_type=[content.get_data_type() for content in register_contents],
            sign=[content.get_sign() for content in register_contents],
            expression_node=expression_node
            if expression_node is not None
            else [content.get_expression_node() for content in register_contents],
        )

    def append_content(self, register_content: RegisterContent):
        self._value.append(register_content.get_value())
        self._type.append(register_content.get_type())
        self._size.append(register_content.get_size())
        self._data_type.append(register_content.get_data_type())
        self._sign.append(register_content.get_sign())
        self._expression_node.append(register_content.get_expression_node())

    def maybe_get_by_idx(self, idx: int) -> RegisterContent | None:
        return RegisterContent(
            value=self._value[idx],
            type_=self._type[idx],
            size=self._size[idx],
            data_type=self._data_type[idx],
            sign=self._sign[idx],
            expression_node=self._expression_node[idx],
        )

    def get_count(self) -> int:
        return len(self._value)

    def maybe_simplify(self) -> RegisterContent | None:
        if len(self._value) == 1:
            return RegisterContent(
                value=self._value[0],
                type_=self._type[0],
                size=self._size[0],
                data_type=self._data_type[0],
                sign=self._sign[0],
                expression_node=self._expression_node[0],
            )

        if len(self._value) == 2 and self._type[0] == RegisterType.EMPTY:  # noqa: PLR2004
            return RegisterContent(
                value=self._value[1],
                type_=self._type[1],
                size=self._size[1],
                data_type=self._data_type[1],
                sign=self._sign[1],
                expression_node=self._expression_node[1],
            ) * (2 ** int(self._size[0]))

        return None

    def _maybe_acquire_content(self, begin: int, end: int) -> RegisterContent | None:
        curr_pos = 0
        for value, type_, size, data_type, sign, expression_node in zip(
            self._value,
            self._type,
            self._size,
            self._data_type,
            self._sign,
            self._expression_node,
            strict=False,
        ):
            if curr_pos == begin and curr_pos + size - 1 >= end:
                return RegisterContent(
                    value=value, type_=type_, size=size, data_type=data_type, sign=sign, expression_node=expression_node
                )

            curr_pos += size

        return None

    def get_value(self) -> object:
        return self._value[0]

    def get_type(self) -> RegisterType:
        return self._type[0]

    def get_data_type(self) -> str | None:
        return self._data_type[0]

    def get_size(self) -> int:
        return sum(self._size)

    def get_sign(self) -> RegisterSignType:
        return self._sign[0]

    def get_expression_node(self) -> ExpressionNode:
        return self._expression_node[0]

    def __and__(self, other) -> RegisterContent | None:  # noqa: PLR0912
        if isinstance(other, int | str):
            if isinstance(other, str):
                hex_str = other
                hex_int = int(hex_str, 16)
            if isinstance(other, int):
                hex_int = int(other, 16)

            bit_str = f"{hex_int:b}"

            if hex_int == 0:
                return RegisterContent(
                    value="0",
                    type_=RegisterType.UNKNOWN,
                    size=0,
                    data_type=None,
                    expression_node=ExpressionManager().add_const_node(0, OpenCLTypes.UINT),
                )

            begin = None
            end = None

            for i in range(len(bit_str)):
                reversed_i = len(bit_str) - i - 1

                if begin is None:
                    if bit_str[reversed_i] == "0":
                        continue
                    if bit_str[reversed_i] == "1":
                        begin = i
                        end = begin

                    continue

                if bit_str[reversed_i] == "1":
                    end = i

                    continue
                if bit_str[reversed_i] == "0":
                    break

            for i in range(len(bit_str)):
                reversed_i = len(bit_str) - i - 1

                if i <= end:
                    continue

                if bit_str[reversed_i] == "1":
                    return None

            return self._maybe_acquire_content(begin, end)

        raise NotImplementedError

    def __rshift__(self, other):
        if isinstance(other, int):
            bits = other

            register_contents = []

            add_to_new_combiner_flag = False
            cur_pos = 0
            for value, type_, size, data_type, sign, expression_node in zip(
                self._value,
                self._type,
                self._size,
                self._data_type,
                self._sign,
                self._expression_node,
                strict=False,
            ):
                if bits == cur_pos:
                    add_to_new_combiner_flag = True

                if add_to_new_combiner_flag:
                    register_contents.append(
                        RegisterContent(
                            value=value,
                            type_=type_,
                            size=size,
                            data_type=data_type,
                            sign=sign,
                            expression_node=expression_node,
                        )
                    )
                    continue

                if bits < cur_pos:
                    register_contents.extend(
                        (
                            EmptyRegisterContent(cur_pos - bits),
                            RegisterContent(
                                value=value,
                                type_=type_,
                                size=size,
                                data_type=data_type,
                                sign=sign,
                                expression_node=expression_node,
                            ),
                        )
                    )

                    add_to_new_combiner_flag = True
                    continue

                cur_pos += size

            return CombinedRegisterContent(
                register_contents=register_contents,
            )

        raise NotImplementedError
