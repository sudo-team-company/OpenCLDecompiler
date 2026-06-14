from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import RegOrVal_ty

from .decompiler_data import DecompilerData
from .node import Node
from .operation_status import OperationStatus


class BaseInstruction:
    def __init__(self, node: Node, suffix: str):
        self.node: Node = node
        self.suffix: str = suffix
        self.output_string: str = ""
        self.decompiler_data = DecompilerData()
        self.expression_manager = ExpressionManager()

    @property
    def operand(self) -> list[RegOrVal_ty]:
        return self.node.operands

    @property
    def name(self) -> str:
        return self.node.instruction

    def execute(self, flag_of_status):
        if flag_of_status == OperationStatus.TO_PRINT_UNRESOLVED:
            return self.to_print_unresolved()
        if flag_of_status == OperationStatus.TO_FILL_NODE:
            return self.to_fill_node()
        if flag_of_status == OperationStatus.TO_PRINT:
            return self.to_print()
        return None

    def to_print_unresolved(self):
        pass

    def to_fill_node(self):
        pass

    def to_print(self):
        return self.output_string

    def get_expression_node(self, reg):
        return self.node.get_or_add_expression_node(reg, OpenCLTypes.from_string(self.suffix))
