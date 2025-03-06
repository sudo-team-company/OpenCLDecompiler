from enum import Enum, auto

from src.types.opencl_types import *

class ExpressionEvaluationException(Exception):
    pass

class ExpressionType(Enum):
    UNKNOWN = auto()
    OP = auto()
    CONST = auto()
    VAR = auto()
    FUNC = auto()

class ExpressionOperationType(Enum):
    UNKNOWN = auto()

    PLUS = auto() # +
    MINUS = auto() # -
    MUL = auto() # *
    DIV = auto() # /
    REM = auto() # %

    EQ = auto() # ==
    NE = auto() # !=
    LT = auto() # <
    LE = auto() # <=
    GT = auto() # >
    GE = auto() # >=

    # other logical operator, see https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html

class ExpressionNode:
    def __init__(self, expression_type=ExpressionType.UNKNOWN, value=None, value_type_hint=OpenCLTypes.UNKNOWN):
        self.left = None
        self.right = None
        self.type = expression_type

        self.value = value
        self.value_type_hint = value_type_hint

    def isLeaf(self):
        return self.left == None and self.right == None
    
def evaluateOperationExpression(expressionNode: ExpressionNode) -> tuple[object, OpenCLType]:
    # do we need it for every case?
    assert(expressionNode.left != None and expressionNode.right != None)
    match expressionNode.value:
        case ExpressionOperationType.PLUS:
            return (evaluateExpression(expressionNode.left)[0] + evaluateExpression(expressionNode.right)[0], OpenCLTypes.UNKNOWN)
        # case ExpressionOperationType.MINUS:
        #     return evaluateExpression(expressionNode.left) - evaluateExpression(expressionNode.right)
        # case ExpressionOperationType.DIV:
        #     return evaluateExpression(expressionNode.left) / evaluateExpression(expressionNode.right)
        # case ExpressionOperationType.MUL:
        #     return evaluateExpression(expressionNode.left) * evaluateExpression(expressionNode.right)
        # case ExpressionOperationType.REM:
        #     return evaluateExpression(expressionNode.left) % evaluateExpression(expressionNode.right)
        case _:
            raise ExpressionEvaluationException


expression_trees = {} # var_name -> expression_tree_root_node

def evaluateExpression(expressionNode: ExpressionNode) -> tuple[object, OpenCLType]:
    match expressionNode.type:
        case ExpressionType.OP:
            return evaluateOperationExpression(expressionNode)
        case ExpressionType.CONST:
            return (expressionNode.value, expressionNode.value_type_hint)
        case ExpressionType.VAR:
            # tree[get variable tree] => evaluate its tree
            return evaluateExpression(expression_trees[str(expressionNode.value)])
        # case ExpressionType.FUNC:
        #     # lut? => evaluate?
        #     raise ExpressionEvaluationException
        case _:
            raise ExpressionEvaluationException
    
def getOperationNode(op: ExpressionOperationType):
    return ExpressionNode(ExpressionType.OP, op)

def getConstNode(value, value_type_hint : OpenCLType = OpenCLTypes.UNKNOWN):
    return ExpressionNode(ExpressionType.CONST, value, value_type_hint)

def getFunctionNode(name, return_type : OpenCLType = OpenCLTypes.UNKNOWN):
    return ExpressionNode(ExpressionType.FUNC, name, return_type)


plus_node = getOperationNode(ExpressionOperationType.PLUS)
expression_trees["a"] = plus_node

plus_node.left = getConstNode(2, OpenCLTypes.UINT)
another_plus_node = getOperationNode(ExpressionOperationType.PLUS)
plus_node.right = another_plus_node

another_plus_node.left = getConstNode(120, OpenCLTypes.UINT)
another_plus_node.right = getConstNode(2, OpenCLTypes.UINT)


plus_node_b = getOperationNode(ExpressionOperationType.PLUS)
plus_node_b.left = ExpressionNode(ExpressionType.VAR, "a")
plus_node_b.right = getConstNode(3, OpenCLTypes.UINT)

print(evaluateExpression(plus_node_b)[0])