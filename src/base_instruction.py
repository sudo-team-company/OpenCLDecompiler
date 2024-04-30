from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class BaseInstruction:
    def __init__(self, node, suffix):
        self.node = node
        self.instruction = node.instruction
        self.suffix = suffix
        self.output_string = ""
        self.decompiler_data = DecompilerData()

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
