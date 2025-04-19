import copy
from dataclasses import dataclass, field
from enum import Enum

from src.expression_manager.expression_node import (
    ExpressionNode,
    ExpressionOperationType,
    ExpressionType,
    check_nodes_need_cast_to,
    get_common_type,
)
from src.expression_manager.types.opencl_types import OpenCLTypes, make_opencl_type
from src.model.kernel_argument import KernelArgument
from src.register_type import CONSTANT_VALUES, RegisterType
from src.utils.singleton import Singleton


class VariableAddressSpaceQualifiers(Enum):
    UNKNOWN = ""
    GLOBAL = "__global"
    LOCAL = "__local"
    CONST = "__constant"
    PRIVATE = "__private"


@dataclass
class VariableInfo:
    name: str = ""
    var_node: ExpressionNode = None
    value_node: ExpressionNode = None
    address_space_qualifier: VariableAddressSpaceQualifiers = field(default_factory=
                                                                    lambda: VariableAddressSpaceQualifiers.UNKNOWN)
    is_pointer: bool = False
    is_const: bool = False


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

    def create_var_node(self, var_name: str, var_type_hint: OpenCLTypes) -> ExpressionNode:
        var_node = ExpressionNode()
        var_node.type = ExpressionType.VAR
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

        # todo find vars inside
        if (s0.type == ExpressionType.VAR and self.get_variable_info(s0).is_pointer) or (s0.type == ExpressionType.VAR and self.get_variable_info(s0).address_space_qualifier == VariableAddressSpaceQualifiers.GLOBAL):
            # todo limit
            op_value_type_hint = s0.value_type_hint
        elif (s1.type == ExpressionType.VAR and self.get_variable_info(s1).is_pointer) or (s1.type == ExpressionType.VAR and self.get_variable_info(s1).address_space_qualifier == VariableAddressSpaceQualifiers.GLOBAL):
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
                value_type_hint = get_common_type(s0.value_type_hint, s1.value_type_hint)
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

    def get_kernel_argument_type_and_qualifiers(
            self,
            arg: KernelArgument) -> tuple[OpenCLTypes, VariableAddressSpaceQualifiers]:

        qualifier = VariableAddressSpaceQualifiers.UNKNOWN
        arg_type_str = arg.type_name
        if arg_type_str.startswith("__global "):
            arg_type_str = arg_type_str.removeprefix("__global ")
            qualifier = VariableAddressSpaceQualifiers.GLOBAL
        elif arg_type_str.startswith("__local "):
            arg_type_str = arg_type_str.removeprefix("__local ")
            qualifier = VariableAddressSpaceQualifiers.LOCAL
        elif arg_type_str.startswith("__private "):
            arg_type_str = arg_type_str.removeprefix("__private ")
            qualifier = VariableAddressSpaceQualifiers.PRIVATE
        elif arg_type_str.startswith("__constant "):
            arg_type_str = arg_type_str.removeprefix("__constant ")
            qualifier = VariableAddressSpaceQualifiers.CONST
        value_type_hint = make_opencl_type(arg_type_str)

        return (value_type_hint, qualifier)

    def add_kernel_argument(self, arg: KernelArgument, offset: int, check_duplicate: bool = True) -> ExpressionNode:  # noqa: FBT001, FBT002
        if arg.hidden:
            for reg_type in CONSTANT_VALUES:
                reg_type_name = CONSTANT_VALUES[reg_type][0]
                if arg.name == reg_type_name:
                    return self.add_register_node(reg_type, arg.name)

            # don't add other hidden data like _.printf_buffer, _.vqueue_pointer, _.aqlwrap_pointer and so on
            return None

        name = arg.name if not arg.is_vector() else arg.get_vector_element_by_offset(offset)
        value_type_hint, qualifiers = self.get_kernel_argument_type_and_qualifiers(arg)
        return self.add_variable_node(name, value_type_hint, qualifiers, arg.const, check_duplicate)

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
            var_node_name = var_name[1:]
            is_pointer = True
        else:
            var_node_name = var_name
            is_pointer = False
        return (var_node_name, is_pointer)

    def add_variable_node(
        self,
        name: str,
        value_type_hint: OpenCLTypes,
        qualifier: VariableAddressSpaceQualifiers = VariableAddressSpaceQualifiers.UNKNOWN,
        is_const: bool = False,
        check_duplicate: bool = True,  # noqa: FBT001, FBT002
    ) -> ExpressionNode:
        var_name, is_pointer = self.parse_variable_name(name)

        if check_duplicate and self._variables.get(var_name) is not None:
            return self._variables[var_name].var_node

        # "{var}___s{idx}" case, make sure full variable is there too
        vector_element_symbol_pos = var_name.find("___")
        is_vector_element = vector_element_symbol_pos != -1
        if is_vector_element and value_type_hint.value.number_of_components > 1:
            base_var_name = name[:vector_element_symbol_pos]
            if check_duplicate and self._variables.get(base_var_name) is None:
                self.add_variable_node(base_var_name, value_type_hint, qualifier, check_duplicate)
            value_type_hint = value_type_hint.set_number_of_components(1)

        var_node = self.create_var_node(var_name, value_type_hint)

        self._variables[var_name] = VariableInfo(var_name, var_node, None, qualifier, is_pointer, is_const)

        self.add_node(var_node)

        return var_node

    def expression_to_string(self, node: ExpressionNode):
        return self._expression_to_string(node, False)


    def simplify_node(self, node: ExpressionNode):
        pass

    def get_variable_info(self, node: ExpressionNode) -> VariableInfo:
        assert node is not None
        assert node.type == ExpressionType.VAR
        return self._variables[node.value]

    def _op_expression_to_string(self, expression_node: ExpressionNode, need_cast: bool) -> str:
        assert expression_node is not None
        assert expression_node.type == ExpressionType.OP

        operation = expression_node.value
        left_node = expression_node.left
        right_node = expression_node.right
        parent_node = expression_node.parent

        if operation == ExpressionOperationType.NOT:
            return f"!({self._expression_to_string(left_node,
                                                   check_nodes_need_cast_to(left_node, expression_node))})"

        # special case for: data_ptr + smth => data_ptr[smth]
        if operation == ExpressionOperationType.PLUS and left_node.type == ExpressionType.VAR:
            variable_info = self.get_variable_info(left_node)
            if variable_info.is_pointer:
                return f"{left_node.value!s}[{self._expression_to_string(right_node, False)}]"

        left_value = self._expression_to_string(
            left_node, check_nodes_need_cast_to(left_node, expression_node)
        )
        operator = str(operation.value)
        right_value = self._expression_to_string(
            right_node, check_nodes_need_cast_to(right_node, expression_node)
        )

        # todo brackets rule
        if parent_node is None:
            return f"{left_value} {operator} {right_value}"

        return f"({left_value} {operator} {right_value})"
    
    def _var_expression_to_string(self, var_node: ExpressionNode, need_cast: bool) -> str:
        assert var_node is not None
        assert var_node.type == ExpressionType.VAR

        variable_info = self.get_variable_info(var_node)
        address_space_qualifier_str = ""
        if variable_info.address_space_qualifier != VariableAddressSpaceQualifiers.UNKNOWN:
            address_space_qualifier_str = f"{variable_info.address_space_qualifier.value} "
        constness_str = "const " if variable_info.is_const else ""
        variable_type_str = str(var_node.value_type_hint)
        ptr_str = "* " if variable_info.is_pointer else " "
        var_name_str = var_node.value

        return address_space_qualifier_str + constness_str + variable_type_str + ptr_str + var_name_str

    def _expression_to_string(self, expression_node: ExpressionNode, need_cast: bool) -> str:
        assert expression_node is not None

        match expression_node.type:
            case ExpressionType.OP:
                return self._op_expression_to_string(expression_node, need_cast)
            case ExpressionType.VAR:
                return self._var_expression_to_string(expression_node, need_cast)
            case ExpressionType.PERMUTE:
                # todo check types
                left_value = self._expression_to_string(expression_node.left, False)
                right_value = self._expression_to_string(expression_node.right, False)
                return f"{left_value}, {right_value}"
            case ExpressionType.IF_TERNARY:
                # todo
                cond_value = self._expression_to_string(expression_node.value)
                left_value = self._expression_to_string(expression_node.left)
                right_value = self._expression_to_string(expression_node.right)
                return f"({cond_value}) ? ({left_value}) : ({right_value})"
            case _:
                ret_str = str(expression_node.value)
                ret_str = f"({ret_str})"
                if need_cast:
                    if expression_node.parent is None:
                        return f"({OpenCLTypes.UNKNOWN}){ret_str}"
                    else:
                        return f"({expression_node.parent.value_type_hint}){ret_str}"
                else:
                    return f"{ret_str}"
