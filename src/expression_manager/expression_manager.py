import copy

from src.expression_manager.expression_helper_functions import (
    VECTOR_COMPONENT_DELIMITER,
    ExpressionVariableInfo,
    create_const_node,
    create_if_ternary_node,
    create_logical_not_node,
    create_op_node,
    create_permute_node,
    create_var_node,
    create_work_item_function_node,
    evaluate_operation,
    expression_to_string,
    get_kernel_argument_type_and_qualifiers,
    get_sufficient_type_for_const,
    parse_variable_name,
    var_expression_to_string,
)
from src.expression_manager.expression_node import (
    ExpressionNode,
    ExpressionOperationType,
    ExpressionType,
    ExpressionValueTypeHint,
    TypeAddressSpaceQualifiers,
)
from src.expression_manager.expression_optimizations import (
    NodeSumInfo,
    const_negative_node,
    const_non_zero_node,
    const_one_node,
    const_zero_node,
    group_id_node_mul_size_of_work_groups,
    node_to_list_of_sum_of_nodes,
)
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.model.kernel_argument import KernelArgument
from src.register_type import CONSTANT_VALUES, RegisterType
from src.utils.singleton import Singleton


class ExpressionManager(metaclass=Singleton):
    def __init__(self):
        self._nodes = []
        self._arguments_for_programs: dict[str, dict[str, ExpressionNode]] = {}
        self._variables_for_programs: dict[str, dict[str, ExpressionVariableInfo]] = {}
        self._name_of_program = ""
        self._size_of_workgroups = []
        self._optimized_nodes_to_original: dict[ExpressionNode, ExpressionNode] = {}

    def set_name_of_program(self, name_of_program: str):
        self._name_of_program = name_of_program
        if self._arguments_for_programs.get(self._name_of_program) is None:
            self._arguments_for_programs[self._name_of_program] = {}
        if self._variables_for_programs.get(self._name_of_program) is None:
            self._variables_for_programs[self._name_of_program] = {}

    def set_size_of_workgroups(self, new_size_of_workgroups: list[int]):
        self._size_of_workgroups = new_size_of_workgroups

    def reset(self, name_of_program: str):
        self._nodes = []
        self.set_name_of_program(name_of_program)
        self._size_of_workgroups = []
        self._optimized_nodes_to_original = {}

    def add_node(self, node: ExpressionNode):
        assert node is not None
        assert node.value_type_hint.opencl_type != OpenCLTypes.UNKNOWN
        self._nodes.append(node)

    def add_offset_div_data_size_node(
        self, s0: ExpressionNode, s1: ExpressionNode, data_size: int, opencl_type_hint: OpenCLTypes
    ) -> ExpressionNode:
        data_size_node = self.add_const_node(data_size, OpenCLTypes.UINT)
        div_node = self.add_operation(s1, data_size_node, ExpressionOperationType.DIV, opencl_type_hint)
        return self.add_operation(s0, div_node, ExpressionOperationType.PLUS, opencl_type_hint)

    def _parse_and_optimize_node_sum(  # noqa: C901, PLR0912, PLR0915
        self, left: ExpressionNode, right: ExpressionNode, value_type_hint: ExpressionValueTypeHint
    ) -> ExpressionNode:
        nodes_info: list[NodeSumInfo] = node_to_list_of_sum_of_nodes(left) + node_to_list_of_sum_of_nodes(right)

        filtered_nodes_info = [n for n in nodes_info if n.operation == ExpressionOperationType.PLUS]

        for node_info in nodes_info:
            if node_info.operation == ExpressionOperationType.MINUS:
                removed = False
                for n in filtered_nodes_info:
                    if node_info.node.contents_equal(n.node):
                        filtered_nodes_info.remove(n)
                        removed = True
                        break
                if not removed:
                    filtered_nodes_info.append(node_info)

        result = filtered_nodes_info

        min_worth_checking_node_info = 2
        if len(result) >= min_worth_checking_node_info:
            # Change expressions like
            # `global_offset({i}) + get_group_id({i}) * get_local_size({i}) + get_local_id({i}) + ...`
            # to `get_global_id({i}) + ...`
            local_id_reg_types = [RegisterType[f"WORK_ITEM_ID_{dim}"] for dim in "XYZ"]
            global_offset_reg_types = [RegisterType[f"GLOBAL_OFFSET_{dim}"] for dim in "XYZ"]
            work_group_id_mul_local_size_reg_types = [RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"] for dim in "XYZ"]
            num_groups_reg_types = [RegisterType[f"NUM_GROUPS_{dim}"] for dim in "XYZ"]

            mul_nodes_info = [
                n for n in result if (n.node.type == ExpressionType.OP and n.node.value == ExpressionOperationType.MUL)
            ]

            for i, dim, local_id_dim, global_offset_dim, work_group_id_dim_mul in zip(
                [0, 1, 2],
                "XYZ",
                local_id_reg_types,
                global_offset_reg_types,
                work_group_id_mul_local_size_reg_types,
                strict=False,
            ):
                l_array = [
                    n for n in result if (n.reg_type == local_id_dim and n.operation == ExpressionOperationType.PLUS)
                ]
                g_array = [
                    n
                    for n in result
                    if (n.reg_type == global_offset_dim and n.operation == ExpressionOperationType.PLUS)
                ]
                w_array = [
                    n
                    for n in result
                    if (n.reg_type == work_group_id_dim_mul and n.operation == ExpressionOperationType.PLUS)
                ]

                while len(l_array) > 0 and len(g_array) > 0 and len(w_array) > 0:
                    result.remove(l_array[0])
                    result.remove(g_array[0])
                    result.remove(w_array[0])
                    l_array.remove(l_array[0])
                    g_array.remove(g_array[0])
                    w_array.remove(w_array[0])
                    result.append(
                        NodeSumInfo(
                            self.add_register_node(RegisterType[f"GLOBAL_ID_{dim}"], ""),
                            RegisterType[f"GLOBAL_ID_{dim}"],
                            ExpressionOperationType.PLUS,
                        )
                    )

                # Change expressions like get_num_groups({i}) * get_local_size({i}) + get_group_id({i}) * get_local_size({i}) + ...  # noqa: E501
                # to get_global_size({i}) + ...
                num_groups_mul_size_of_wg_nodes = [
                    n
                    for n in mul_nodes_info
                    if (
                        n.operation == ExpressionOperationType.PLUS
                        and (
                            (
                                n.node.left.type == ExpressionType.WORK_ITEM_FUNCTION
                                and n.node.left.value == num_groups_reg_types[i]
                                and n.node.right.type == ExpressionType.CONST
                                and n.node.right.value == self._size_of_workgroups[i]
                            )
                            or (
                                n.node.right.type == ExpressionType.WORK_ITEM_FUNCTION
                                and n.node.right.value == num_groups_reg_types[i]
                                and n.node.left.type == ExpressionType.CONST
                                and n.node.left.value == self._size_of_workgroups[i]
                            )
                        )
                    )
                ]

                while len(w_array) > 0 and len(num_groups_mul_size_of_wg_nodes) > 0:
                    result.remove(num_groups_mul_size_of_wg_nodes[0])
                    result.remove(w_array[0])
                    w_array.remove(w_array[0])
                    num_groups_mul_size_of_wg_nodes.remove(num_groups_mul_size_of_wg_nodes[0])
                    result.append(
                        NodeSumInfo(
                            self.add_register_node(RegisterType[f"GLOBAL_SIZE_{dim}"]),
                            RegisterType[f"GLOBAL_SIZE_{dim}"],
                            ExpressionOperationType.PLUS,
                        )
                    )

        if len(result) == 0:
            return None

        if result[0].operation != ExpressionOperationType.PLUS:
            value_swapped = False
            for i in range(1, len(result)):
                if result[i].operation == ExpressionOperationType.PLUS:
                    tmp = result[i]
                    result[i] = result[0]
                    result[0] = tmp
                    value_swapped = True
                    break
            if not value_swapped:
                result.insert(
                    0,
                    NodeSumInfo(
                        self.add_const_node(0, OpenCLTypes.UINT), RegisterType.UNKNOWN, ExpressionOperationType.PLUS
                    ),
                )

        cur_node = result[0].node
        if len(result) == 1:
            return cur_node

        for next_node_info in result[1:]:
            if const_zero_node(next_node_info.node):
                continue
            cur_node = create_op_node(next_node_info.operation, cur_node, next_node_info.node, value_type_hint)
        return cur_node

    def _optimized_nodes_sum(
        self, s0: ExpressionNode, s1: ExpressionNode, value_type_hint: ExpressionValueTypeHint
    ) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None

        if const_zero_node(s0):
            return s1
        if const_zero_node(s1):
            return s0
        if const_negative_node(s0) and not const_negative_node(s1):
            return self._optimized_nodes_sum(s1, s0, value_type_hint)
        if const_negative_node(s1):
            s1_abs_value_node = copy.deepcopy(s1)
            s1_abs_value_node.value = abs(s1_abs_value_node.value)
            return self._optimized_nodes_sub(s0, s1_abs_value_node, value_type_hint)
        if s0.value_type_hint.is_pointer and s1.type == ExpressionType.CONST and s1.value != int(s1.value):
            s1 = copy.deepcopy(self._optimized_nodes_to_original[s1])

        plus_node = self._parse_and_optimize_node_sum(s0, s1, value_type_hint)
        if plus_node is None:
            plus_node = create_op_node(ExpressionOperationType.PLUS, s0, s1, value_type_hint)
        return plus_node

    def _optimized_nodes_sub(
        self, s0: ExpressionNode, s1: ExpressionNode, value_type_hint: ExpressionValueTypeHint
    ) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None

        # "0 - (x OP y)" case
        if const_zero_node(s0) and s1.type == ExpressionType.OP:
            if s1.value == ExpressionOperationType.MINUS:
                # "0 - (x - y)" -> "y - x"
                return self._optimized_nodes_sub(s1.right, s1.left, value_type_hint)
            if s1.value in [ExpressionOperationType.MUL, ExpressionOperationType.DIV]:
                return self._optimized_nodes_mul(self.add_const_node(-1, OpenCLTypes.INT), s1, value_type_hint)
        if const_zero_node(s1):
            return s0
        if const_negative_node(s1):
            s1_abs_value_node = copy.deepcopy(s1)
            s1_abs_value_node.value = abs(s1_abs_value_node.value)
            return self._optimized_nodes_sum(s0, s1_abs_value_node, value_type_hint)
        if s0 == s1:
            return self.add_const_node(0, OpenCLTypes.UINT)

        return create_op_node(ExpressionOperationType.MINUS, s0, s1, value_type_hint)

    def _optimized_nodes_mul(
        self, s0: ExpressionNode, s1: ExpressionNode, value_type_hint: ExpressionValueTypeHint
    ) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None

        # Return 0 if multiplying by 0
        if const_zero_node(s0):
            return s0
        if const_zero_node(s1):
            return s1
        # Return other node if multiplying by 1
        if const_one_node(s0):
            return s1
        if const_one_node(s1):
            return s0

        check_combination_reg_type = group_id_node_mul_size_of_work_groups(s0, s1, self._size_of_workgroups)
        if check_combination_reg_type != RegisterType.UNKNOWN:
            return self.add_register_node(check_combination_reg_type, "")

        return create_op_node(ExpressionOperationType.MUL, s0, s1, value_type_hint)

    def _optimized_nodes_div(
        self, s0: ExpressionNode, s1: ExpressionNode, value_type_hint: ExpressionValueTypeHint
    ) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None

        assert not const_zero_node(s1)

        if const_one_node(s1):
            return s0

        # special case for offsets like this one - (get_global_id(0) * 4) / 4
        if (
            s1.type == ExpressionType.CONST
            and s0.type == ExpressionType.OP
            and s0.value == ExpressionOperationType.MUL
            and s0.right.type == ExpressionType.CONST
        ):
            simplified_type = ExpressionValueTypeHint.get_common_type(s0.right.value_type_hint, s1.value_type_hint)
            new_const_value = evaluate_operation(s0.right.value, ExpressionOperationType.DIV, s1.value, simplified_type)
            if new_const_value == 1:
                res_node = copy.deepcopy(s0.left)
            else:
                res_node = copy.deepcopy(s0)
                res_node.right = self.add_const_node(new_const_value, simplified_type.opencl_type)
            return res_node

        return create_op_node(ExpressionOperationType.DIV, s0, s1, value_type_hint)

    def _optimized_nodes_logical_operation(
        self,
        op: ExpressionOperationType,
        s0: ExpressionNode,
        s1: ExpressionNode,
        value_type_hint: ExpressionValueTypeHint,
    ) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None
        assert op.is_logical_operator()

        if op == ExpressionOperationType.XOR:
            if s0.type == ExpressionType.UNKNOWN:
                return self.add_logical_not_node(s1)
            if s1.type == ExpressionType.UNKNOWN:
                return self.add_logical_not_node(s0)

        if ExpressionType.CONST in (s0.type, s1.type):
            const_node = s0 if s0.type == ExpressionType.CONST else s1
            other_node = s1 if s0.type == ExpressionType.CONST else s0
            const_value = 1 if const_node.value else 0
            if op == ExpressionOperationType.OR and const_value:
                return create_const_node(1, value_type_hint)
            if op == ExpressionOperationType.AND:
                if const_value:
                    return other_node
                return create_const_node(0, value_type_hint)

        return create_op_node(op, s0, s1, value_type_hint)

    def add_operation(  # noqa: PLR0912
        self, s0: ExpressionNode, s1: ExpressionNode, op: ExpressionOperationType, opencl_type_hint: OpenCLTypes
    ):
        assert s0 is not None
        assert s1 is not None

        if opencl_type_hint != OpenCLTypes.UNKNOWN:
            if s0.value_type_hint.opencl_type == OpenCLTypes.UNKNOWN:
                s0.value_type_hint.opencl_type = opencl_type_hint
            if s1.value_type_hint.opencl_type == OpenCLTypes.UNKNOWN:
                s1.value_type_hint.opencl_type = opencl_type_hint

        if (s0.type == ExpressionType.VAR and s0.value_type_hint.is_pointer) or (
            s0.type == ExpressionType.VAR and s0.value_type_hint.qualifier == TypeAddressSpaceQualifiers.GLOBAL
        ):
            op_value_type_hint = s0.value_type_hint
        elif (s1.type == ExpressionType.VAR and s1.value_type_hint.is_pointer) or (
            s1.type == ExpressionType.VAR and s1.value_type_hint.qualifier == TypeAddressSpaceQualifiers.GLOBAL
        ):
            op_value_type_hint = s1.value_type_hint
        elif s0.value_type_hint == s1.value_type_hint:
            op_value_type_hint = s0.value_type_hint
        else:
            op_value_type_hint = ExpressionValueTypeHint.get_common_type(s0.value_type_hint, s1.value_type_hint)

        # if both values are constant, we can evaluate expression
        if s0.type == ExpressionType.CONST and s1.type == ExpressionType.CONST:
            simplified_type = ExpressionValueTypeHint.get_common_type(s0.value_type_hint, s1.value_type_hint)
            result = evaluate_operation(s0.value, op, s1.value, simplified_type)
            assert result is not None
            operation_node = self.add_const_node(result, simplified_type.opencl_type)
            op_value_type_hint = simplified_type
        elif op == ExpressionOperationType.PLUS:
            operation_node = self._optimized_nodes_sum(s0, s1, op_value_type_hint)
        elif op == ExpressionOperationType.MINUS:
            operation_node = self._optimized_nodes_sub(s0, s1, op_value_type_hint)
        elif op == ExpressionOperationType.MUL:
            operation_node = self._optimized_nodes_mul(s0, s1, op_value_type_hint)
        elif op == ExpressionOperationType.DIV:
            operation_node = self._optimized_nodes_div(s0, s1, op_value_type_hint)
        elif op.is_logical_operator():
            operation_node = self._optimized_nodes_logical_operation(op, s0, s1, op_value_type_hint)
        else:
            operation_node = create_op_node(op, s0, s1, op_value_type_hint)

        unoptimized_s0 = s0
        if s0 in self._optimized_nodes_to_original:
            unoptimized_s0 = copy.deepcopy(self._optimized_nodes_to_original[s0])
        unoptimized_s1 = s1
        if s1 in self._optimized_nodes_to_original:
            unoptimized_s1 = copy.deepcopy(self._optimized_nodes_to_original[s1])
        unoptimized_node = create_op_node(op, unoptimized_s0, unoptimized_s1, op_value_type_hint)

        self._optimized_nodes_to_original[operation_node] = unoptimized_node

        self.add_node(operation_node)
        return operation_node

    def add_logical_not_node(self, node: ExpressionNode) -> ExpressionNode:
        assert node is not None

        optimized_node = None
        if node.type == ExpressionType.OP:
            # double not optimization
            if node.value == ExpressionOperationType.NOT:
                optimized_node = copy.deepcopy(node.left)
            # apply not for compare operators
            if node.value.is_compare_operator():
                optimized_node = copy.deepcopy(node)
                optimized_node.value = ExpressionOperationType.get_inverted_operation(optimized_node.value)
        elif const_zero_node(node):
            optimized_node = self.add_const_node(1, OpenCLTypes.UINT)
        elif const_non_zero_node(node):
            optimized_node = self.add_const_node(0, OpenCLTypes.UINT)

        logical_not_node = create_logical_not_node(node)
        self.add_node(logical_not_node)

        if optimized_node is not None:
            self._optimized_nodes_to_original[optimized_node] = logical_not_node
            return optimized_node

        return logical_not_node

    def add_kernel_argument(self, arg: KernelArgument, offset: int) -> ExpressionNode:
        if arg.hidden:
            for reg_type in CONSTANT_VALUES:
                reg_type_name = CONSTANT_VALUES[reg_type][0]
                if arg.name == reg_type_name:
                    return self.add_register_node(reg_type, arg.name)

            # don't add other hidden data like _.printf_buffer, _.vqueue_pointer, _.aqlwrap_pointer and so on
            return None

        name = arg.name if not arg.is_vector() else arg.get_vector_element_by_offset(offset)
        opencl_type, qualifiers = get_kernel_argument_type_and_qualifiers(arg)
        value_type_hint = ExpressionValueTypeHint(opencl_type, qualifiers, arg.const)

        var_node = self.add_variable_node(name, value_type_hint)

        # For kernel argument node make a copy, because variable node can be changed during decompilation
        arg_name: str = var_node.value
        if arg_name.find(VECTOR_COMPONENT_DELIMITER) != -1:
            arg_name, _ = arg_name.split(VECTOR_COMPONENT_DELIMITER)
            arg_node = copy.deepcopy(self.get_variable_node(arg_name))
        else:
            arg_node = copy.deepcopy(var_node)
        self._arguments_for_programs[self._name_of_program][arg_name] = arg_node

        return var_node

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
            new_node = self.add_work_item_function_node(reg_type)
        else:
            assert value is not None
            new_node = self.add_const_node(value, OpenCLTypes.INT)

        return new_node

    def add_work_item_function_node(self, reg_type: RegisterType) -> ExpressionNode:
        work_item_function_node = create_work_item_function_node(reg_type)

        self.add_node(work_item_function_node)
        return work_item_function_node

    def add_const_node(self, value, opencl_type_hint: OpenCLTypes):
        value, value_type_hint = get_sufficient_type_for_const(value, opencl_type_hint)
        const_node = create_const_node(value, value_type_hint)

        self.add_node(const_node)
        return const_node

    def add_if_ternary_node(self, cond: ExpressionNode, s0: ExpressionNode, s1: ExpressionNode):
        if_ternary_node = create_if_ternary_node(cond, s0, s1)

        unoptimized_cond = cond
        if cond in self._optimized_nodes_to_original:
            unoptimized_cond = copy.deepcopy(self._optimized_nodes_to_original[cond])
        unoptimized_s0 = s0
        if s0 in self._optimized_nodes_to_original:
            unoptimized_s0 = copy.deepcopy(self._optimized_nodes_to_original[s0])
        unoptimized_s1 = s1
        if s1 in self._optimized_nodes_to_original:
            unoptimized_s1 = copy.deepcopy(self._optimized_nodes_to_original[s1])

        self._optimized_nodes_to_original[if_ternary_node] = create_if_ternary_node(
            unoptimized_cond, unoptimized_s0, unoptimized_s1
        )

        self.add_node(if_ternary_node)

        return if_ternary_node

    def add_permute_node(self, s0: ExpressionNode, s1: ExpressionNode) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None

        if s0.value.find(VECTOR_COMPONENT_DELIMITER) != -1 and s1.value.find(VECTOR_COMPONENT_DELIMITER) != -1:
            var0, component0 = s0.value.split(VECTOR_COMPONENT_DELIMITER)
            var1, component1 = s1.value.split(VECTOR_COMPONENT_DELIMITER)
            if var0 == var1 and component0 != "" and component1 != "":
                var_node: ExpressionNode = self.get_variable_node(var0)
                assert var_node is not None
                list_of_components = [int(i) for i in component0] + [int(i) for i in component1]
                if list_of_components[0] == 0:
                    ascending_order = True
                    for k in range(len(list_of_components)):
                        if list_of_components[k] != k:
                            ascending_order = False
                            break
                    if ascending_order and len(list_of_components) == var_node.value_type_hint.number_of_components():
                        return var_node
                new_var_name = f"{var0}{VECTOR_COMPONENT_DELIMITER}{''.join(map(str, list_of_components))}"
                new_var_value_type_hint = var_node.value_type_hint.set_number_of_components(len(list_of_components))
                return self.add_variable_node(new_var_name, new_var_value_type_hint)

        permute_node = create_permute_node(s0, s1)

        self.add_node(permute_node)

        return permute_node

    def add_permute_node_from_list(self, nodes: list[ExpressionNode]) -> ExpressionNode:
        if len(nodes) == 0:
            return None

        permute_node = nodes[0]

        for next_node in nodes[1:]:
            permute_node = self.add_permute_node(permute_node, next_node)

        self.add_node(permute_node)

        return permute_node

    def apply_operation_to_nodes(self, nodes: list[ExpressionNode], op: ExpressionOperationType):
        assert len(nodes) > 0

        if len(nodes) == 1:
            return nodes[0]

        prev_node = nodes[0]
        for cur_node in nodes[1:]:
            prev_node = self.add_operation(prev_node, cur_node, op, OpenCLTypes.UNKNOWN)

        return prev_node

    def kernel_arg_to_string(self, name: str) -> str:
        if len(name) == 0:
            return ""
        if name[0] == "*":
            return self.kernel_arg_to_string(name[1:])
        kernel_node = None
        if (
            self._name_of_program in self._arguments_for_programs
            and name in self._arguments_for_programs[self._name_of_program]
        ):
            kernel_node = self._arguments_for_programs[self._name_of_program][name]
        if kernel_node is None:
            return ""
        return var_expression_to_string(kernel_node)

    def variable_to_string(self, name: str) -> str:
        if len(name) == 0:
            return ""
        if name[0] == "*":
            return self.variable_to_string(name[1:])
        var_info = self.get_variable_info(name)
        if var_info is None:
            return ""
        return var_expression_to_string(var_info.var_node)

    def get_variable_node(self, name: str) -> ExpressionNode | None:
        if len(name) == 0:
            return None
        if name[0] == "*":
            return self.get_variable_node(name[1:])
        var_info = self.get_variable_info(name)
        if var_info is not None:
            return var_info.var_node
        return None

    def cast_node(self, node: ExpressionNode, to_type: OpenCLTypes) -> ExpressionNode:
        if node.type == ExpressionType.VAR:
            self._variables_for_programs[self._name_of_program][node.value].var_node.cast_to(to_type)
        return node.cast_to(to_type)

    def get_common_type(self, s0: ExpressionNode, s1: ExpressionNode) -> ExpressionValueTypeHint:
        assert s0 is not None
        assert s1 is not None
        return ExpressionValueTypeHint.get_common_type(s0.value_type_hint, s1.value_type_hint)

    def update_variable_type(self, var_name: str, value_type_hint: ExpressionValueTypeHint) -> bool:
        existing_var_info = self.get_variable_info(var_name)
        if existing_var_info is not None:
            self._variables_for_programs[self._name_of_program][
                var_name
            ].var_node.value_type_hint.opencl_type = value_type_hint.opencl_type
            return True
        return False

    def add_variable_node(self, name: str, value_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
        assert isinstance(value_type_hint, ExpressionValueTypeHint)
        # Sometimes variable name will be passed in *{var_name} format,
        # which indicates that it is a pointer
        var_name, is_pointer = parse_variable_name(name)
        value_type_hint.is_pointer |= is_pointer

        existing_var_info = self.get_variable_info(var_name)
        if existing_var_info is not None:
            # There are cases when we make VAR from one value,
            # but then it is reassigned to another value with another type
            # For those cases, we need to make all types fit into variable type
            if existing_var_info.var_node.value_type_hint != value_type_hint:
                existing_var_info.var_node.value_type_hint = value_type_hint
            return existing_var_info.var_node

        # "{var}___s{idx}" case, make sure full variable is there too
        if var_name.find(VECTOR_COMPONENT_DELIMITER) != -1:
            base_var_name, var_components = var_name.split(VECTOR_COMPONENT_DELIMITER)
            if var_components != "" and value_type_hint.number_of_components() != len(var_components):
                if self.get_variable_info(base_var_name) is None:
                    self.add_variable_node(base_var_name, value_type_hint)
                value_type_hint = value_type_hint.set_number_of_components(1)

        var_node = create_var_node(var_name, value_type_hint)
        self._variables_for_programs[self._name_of_program][var_name] = ExpressionVariableInfo(var_name, var_node, None)
        self.add_node(var_node)

        return var_node

    def expression_to_string(self, node: ExpressionNode, cast_to: OpenCLTypes = OpenCLTypes.UNKNOWN):
        if isinstance(cast_to, ExpressionValueTypeHint):
            return expression_to_string(node, cast_to)
        return expression_to_string(node, ExpressionValueTypeHint(cast_to))

    def get_variable_info(self, var_name: str) -> ExpressionVariableInfo:
        if (
            self._variables_for_programs.get(self._name_of_program) is not None
            and self._variables_for_programs[self._name_of_program].get(var_name) is not None
        ):
            return self._variables_for_programs[self._name_of_program][var_name]
        return None

    def apply_optimizations(self, node: ExpressionNode) -> ExpressionNode:
        if node is None:
            return None
        if node.type == ExpressionType.OP:
            if node.value == ExpressionOperationType.NOT:
                return self.add_logical_not_node(node.left)
            return self.add_operation(
                self.apply_optimizations(node.left),
                self.apply_optimizations(node.right),
                node.value,
                node.value_type_hint.opencl_type,
            )
        if node.type == ExpressionType.CONST:
            return self.add_const_node(node.value, node.value_type_hint.opencl_type)
        return node

    def replace_node(self, node: ExpressionNode, from_node: ExpressionNode, to_node: ExpressionNode) -> ExpressionNode:
        if node.contents_equal(to_node):
            return node

        # There could be cases when node has already been optimized and doesn't contain from_node
        # That's why we try to use unoptimized node here
        if node in self._optimized_nodes_to_original:
            node = copy.deepcopy(self._optimized_nodes_to_original[node])

        original_node = copy.deepcopy(node)
        node = node.replace(from_node, to_node)
        if not original_node.contents_equal(node):
            return self.apply_optimizations(node)

        # Same logic as for node - if nothing has changed after first replace, probably from_node was optimized
        if from_node in self._optimized_nodes_to_original:
            from_node = copy.deepcopy(self._optimized_nodes_to_original[from_node])

        node = node.replace(from_node, to_node)
        return self.apply_optimizations(node)
