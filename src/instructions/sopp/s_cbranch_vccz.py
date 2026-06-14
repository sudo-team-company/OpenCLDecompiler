from src.expression_manager.expression_manager import ExpressionManager
from src.instructions.sopp.s_cbranch import SCbranch


class SCbranchVccz(SCbranch):
    def to_print(self):
        self.output_string = ExpressionManager().expression_to_string(self.get_expression_node(self.operand[0]))
        return self.output_string
