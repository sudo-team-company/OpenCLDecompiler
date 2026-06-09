from src.base_instruction import BaseInstruction
from src.logical_variable import ExecCondition


class InitPred(BaseInstruction):
    def to_fill_node(self):
        dest = self.node.operands[0]
        self.decompiler_data.init_predicate(self.node.state, dest.name)
        self.decompiler_data.init_predicate(self.node.state, dest.get_element(0).name)
        self.decompiler_data.init_predicate(self.node.state, dest.get_element(1).name)
        self.decompiler_data.exec_registers[dest.name] = ExecCondition.default()

        return self.node
