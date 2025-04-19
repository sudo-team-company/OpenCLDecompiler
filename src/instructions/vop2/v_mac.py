from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes


class VMac(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "f32":
            self.decompiler_data.write(
                f"{self.vdst} = (float){self.src0} * (float){self.src1} + (float){self.vdst} // {self.name}\n"
            )
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "f32":
            new_value = make_op(self.node, self.src0, self.src1, "*", "(float)", "(float)", suffix=self.suffix)
            new_value = make_op(self.node, new_value, self.vdst, "+", "", "(float)", suffix=self.suffix)

            src0_node = self.node.get_expression_node(self.src0)
            src1_node = self.node.get_expression_node(self.src1)
            vdst_node = self.node.get_expression_node(self.vdst)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MUL, OpenCLTypes.FLOAT)
            expr_node = self.expression_manager.add_operation(
                expr_node, vdst_node, ExpressionOperationType.PLUS, OpenCLTypes.FLOAT)
            return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix, expression_node=expr_node)
        return super().to_fill_node()
