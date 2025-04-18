import copy
import itertools
import re

from src.expression_manager.expression_manager import ExpressionManager
from src.types.opencl_types import OpenCLTypes
from src.constants import DEFAULT_REGISTER_SIZE
from src.integrity import Integrity
from src.opencl_types import vector_type_dict
from src.register_content import RegisterContent, RegisterSignType
from src.register_type import RegisterType


class Register:
    def __init__(
        self,
        *,
        integrity,
        register_content: RegisterContent,
        size: int = DEFAULT_REGISTER_SIZE,
        exec_condition=None,
    ):
        self.integrity: Integrity = integrity
        self._version_name: str = ""
        self._version_num: int = 0
        self.prev_version = []
        self.exec_condition = exec_condition
        self.register_content: RegisterContent = register_content
        self._size = size

    @property
    def val(self) -> object:
        return self.register_content.get_value()

    @property
    def type(self) -> RegisterType:
        return self.register_content.get_type()

    @property
    def data_type(self) -> str:
        return self.register_content.get_data_type()

    @property
    def size(self) -> int:
        return self.register_content.get_size()

    @property
    def sign(self) -> RegisterSignType:
        return self.register_content.get_sign()

    @property
    def version(self) -> str:
        return f"{self._version_name}_{self._version_num}"

    def __copy__(self):
        return Register(
            integrity=copy.copy(self.integrity),
            register_content=copy.copy(self.register_content),
            size=copy.copy(self.size),
        )

    def cast_to(self, data_type: str):
        self.register_content._data_type = data_type  # noqa: SLF001
        self.register_content._expression_node.cast_to(OpenCLTypes.from_string(data_type))

    def get_value(self) -> object:
        return self.register_content.get_value()

    def get_type(self) -> RegisterType:
        return self.register_content.get_type()

    def get_data_type(self) -> str:
        return self.register_content.get_data_type()

    def get_size(self) -> int:
        return self._size

    def try_simplify(self) -> bool:
        new_content = self.register_content.maybe_simplify()

        if new_content is not None:
            self.register_content = new_content
            return True

        return False

    def __and__(self, other):
        if not isinstance(other, str):
            raise NotImplementedError

        result_register = Register(
            integrity=self.integrity,
            register_content=self.register_content & other,
            size=self.get_size(),
        )
        result_register.try_simplify()

        return result_register

    def __or__(self, other):
        if isinstance(other, int):
            result_register = Register(
                integrity=self.integrity,
                register_content=self.register_content | other,
                size=self.get_size(),
            )
            result_register.try_simplify()
            return result_register

        if isinstance(other, Register):
            result_register = Register(
                integrity=self.integrity,
                register_content=self.register_content | other.register_content,
                size=self.get_size(),
            )
            result_register.try_simplify()
            return result_register

        raise NotImplementedError

    def __rshift__(self, other):
        if not isinstance(other, int):
            raise NotImplementedError

        result_register = Register(
            integrity=self.integrity,
            register_content=self.register_content >> other,
            size=self.get_size(),
        )
        result_register.try_simplify()

        return result_register

    def __lshift__(self, other):
        if not isinstance(other, int):
            raise NotImplementedError

        result_register = Register(
            integrity=self.integrity,
            register_content=self.register_content << other,
            size=self.get_size(),
        )
        result_register.try_simplify()

        return result_register

    def __add__(self, other):
        if not isinstance(other, Register):
            raise NotImplementedError

        result_register = Register(
            integrity=self.integrity,
            register_content=self.register_content + other.register_content,
            size=self.get_size(),
        )
        result_register.try_simplify()

        return result_register

    def __sub__(self, other):
        if not isinstance(other, Register):
            raise NotImplementedError

        result_register = Register(
            integrity=self.integrity,
            register_content=self.register_content - other.register_content,
            size=self.get_size(),
        )
        result_register.try_simplify()

        return result_register

    def __mul__(self, other):
        if isinstance(other, Register):
            result_register = Register(
                integrity=self.integrity,
                register_content=self.register_content * other.register_content,
                size=self.get_size(),
            )
        elif isinstance(other, int):
            from src.decompiler_data import DecompilerData

            _mul_simplify_combinations = [
                *[
                    (
                        frozenset(
                            {
                                RegisterType[f"WORK_GROUP_ID_{dim}"],
                                DecompilerData().config_data.size_of_work_groups[i],
                            }
                        ),
                        (
                            f"get_group_id({i}) * get_local_size({i})",
                            RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"],
                            RegisterSignType.POSITIVE,
                        ),
                    )
                    for i, dim in enumerate("XYZ")
                ]
            ]

            for simplify_combination in _mul_simplify_combinations:
                types_to_find, simplification = simplify_combination
                types_to_find_permutations = list(itertools.permutations(types_to_find))

                for permutation in types_to_find_permutations:
                    if permutation == (self.get_type(), other):
                        simplified_value, simplified_type, simplified_sign = simplification

                        result_register = Register(
                            integrity=self.integrity,
                            register_content=RegisterContent(
                                value=simplified_value,
                                type_=simplified_type,
                                size=self.get_size(),
                                sign=simplified_sign,
                                data_type=self.get_data_type(),
                                expression_node=ExpressionManager().add_register_node(simplified_type)
                            ),
                            size=self.get_size(),
                        )
                        result_register.try_simplify()
                        return result_register

            result_register = Register(
                integrity=self.integrity,
                register_content=self.register_content * other,
                size=self.get_size(),
            )
        else:
            raise NotImplementedError

        result_register.try_simplify()

        return result_register

    def copy_version_from(self, other: "Register"):
        self._version_name = other._version_name  # noqa: SLF001
        self._version_num = other._version_num  # noqa: SLF001

    def add_version(self, name_version, num_version):
        self._version_name = name_version
        self._version_num = num_version + 1

    def make_prev(self):
        self.prev_version = [f"{self._version_name}_{self._version_num - 1}"]


def is_vector_type(data_type: str) -> bool:
    return data_type in vector_type_dict


def is_sgpr(reg: str) -> bool:
    """Matches s0, s12 and etc."""
    return re.match(r"s\d+", reg) is not None


def is_vgpr(reg: str) -> bool:
    """Matches v0, v12 and etc."""
    return re.match(r"v\d+", reg) is not None or reg == "vcc"


def is_reg(reg: str) -> bool:
    return is_sgpr(reg) or is_vgpr(reg)


def is_sgpr_pair(reg: str) -> bool:
    """Matches s[0:1], s[10:11] and etc."""
    if re.match(r"s\[\d+:\d+]", reg) is not None:
        start, end = reg.split(":")
        start: int = int(start[2:])
        end: int = int(end[:-1])
        return end - start == 1
    return False


def is_vgpr_pair(reg: str) -> bool:
    """Matches v[0:1], v[10:11] and etc."""
    if re.match(r"v\[\d+:\d+]", reg) is not None:
        start, end = reg.split(":")
        start: int = int(start[2:])
        end: int = int(end[:-1])
        return end - start == 1
    return False


def is_pair(reg: str) -> bool:
    return is_sgpr_pair(reg) or is_vgpr_pair(reg)


def is_sgpr_range(reg: str) -> bool:
    """Matches s[0:1], s[10:12] and etc."""
    return re.match(r"s\[\d+:\d+]", reg) is not None


def is_vgpr_range(reg: str) -> bool:
    """Matches v[0:1], v[10:12] and etc."""
    return re.match(r"v\[\d+:\d+]", reg) is not None


def is_range(reg: str) -> bool:
    return is_vgpr_range(reg) or is_sgpr_range(reg)


def split_range(reg: str) -> (str, str):
    """Splits v[0:1], s[10:12] and etc."""
    start, end = reg.split(":")
    start: str = reg[0] + start[2:]
    end: str = reg[0] + end[:-1]
    return start, end


def check_and_split_regs(reg: str) -> (str, str):
    return split_range(reg) if is_range(reg) else (reg, reg)


def check_and_split_regs_range_to_full_list(reg: str) -> [str]:
    if not is_range(reg):
        return [reg]
    start, end = reg.split(":")
    return [reg[0] + str(i) for i in range(int(start[2:]), int(end[:-1]) + 1)]


def get_next_reg(reg: str) -> str:
    return reg[0] + str(int(reg[1:]) + 1)
