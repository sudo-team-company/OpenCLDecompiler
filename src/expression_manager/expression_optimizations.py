from dataclasses import dataclass

from src.expression_manager.expression_node import (
    ExpressionNode,
    ExpressionOperationType,
    ExpressionType,
)
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

@dataclass
class NodeSumInfo:
    node: ExpressionNode
    reg_type: RegisterType
    operation: ExpressionOperationType

def node_to_list_of_sum_of_nodes(node: ExpressionNode, op_plus: bool = True) -> list[NodeSumInfo]:  # noqa: FBT001, FBT002
    if node is None:
        return []
    if node.type == ExpressionType.OP:
        if node.value == ExpressionOperationType.PLUS:
            return node_to_list_of_sum_of_nodes(node.left, op_plus) + node_to_list_of_sum_of_nodes(node.right, op_plus)
        if node.value == ExpressionOperationType.MINUS:
            return node_to_list_of_sum_of_nodes(node.left, op_plus) + node_to_list_of_sum_of_nodes(node.right, not op_plus)
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

                return [NodeSumInfo(
                    node,
                    RegisterType[f"WORK_GROUP_ID_{left_dim}_LOCAL_SIZE"],
                    ExpressionOperationType.PLUS if op_plus else ExpressionOperationType.MINUS
                )]

    return [NodeSumInfo(
        node,
        node.value if node.type == ExpressionType.WORK_ITEM_FUNCTION else RegisterType.UNKNOWN,
        ExpressionOperationType.PLUS if op_plus else ExpressionOperationType.MINUS
    )]

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