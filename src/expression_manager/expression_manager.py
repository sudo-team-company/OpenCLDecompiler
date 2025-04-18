import copy
from dataclasses import dataclass, field
from enum import Enum

from src.expression_manager.expression_node import (
    ExpressionNode,
    ExpressionOperationType,
    ExpressionType,
    expression_to_string_private,
    get_common_type,
)
from src.register_type import CONSTANT_VALUES, RegisterType
from src.types.opencl_types import OpenCLTypes, TypeModifiers, make_opencl_type
from src.utils.singleton import Singleton


class VariableTypeModifiers(Enum):
    GLOBAL = "__global"
    LOCAL = "__local"
    PRIVATE = "__private"
    CONST = "const"
    RESTRICT = "restrict"


@dataclass
class VariableInfo:
    name: str = ""
    var_node: ExpressionNode = None
    value_node: ExpressionNode = None
    modifiers: set[VariableTypeModifiers] = field(default_factory=lambda: set())
    is_pointer: bool = False


class ExpressionManager(metaclass=Singleton):
    def __init__(self):
        self._nodes = []
        self._variables: dict[str, VariableInfo] = {}

    def reset(self):
        self._nodes = []
        self._variables: dict[str, VariableInfo] = {}

    def create_const_node(self, value, value_type_hint: OpenCLTypes) -> ExpressionNode:
        const_node = ExpressionNode()
        const_node.type = ExpressionType.CONST
        const_node.value = value
        const_node.value_type_hint = value_type_hint
        return const_node

    def create_op_node(
        self, op: ExpressionOperationType, left: ExpressionNode, right: ExpressionNode, value_type_hint: OpenCLTypes
    ) -> ExpressionNode:
        op_node = ExpressionNode()
        op_node.type = ExpressionType.OP
        op_node.value = op
        op_node.value_type_hint = value_type_hint
        op_node.left = left
        op_node.right = right
        left.parent = op_node
        right.parent = op_node
        return op_node

    def create_var_node(self, var_name: str, var_type: ExpressionType, var_type_hint: OpenCLTypes) -> ExpressionNode:
        assert var_type in (ExpressionType.VAR, ExpressionType.VAR_PTR)
        var_node = ExpressionNode()
        var_node.type = var_type
        var_node.value = var_name
        var_node.value_type_hint = var_type_hint
        return var_node

    def add_node(self, node: ExpressionNode):
        assert node is not None

        if self.expression_to_string(node) == "get_global_offset(0) + (uint)arg0___s0":
            pass
        assert node.value_type_hint != OpenCLTypes.UNKNOWN

        print("add_node:", self.expression_to_string(node))  # noqa: T201
        self._nodes.append(node)

    # todo: rename  # noqa: ERA001
    def add_offset_thingy_node(self, s0: ExpressionNode, s1: ExpressionNode, data_size: int):
        data_size_node = self.add_const_node(data_size, OpenCLTypes.UINT)
        div_node = self.add_operation(s1, data_size_node, ExpressionOperationType.DIV, OpenCLTypes.UINT)
        expr_node = self.add_operation(s0, div_node, ExpressionOperationType.PLUS, OpenCLTypes.UINT)

        print("added offset thingy node:", self.expression_to_string(expr_node))  # noqa: T201
        return expr_node

    def add_operation(
        self, s0: ExpressionNode, s1: ExpressionNode, op: ExpressionOperationType, value_type_hint: OpenCLTypes
    ):
        assert s0 is not None
        assert s1 is not None

        if op == ExpressionOperationType.XOR:
            if s0.type == ExpressionType.UNKNOWN:
                operation_node = ExpressionNode()
                operation_node.type = ExpressionType.OP
                operation_node.value = ExpressionOperationType.NOT
                # todo bool?
                operation_node.value_type_hint = s1.value_type_hint
                operation_node.left = s1
                self.add_node(operation_node)
                return operation_node
            if s1.type == ExpressionType.UNKNOWN:
                operation_node = ExpressionNode()
                operation_node.type = ExpressionType.OP
                operation_node.value = ExpressionOperationType.NOT
                # todo bool?
                operation_node.value_type_hint = s0.value_type_hint
                operation_node.left = s0
                self.add_node(operation_node)
                return operation_node

        # todo optimize if one is empty

        # todo find var_ptrs inside
        if s0.type == ExpressionType.VAR_PTR or TypeModifiers.GLOBAL in s0.value_type_hint.value.modifiers:
            # todo limit
            op_value_type_hint = s0.value_type_hint
        elif s1.type == ExpressionType.VAR_PTR or TypeModifiers.GLOBAL in s1.value_type_hint.value.modifiers:
            # todo limit
            op_value_type_hint = s1.value_type_hint
        elif (op in (ExpressionOperationType.PLUS, ExpressionOperationType.MINUS)) and (
            str(s0.value) == "0" or str(s1.value) == "0"
        ):
            if str(s0.value) == "0":
                op_value_type_hint = s1.value_type_hint
            elif str(s1.value) == "0":
                op_value_type_hint = s0.value_type_hint
        else:
            if value_type_hint == OpenCLTypes.UNKNOWN:
                op_value_type_hint = get_common_type(s0.value_type_hint, s1.value_type_hint)
            op_value_type_hint = value_type_hint  # get_common_type(get_common_type(s0.value_type_hint, s1.value_type_hint), value_type_hint)  # noqa: E501

        operation_node = self.create_op_node(op, s0, s1, op_value_type_hint)

        self.add_node(operation_node)
        print("added operation:", self.expression_to_string(operation_node))  # noqa: T201
        return operation_node

    def invert_node(self, node: ExpressionNode) -> ExpressionNode:
        print("INVERTING NODE")  # noqa: T201
        if node.type == ExpressionType.OP and node.value.is_compare_operator():
            tmp = ExpressionNode()
            tmp.type = ExpressionType.OP
            tmp.value = ExpressionOperationType.NOT
            # todo bool?
            tmp.value_type_hint = node.value_type_hint
            tmp.left = node
            self.add_node(tmp)
            return tmp
        tmp = self.add_const_node(-1, OpenCLTypes.INT)
        return self.add_operation(tmp, node, ExpressionOperationType.MUL, node.value_type_hint)

    def add_kernel_argument(self, kernel_arg, offset: int, check_duplicate: bool = True) -> ExpressionNode:  # noqa: FBT001, FBT002
        from src.model.kernel_argument import KernelArgument

        arg: KernelArgument = kernel_arg
        if arg.hidden:
            for reg_type in CONSTANT_VALUES:
                reg_type_name = CONSTANT_VALUES[reg_type][0]
                if arg.name == reg_type_name:
                    return self.add_register_node(reg_type, arg.name)

            # don't add other hidden data like _.printf_buffer, _.vqueue_pointer, _.aqlwrap_pointer and so on
            return None

        name = arg.name if not arg.is_vector() else arg.get_vector_element_by_offset(offset)
        value_type_hint = make_opencl_type(arg.type_name)
        modifiers = set()
        if value_type_hint.value.is_global():
            modifiers.add(VariableTypeModifiers.GLOBAL)
        if arg.const:
            modifiers.add(VariableTypeModifiers.CONST)

        return self.add_variable_node(name, value_type_hint, modifiers, check_duplicate)

    def get_empty_node(self):
        empty_node = ExpressionNode()
        empty_node.value = "UNKNOWN VALUE"
        return empty_node

    def add_register_node(self, reg_type: RegisterType, value=None) -> ExpressionNode:
        if reg_type == RegisterType.UNKNOWN:
            return None

        # special cases
        if reg_type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE:
            left_node = self.add_register_node(RegisterType.WORK_GROUP_ID_X, "")
            right_node = self.add_register_node(RegisterType.LOCAL_SIZE_X, "")
            return self.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
        if reg_type == RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE:
            left_node = self.add_register_node(RegisterType.WORK_GROUP_ID_Y, "")
            right_node = self.add_register_node(RegisterType.LOCAL_SIZE_Y, "")
            return self.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
        if reg_type == RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE:
            left_node = self.add_register_node(RegisterType.WORK_GROUP_ID_Z, "")
            right_node = self.add_register_node(RegisterType.LOCAL_SIZE_Z, "")
            return self.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)

        assert reg_type in CONSTANT_VALUES or reg_type == RegisterType.INT32

        new_node = None

        if reg_type in CONSTANT_VALUES:
            reg_type_name = CONSTANT_VALUES[reg_type][0]
            # we can deduce OpenCLType here, cause it's constant value, but let's set it to UINT for now
            new_node = self.add_const_node(reg_type_name, OpenCLTypes.UINT)
            # new_node = ExpressionNode(ExpressionType.FUNC, reg_type_name, OpenCLTypes.UINT)  # noqa: ERA001
        else:
            assert value is not None
            new_node = self.add_const_node(value, OpenCLTypes.INT)

        print("add_register_node:", reg_type, value, "node:", new_node.type, new_node.value_type_hint)  # noqa: T201
        return new_node

    def add_const_node(self, value, value_type_hint: OpenCLTypes):
        const_node = self.create_const_node(value, value_type_hint)

        self.add_node(const_node)
        return const_node

    def add_if_ternary_node(self, cond: ExpressionNode, s0: ExpressionNode, s1: ExpressionNode):
        if_ternary_node = ExpressionNode()
        if_ternary_node.type = ExpressionType.IF_TERNARY
        if_ternary_node.value = cond
        if_ternary_node.left = s0
        if_ternary_node.right = s1
        if_ternary_node.value_type_hint = get_common_type(s0.value_type_hint, s1.value_type_hint)

        s0.parent = if_ternary_node
        s1.parent = if_ternary_node

        self.add_node(if_ternary_node)

        return if_ternary_node

    def add_permute_node(self, s0: ExpressionNode, s1: ExpressionNode) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None
        assert s0.type == ExpressionType.VAR
        assert s1.type == ExpressionType.VAR

        permute_node = ExpressionNode()
        permute_node.type = ExpressionType.PERMUTE
        permute_node.left = s0
        permute_node.right = s1

        s0.parent = permute_node
        s1.parent = permute_node

        # todo double check that
        new_value_type_hint = copy.deepcopy(get_common_type(s0.value_type_hint, s1.value_type_hint).value)
        new_value_type_hint.number_of_components = (
            s0.value_type_hint.value.number_of_components + s1.value_type_hint.value.number_of_components
        )
        permute_node.value_type_hint = make_opencl_type(str(new_value_type_hint))

        self.add_node(permute_node)

        return permute_node

    # todo rename??
    def apply_operation_to_nodes(self, nodes: list[ExpressionNode], op: ExpressionOperationType):
        assert len(nodes) > 0

        if len(nodes) == 1:
            return nodes[0]

        prev_node = nodes[0]
        for cur_node in nodes[1:]:
            prev_node = self.add_operation(prev_node, cur_node, op, OpenCLTypes.UNKNOWN)

        return prev_node

    def parse_variable_name(self, var_name: str) -> tuple[str, ExpressionType]:
        if var_name[0] == "*":
            var_node_type = ExpressionType.VAR_PTR
            var_node_name = var_name[1:]
        else:
            var_node_type = ExpressionType.VAR
            var_node_name = var_name
        return (var_node_name, var_node_type)

    def add_variable_node(
        self,
        name: str,
        value_type_hint: OpenCLTypes,
        modifiers: set[VariableTypeModifiers] | None = None,
        check_duplicate: bool = True,  # noqa: FBT001, FBT002
    ) -> ExpressionNode:
        if modifiers is None:
            modifiers = set()
        var_name, var_node_type = self.parse_variable_name(name)

        if check_duplicate and self._variables.get(var_name) is not None:
            return self._variables[var_name].var_node

        # "{var}___s{idx}" case, make sure full variable is there too
        vector_element_symbol_pos = var_name.find("___")
        is_vector_element = vector_element_symbol_pos != -1
        if is_vector_element and value_type_hint.value.number_of_components > 1:
            base_var_name = name[:vector_element_symbol_pos]
            if check_duplicate and self._variables.get(base_var_name) is None:
                self.add_variable_node(base_var_name, value_type_hint, modifiers, check_duplicate)
            value_type_hint = value_type_hint.set_number_of_components(1)

        var_node = self.create_var_node(var_name, var_node_type, value_type_hint)

        self._variables[var_name] = VariableInfo(var_name, var_node, None, modifiers)

        self.add_node(var_node)

        return var_node

    def expression_to_string(self, node: ExpressionNode):
        return expression_to_string_private(node)
