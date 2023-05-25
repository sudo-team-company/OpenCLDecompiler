from src.base_instruction import BaseInstruction
from src.logical_variable import ExecCondition


class SEndpgm(BaseInstruction):
    def to_fill_node(self):
        self.node.state.registers["exec"].exec_condition = ExecCondition.default()
        return self.node

    def to_print_unresolved(self):
        return ""
