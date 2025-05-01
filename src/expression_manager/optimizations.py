#todo also move here simplifactions for different operations?? like + and so on, so we can remove all if checks
import itertools
from dataclasses import dataclass

from src.expression_manager.expression_node import ExpressionNode, ExpressionOperationType, ExpressionType
from src.register_type import RegisterType


def const_one_node(node: ExpressionNode) -> bool:
    if node.type != ExpressionType.CONST:
        return False
    val = node.value
    if isinstance(val, str):
        val = int(val, base=16)
    return val == 1

def const_zero_node(node: ExpressionNode) -> bool:
    if node.type != ExpressionType.CONST:
        return False
    val = node.value
    if isinstance(val, str):
        val = int(val, base=16)
    return val == 0

def const_negative_node(node: ExpressionNode) -> bool:
    if node.type != ExpressionType.CONST:
        return False
    if not node.value_type_hint.is_signed():
        return False
    val = node.value
    if isinstance(val, str):
        val = int(val, base=16)
    return val < 0

def get_all_nodes_with_operations(node: ExpressionNode) -> list[ExpressionNode]:
    if node.type == ExpressionType.OP and node.value == ExpressionOperationType.PLUS:
        return get_all_nodes_with_operations(node.left) + get_all_nodes_with_operations(node.right)
    return [(node, node.parent.value)]

@dataclass
class NodeParseInfo:
    node: ExpressionNode
    reg_type: RegisterType
    operation: ExpressionOperationType

def parse_node_sum(node: ExpressionNode, op_plus: bool = True) -> list[NodeParseInfo]:  # noqa: FBT001, FBT002
    if node is None:
        return []
    if node.type == ExpressionType.OP:
        if node.value == ExpressionOperationType.PLUS:
            return parse_node_sum(node.left, op_plus) + parse_node_sum(node.right, op_plus)
        if node.value == ExpressionOperationType.MINUS:
            return parse_node_sum(node.left, op_plus) + parse_node_sum(node.right, not op_plus)
        if (
            node.value == ExpressionOperationType.MUL
            and node.left.type == ExpressionType.WORK_ITEM_FUNCTION
            and node.right.type == ExpressionType.WORK_ITEM_FUNCTION
        ) and ((
                node.left.value in [RegisterType[f"WORK_GROUP_ID_{dim}"] for dim in "XYZ"]
                and node.right.value in [RegisterType[f"LOCAL_SIZE_{dim}"] for dim in "XYZ"]
            ) or
            (
                node.right.value in [RegisterType[f"WORK_GROUP_ID_{dim}"] for dim in "XYZ"]
                and node.left.value in [RegisterType[f"LOCAL_SIZE_{dim}"] for dim in "XYZ"]
            )
            ):
            left_dim = node.left.value.name[-1]
            right_dim = node.right.value.name[-1]
            if left_dim == right_dim:

                return [NodeParseInfo(
                    node,
                    RegisterType[f"WORK_GROUP_ID_{left_dim}_LOCAL_SIZE"],
                    ExpressionOperationType.PLUS if op_plus else ExpressionOperationType.MINUS
                )]

    return [NodeParseInfo(
        node,
        node.value if node.type == ExpressionType.WORK_ITEM_FUNCTION else RegisterType.UNKNOWN,
        ExpressionOperationType.PLUS if op_plus else ExpressionOperationType.MINUS
    )]


def num_groups_node_plus_work_group_id_local_size_node(
        left: ExpressionNode, right: ExpressionNode) -> RegisterType:
    if ExpressionType.WORK_ITEM_FUNCTION not in (left.type, right.type):
        return RegisterType.UNKNOWN

    if left.value not in [RegisterType[f"NUM_GROUPS_{dim}"] for dim in "XYZ"]:
        if right.value in [RegisterType[f"NUM_GROUPS_{dim}"] for dim in "XYZ"]:
            tmp = left
            left = right
            right = tmp
        else:
            return RegisterType.UNKNOWN
    dim = left.value.name[-1]
    if right.type == ExpressionType.OP and right.value == ExpressionOperationType.MUL:
        mul_node = right
        if (mul_node.left.type != ExpressionType.WORK_ITEM_FUNCTION
            or mul_node.right.type != ExpressionType.WORK_ITEM_FUNCTION):
            return RegisterType.UNKNOWN
        possible_permutation = list(itertools.permutations(
            [RegisterType[f"WORK_GROUP_ID_{dim}"], RegisterType[f"LOCAL_SIZE_{dim}"]]))
        if [mul_node.left.value, mul_node.right.value] in possible_permutation:
            return RegisterType[f"GLOBAL_ID_{dim}"]
    return RegisterType.UNKNOWN

def global_offset_node_plus_work_group_id_local_size_node(
        left: ExpressionNode, right: ExpressionNode) -> RegisterType:
    if ExpressionType.WORK_ITEM_FUNCTION not in (left.type, right.type):
        return RegisterType.UNKNOWN

    if left.value not in [RegisterType[f"GLOBAL_OFFSET_{dim}"] for dim in "XYZ"]:
        if right.value in [RegisterType[f"GLOBAL_OFFSET_{dim}"] for dim in "XYZ"]:
            tmp = left
            left = right
            right = tmp
        else:
            return RegisterType.UNKNOWN
    dim = left.value.name[-1]
    if right.type == ExpressionType.OP and right.value == ExpressionOperationType.MUL:
        mul_node = right
        if (mul_node.left.type != ExpressionType.WORK_ITEM_FUNCTION
            or mul_node.right.type != ExpressionType.WORK_ITEM_FUNCTION):
            return RegisterType.UNKNOWN
        possible_permutation = list(itertools.permutations(
            [RegisterType[f"WORK_GROUP_ID_{dim}"], RegisterType[f"WORK_ITEM_ID_{dim}"]]))
        if [mul_node.left.value, mul_node.right.value] in possible_permutation:
            return RegisterType[f"GLOBAL_ID_{dim}"]
    return RegisterType.UNKNOWN

def group_id_node_mul_size_of_work_groups(
        left: ExpressionNode, right: ExpressionNode, size_of_work_groups: list[int]) -> RegisterType:
    if (left.type not in [ExpressionType.WORK_ITEM_FUNCTION, ExpressionType.CONST]
        or right.type not in [ExpressionType.WORK_ITEM_FUNCTION, ExpressionType.CONST]):
        return RegisterType.UNKNOWN

    if left.value not in [RegisterType[f"WORK_GROUP_ID_{dim}"] for dim in "XYZ"]:
        if right.value in [RegisterType[f"WORK_GROUP_ID_{dim}"] for dim in "XYZ"]:
            tmp = left
            left = right
            right = tmp
        else:
            return RegisterType.UNKNOWN
    dim = left.value.name[-1]
    i = "XYZ".index(dim)
    if right.type == ExpressionType.CONST and right.value == size_of_work_groups[i]:
        return RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"]
    return RegisterType.UNKNOWN

def local_id_plus_work_group_id_local_size_offset(
        left: ExpressionNode, right: ExpressionNode, size_of_work_groups: list[int]) -> RegisterType:
    if ExpressionType.WORK_ITEM_FUNCTION not in (left.type, right.type):
        return RegisterType.UNKNOWN

    if left.value not in [RegisterType[f"WORK_ITEM_ID_{dim}"] for dim in "XYZ"]:
        if right.value in [RegisterType[f"WORK_ITEM_ID_{dim}"] for dim in "XYZ"]:
            tmp = left
            left = right
            right = tmp
        else:
            return RegisterType.UNKNOWN
    dim = left.value.name[-1]
    i = "XYZ".index(dim)
    if right.type == ExpressionType.CONST and right.value == size_of_work_groups[i]:
        return RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"]
    return RegisterType.UNKNOWN


_SUM_SIMPLIFY_COMBINATIONS = [
    *[
        (
            frozenset(
                {
                    RegisterType[f"GLOBAL_OFFSET_{dim}"],
                    RegisterType[f"WORK_ITEM_ID_{dim}"],
                    RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"],
                }
            ),
            (
                RegisterType[f"GLOBAL_ID_{dim}"]
            ),
        )
        for dim in "XYZ"
    ],
    *[
        (
            frozenset(
                {
                    RegisterType[f"WORK_ITEM_ID_{dim}"],
                    RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"],
                }
            ),
            (
                RegisterType[f"GLOBAL_ID_{dim}"]
            ),
        )
        for dim in "XYZ"
    ],
]
