from src.expression_manager.expression_manager import ExpressionManager
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
    def instruction(self) -> list[str]:
        return self.node.instruction

    @property
    def name(self) -> str:
        return self.instruction[0]

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
