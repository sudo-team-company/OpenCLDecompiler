from src.base_instruction import BaseInstruction
from src.operation_status import OperationStatus
from src.decompiler_data import DecompilerData


class SCbranch(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        if flag_of_status == OperationStatus.to_print_unresolved:
            return self.to_print_unresolved(node, instruction)
        elif flag_of_status == OperationStatus.to_fill_node:
            return DecompilerData().to_fill_node(node, instruction)
        else:
            return self.to_print(node)

    def to_print_unresolved(self, node, instruction):
        raise NotImplementedError()

    def to_print(self, node):
        raise NotImplementedError()
