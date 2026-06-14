from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import Val


class VMac(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]
        self.src2 = self.operand[3]

    def to_fill_node(self):
        if self.suffix == "f32":
            new_value = make_op(self.node, self.src0, self.src1, "*", "(float)", "(float)", suffix=self.suffix)
            new_value = make_op(self.node, Val(new_value), self.src2, "+", "", "(float)", suffix=self.suffix)

            src0_node = self.get_expression_node(self.src0)
            src1_node = self.get_expression_node(self.src1)
            src2_node = self.get_expression_node(self.src2)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MUL, OpenCLTypes.FLOAT
            )
            expr_node = self.expression_manager.add_operation(
                expr_node, src2_node, ExpressionOperationType.PLUS, OpenCLTypes.FLOAT
            )
            return set_reg_value(
                self.node,
                new_value,
                self.vdst.name,
                [self.src0.name, self.src1.name, self.src2.name],
                self.suffix,
                expression_node=expr_node,
            )
        return super().to_fill_node()
