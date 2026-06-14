from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_manager import ExpressionManager
from src.ir.registers.reg import PredReg
from src.logical_variable import ExecCondition


class UseMask(BaseInstruction):
    def to_fill_node(self):
        src = self.node.operands[0]
        exec_condition = self.decompiler_data.exec_registers[src.name]

        prev_exec_cond_node = self.get_expression_node(src)

        set_reg_value(
            self.node,
            exec_condition.top(),
            "$MASK",
            [src.name],
            None,
            expression_node=prev_exec_cond_node,
            exec_condition=exec_condition,
        )

        return self.node

    def to_print(self):
        self.output_string = ExpressionManager().expression_to_string(self.get_expression_node(PredReg("$MASK")))
        return self.output_string


class Unmask(BaseInstruction):
    def to_fill_node(self):
        self.node.state["$MASK"].exec_condition = ExecCondition.default()
        return self.node
