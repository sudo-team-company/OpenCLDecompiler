from enum import Enum

class ExpressionType(Enum):
    UNKNOWN = 0
    U32 = 1
    # TODO: add all...


class ExpressionNodeType(Enum):
    UNKNOWN = 0
    CONST = 1
    FUNC = 2
    TREE = 3

class ExpressionNode:
    def __init__(self):
        self.left = ExpressionNode()
        self.right = ExpressionNode()
        self.type = ExpressionNodeType.UNKNOWN
        self.expression_hint = ExpressionType.UNKNOWN

    def isLeaf(self):
        return self.left == None and self.right == None