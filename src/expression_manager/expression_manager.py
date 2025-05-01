import copy
from src.expression_manager.expression_node import (
    ExpressionNode,
    ExpressionOperationType,
    ExpressionType,
    ExpressionValueTypeHint,
    TypeAddressSpaceQualifiers,
    get_common_type,
)
from src.expression_manager.helper_functions import (
    VariableInfo,
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
)
from src.expression_manager.optimizations import (
    NodeParseInfo,
    const_negative_node,
    const_one_node,
    const_zero_node,
    group_id_node_mul_size_of_work_groups,
    parse_node_sum,
)
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.model.kernel_argument import KernelArgument
from src.register_type import CONSTANT_VALUES, RegisterType
from src.utils.singleton import Singleton


class ExpressionManager(metaclass=Singleton):
    def __init__(self):
        self._nodes = []
        self._variables_for_programs: dict[str, dict[str, VariableInfo]] = {}
        self._name_of_program = ""
        self._size_of_workgroups = []

    def set_name_of_program(self, name_of_program: str):
        self._name_of_program = name_of_program

    def set_size_of_workgroups(self, new_size_of_workgroups: list[int]):
        self._size_of_workgroups = new_size_of_workgroups

    def reset(self, name_of_program: str):
        self._nodes = []
        self._name_of_program = name_of_program
        self._variables_for_programs = {}
        self._size_of_workgroups = []

    def add_node(self, node: ExpressionNode):
        assert node is not None
        assert node.value_type_hint.opencl_type != OpenCLTypes.UNKNOWN
        self._nodes.append(node)

    def add_offset_div_data_size(
            self,
            s0: ExpressionNode,
            s1: ExpressionNode,
            data_size: int,
            opencl_type_hint: OpenCLTypes) -> ExpressionNode:
        data_size_node = self.add_const_node(data_size, OpenCLTypes.UINT)
        div_node = self.add_operation(s1, data_size_node, ExpressionOperationType.DIV, opencl_type_hint)
        return self.add_operation(s0, div_node, ExpressionOperationType.PLUS, opencl_type_hint)

    def _parse_and_optimize_node_sum(
            self,
            left: ExpressionNode,
            right: ExpressionNode,
            value_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
        nodes_info: list[NodeParseInfo] = parse_node_sum(left) + parse_node_sum(right)

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

            # Change expressions like global_offset({i}) + get_group_id({i}) * get_local_size({i}) + get_local_id({i}) + ...
            # to get_global_id({i}) + ...
            local_id_reg_types = [RegisterType[f"WORK_ITEM_ID_{dim}"] for dim in "XYZ"]
            global_offset_reg_types = [RegisterType[f"GLOBAL_OFFSET_{dim}"] for dim in "XYZ"]
            work_group_id_mul_local_size_reg_types = [RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"] for dim in "XYZ"]
            num_groups_reg_types = [RegisterType[f"NUM_GROUPS_{dim}"] for dim in "XYZ"]

            mul_nodes_info = [n for n in result if (n.node.type == ExpressionType.OP
                                                            and n.node.value == ExpressionOperationType.MUL)]

            for i, dim, local_id_dim, global_offset_dim, work_group_id_dim_mul in zip(
                [0, 1, 2],
                "XYZ",
                local_id_reg_types,
                global_offset_reg_types,
                work_group_id_mul_local_size_reg_types,
                strict=False
            ):
                l_array = [n for n in result if (n.reg_type == local_id_dim 
                                                              and n.operation == ExpressionOperationType.PLUS)]
                g_array = [n for n in result if (n.reg_type == global_offset_dim
                                                              and n.operation == ExpressionOperationType.PLUS)]
                w_array = [n for n in result if (n.reg_type == work_group_id_dim_mul
                                                              and n.operation == ExpressionOperationType.PLUS)]

                while (
                    len(l_array) > 0 and
                    len(g_array) > 0 and
                    len(w_array) > 0
                ):
                    result.remove(l_array[0])
                    result.remove(g_array[0])
                    result.remove(w_array[0])
                    l_array.remove(l_array[0])
                    g_array.remove(g_array[0])
                    w_array.remove(w_array[0])
                    result.append(NodeParseInfo(
                        self.add_register_node(RegisterType[f"GLOBAL_ID_{dim}"], ""),
                        RegisterType[f"GLOBAL_ID_{dim}"],
                        ExpressionOperationType.PLUS))

                # Change expressions like get_num_groups({i}) * get_local_size({i}) + get_group_id({i}) * get_local_size({i}) + ...
                # to get_global_size({i}) + ...
                num_groups_mul_size_of_wg_nodes = [n for n in mul_nodes_info if (
                    n.operation == ExpressionOperationType.PLUS and
                    ((n.node.left.type == ExpressionType.WORK_ITEM_FUNCTION
                    and n.node.left.value == num_groups_reg_types[i]
                    and n.node.right.type == ExpressionType.CONST
                    and n.node.right.value == self._size_of_workgroups[i]) or
                    (n.node.right.type == ExpressionType.WORK_ITEM_FUNCTION
                    and n.node.right.value == num_groups_reg_types[i]
                    and n.node.left.type == ExpressionType.CONST
                    and n.node.left.value == self._size_of_workgroups[i]
                )))]

                while len(w_array) > 0 and len(num_groups_mul_size_of_wg_nodes) > 0:
                    result.remove(num_groups_mul_size_of_wg_nodes[0])
                    result.remove(w_array[0])
                    w_array.remove(w_array[0])
                    num_groups_mul_size_of_wg_nodes.remove(num_groups_mul_size_of_wg_nodes[0])
                    result.append(NodeParseInfo(
                        self.add_register_node(RegisterType[f"GLOBAL_SIZE_{dim}"]),
                        RegisterType[f"GLOBAL_SIZE_{dim}"],
                        ExpressionOperationType.PLUS))

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
                result.insert(0, NodeParseInfo(
                    self.add_const_node(0, OpenCLTypes.INT),
                    RegisterType.UNKNOWN,
                    ExpressionOperationType.PLUS
                ))

        cur_node = result[0].node
        if len(result) == 1:
            return cur_node

        for next_node_info in result[1:]:
            if const_zero_node(next_node_info.node):
                continue
            cur_node = create_op_node(next_node_info.operation, cur_node, next_node_info.node, value_type_hint)
        return cur_node


    def _optimized_nodes_sum(self,
                             s0: ExpressionNode,
                             s1: ExpressionNode,
                             value_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None

        if const_zero_node(s0):
            return s1
        if const_zero_node(s1):
            return s0
        if const_negative_node(s0) and not const_negative_node(s1):
            return self._optimized_nodes_sum(s1, s0, value_type_hint)
        if const_negative_node(s1):
            s1.value = abs(s1.value)
            return self._optimized_nodes_sub(s0, s1, value_type_hint)

        plus_node = self._parse_and_optimize_node_sum(s0, s1, value_type_hint)
        if plus_node is None:
            plus_node = create_op_node(ExpressionOperationType.PLUS, s0, s1, value_type_hint)
        return plus_node

    def _optimized_nodes_sub(self,
                             s0: ExpressionNode,
                             s1: ExpressionNode,
                             value_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None

        # "0 - (x - y)" case
        if const_zero_node(s0) and s1.type == ExpressionType.OP:
            if s1.value == ExpressionOperationType.MINUS:
                return self._optimized_nodes_sum(s1.right, s1.left, value_type_hint)
            if s1.value in [ExpressionOperationType.MUL, ExpressionOperationType.DIV]:
                return self._optimized_nodes_mul(
                    self.add_const_node(-1, OpenCLTypes.INT),
                    s1,
                    value_type_hint)
        if const_zero_node(s1):
            return s0
        if const_negative_node(s1):
            s1.value = abs(s1.value)
            return self._optimized_nodes_sum(s0, s1, value_type_hint)
        if s0 == s1:
            return self.add_const_node(0, OpenCLTypes.UINT)

        return create_op_node(ExpressionOperationType.MINUS, s0, s1, value_type_hint)

    def _optimized_nodes_mul(self,
                             s0: ExpressionNode,
                             s1: ExpressionNode,
                             value_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
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

    def _optimized_nodes_div(self,
                             s0: ExpressionNode,
                             s1: ExpressionNode,
                             value_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None

        assert not const_zero_node(s1)

        if const_one_node(s1):
            return s0

        # special case for offsets like this one - (get_global_id(0) * 4) / 4
        if (s1.type == ExpressionType.CONST
            and s0.type == ExpressionType.OP
            and s0.value == ExpressionOperationType.MUL
            and s0.right.type == ExpressionType.CONST):
            if self.expression_to_string(s0) == "var3 * 4":
                pass
            print("div before:", self.expression_to_string(s0), "/", self.expression_to_string(s1))
            simplified_type = ExpressionValueTypeHint.get_common_type(s0.right.value_type_hint, s1.value_type_hint)
            new_const_value = evaluate_operation(s0.right.value, ExpressionOperationType.DIV, s1.value, simplified_type)
            if new_const_value == 1:
                res_node = copy.deepcopy(s0.left)
                print("div after:", self.expression_to_string(res_node))
            else:
                res_node = copy.deepcopy(s0)
                res_node.right = self.add_const_node(new_const_value, simplified_type.opencl_type)
                print("div after:", self.expression_to_string(res_node))
            return res_node

        return create_op_node(ExpressionOperationType.DIV, s0, s1, value_type_hint)

    def _optimized_nodes_logical_operation(self,
                             op: ExpressionOperationType,
                             s0: ExpressionNode,
                             s1: ExpressionNode,
                             value_type_hint: ExpressionValueTypeHint) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None
        assert op.is_logical_operator()

        if op == ExpressionOperationType.XOR:
            if s0.type == ExpressionType.UNKNOWN:
                return self.logical_not_node(s1)
            if s1.type == ExpressionType.UNKNOWN:
                return self.logical_not_node(s0)

        if ExpressionType.CONST in (s0.type, s1.type):
            const_node = s0 if s0.type == ExpressionType.CONST else s1
            const_value = 1 if const_node.value else 0
            if op == ExpressionOperationType.OR and const_value:
                return create_const_node(1, value_type_hint)
            if op == ExpressionOperationType.AND and not const_value:
                return create_const_node(0, value_type_hint)

        return create_op_node(op, s0, s1, value_type_hint)

    def add_operation(
        self, s0: ExpressionNode, s1: ExpressionNode, op: ExpressionOperationType, opencl_type_hint: OpenCLTypes
    ):
        assert s0 is not None
        assert s1 is not None

        #todo only use opencl_type_hint to limit ExpressionValueTypeHint.opencl_type
        # if opencl_type_hint == OpenCLTypes.UNKNOWN:
            # assert(False)
            # value_type_hint = get_common_type(s0.value_type_hint, s1.value_type_hint)

        # todo check
        if ((s0.type == ExpressionType.VAR and s0.value_type_hint.is_pointer)
            or (s0.type == ExpressionType.VAR and s0.value_type_hint.qualifier == TypeAddressSpaceQualifiers.GLOBAL)):
            # todo limit
            op_value_type_hint = s0.value_type_hint
        elif ((s1.type == ExpressionType.VAR and s1.value_type_hint.is_pointer)
              or (s1.type == ExpressionType.VAR and s1.value_type_hint.qualifier == TypeAddressSpaceQualifiers.GLOBAL)):
            # todo limit
            op_value_type_hint = s1.value_type_hint
        elif s0.value_type_hint == s1.value_type_hint:
            #todo check that type fits into value_type_hint
            op_value_type_hint = s0.value_type_hint
        else:
            nodes_common_type = ExpressionValueTypeHint.get_common_type(s0.value_type_hint, s1.value_type_hint)
            op_value_type_hint = nodes_common_type
            # #todo remove test
            # if check_value_needs_cast("test", nodes_common_type, value_type_hint):
            #     op_value_type_hint = get_common_type(value_type_hint, nodes_common_type)
            # else:
            #     op_value_type_hint = nodes_common_type

        # if both values are constant, we can evaluate expression
        if s0.type == ExpressionType.CONST and s1.type == ExpressionType.CONST:
            simplified_type = ExpressionValueTypeHint.get_common_type(s0.value_type_hint, s1.value_type_hint)
            result = evaluate_operation(s0.value, op, s1.value, simplified_type)
            assert result is not None
            return self.add_const_node(result, simplified_type.opencl_type)

        if op == ExpressionOperationType.PLUS:
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

        self.add_node(operation_node)
        return operation_node

    def logical_not_node(self, node: ExpressionNode) -> ExpressionNode:
        assert node is not None

        # double not optimization
        if node.type == ExpressionType.OP and node.value == ExpressionOperationType.NOT:
            return node.left

        logical_not_node = create_logical_not_node(node)

        self.add_node(logical_not_node)
        return logical_not_node

    def add_kernel_argument(self, arg: KernelArgument, offset: int, check_duplicate: bool = True) -> ExpressionNode:  # noqa: FBT001, FBT002
        if arg.hidden:
            for reg_type in CONSTANT_VALUES:
                reg_type_name = CONSTANT_VALUES[reg_type][0]
                if arg.name == reg_type_name:
                    return self.add_register_node(reg_type, arg.name)

            # don't add other hidden data like _.printf_buffer, _.vqueue_pointer, _.aqlwrap_pointer and so on
            return None

        name = arg.name if not arg.is_vector() else arg.get_vector_element_by_offset(offset)
        value_type_hint, qualifiers = get_kernel_argument_type_and_qualifiers(arg)
        return self.add_variable_node(name, ExpressionValueTypeHint(value_type_hint, qualifiers, arg.const), check_duplicate)

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

        self.add_node(if_ternary_node)

        return if_ternary_node

    def add_permute_node(self, s0: ExpressionNode, s1: ExpressionNode) -> ExpressionNode:
        assert s0 is not None
        assert s1 is not None
        assert s0.type == ExpressionType.VAR
        assert s1.type == ExpressionType.VAR

        permute_node = create_permute_node(s0, s1)

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

    def get_variable_node(self, name: str) -> ExpressionNode | None:
        var_info = self.get_variable_info(name)
        if var_info is not None:
            return var_info.var_node
        return None

    def cast_node(self, node: ExpressionNode, to_type: OpenCLTypes) -> ExpressionNode:
        #todo fix that
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
            self._variables_for_programs[self._name_of_program][var_name].var_node.value_type_hint.opencl_type = value_type_hint.opencl_type
            return True
        return False

    def add_variable_node(
        self,
        name: str,
        value_type_hint: ExpressionValueTypeHint,
        check_duplicate: bool = True,  # noqa: FBT001, FBT002
    ) -> ExpressionNode:
        assert(isinstance(value_type_hint, ExpressionValueTypeHint))
        var_name, is_pointer = parse_variable_name(name)
        #todo fix that - make sure var_name doesnt start with *, always pass is_pointer through ExpressionValueTypeHint
        value_type_hint.is_pointer |= is_pointer
        print(var_name)
        if var_name in {"var0", "gdata0"}:
            pass

        existing_var_info = self.get_variable_info(var_name)
        if check_duplicate and existing_var_info is not None:
            # There are cases when we make VAR from one value,
            # but then it is reassigned to another value with another type
            # For those cases, we need to make all types fit into variable type
            if existing_var_info.var_node.value_type_hint != value_type_hint:
                existing_var_info.var_node.value_type_hint = ExpressionValueTypeHint.get_common_type(
                    existing_var_info.var_node.value_type_hint,
                    value_type_hint)
            return existing_var_info.var_node

        # "{var}___s{idx}" case, make sure full variable is there too
        vector_element_symbol_pos = var_name.find("___")
        is_vector_element = vector_element_symbol_pos != -1
        if is_vector_element and value_type_hint.number_of_components() > 1:
            base_var_name = name[:vector_element_symbol_pos]
            if check_duplicate and self.get_variable_info(base_var_name) is None:
                self.add_variable_node(base_var_name, value_type_hint, check_duplicate)
            value_type_hint = value_type_hint.set_number_of_components(1)

        var_node = create_var_node(var_name, value_type_hint)

        if self._variables_for_programs.get(self._name_of_program) is None:
            self._variables_for_programs[self._name_of_program] = {}

        self._variables_for_programs[self._name_of_program][var_name] = VariableInfo(var_name, var_node, None)

        self.add_node(var_node)

        return var_node

    def expression_to_string(self, node: ExpressionNode, cast_to: OpenCLTypes = OpenCLTypes.UNKNOWN):
        return expression_to_string(node, ExpressionValueTypeHint(cast_to))

    def get_variable_info(self, var_name: str) -> VariableInfo:
        if (self._variables_for_programs.get(self._name_of_program) is not None
            and self._variables_for_programs[self._name_of_program].get(var_name) is not None):
                return self._variables_for_programs[self._name_of_program][var_name]
        return None
