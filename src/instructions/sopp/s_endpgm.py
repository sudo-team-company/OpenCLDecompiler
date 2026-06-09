from src.base_instruction import BaseInstruction
from src.logical_variable import ExecCondition


class SEndpgm(BaseInstruction):
    def to_fill_node(self):
        self.node.state["$MASK"].exec_condition = ExecCondition.default()
        return self.node
