from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register_type import RegisterType


class VMulF32(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]

    def to_fill_node(self):
        src0_node = self.get_expression_node(self.src0)
        src1_node = self.get_expression_node(self.src1)
        if self.suffix == "f32":
            if (
                self.src1.name in self.node.state
                and self.node.get_from_state(self.src1).type == RegisterType.DIVISION_RECIPROCAL
                and self.src0 == "0x4f7ffffe"
            ):
                new_value = self.node.get_from_state(self.src1).val
                expr_node = src1_node
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst.name,
                    [self.src0.name, self.src1.name],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT2,
                    expression_node=expr_node,
                )
            reg_entire = self.node.get_from_state(self.src1).integrity
            new_value = make_op(self.node, self.src0, self.src1, "*", "(float)", "(float)", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MUL, OpenCLTypes.FLOAT
            )
            return set_reg_value(
                self.node,
                new_value,
                self.vdst.name,
                [self.src0.name, self.src1.name],
                self.suffix,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        if self.suffix == "i32_i24":
            reg_entire = self.node.get_from_state(self.src1).integrity
            new_value = make_op(self.node, self.src0, self.src1, "*", "(int)", "(int)", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MUL, OpenCLTypes.INT
            )
            return set_reg_value(
                self.node,
                new_value,
                self.vdst.name,
                [self.src0.name, self.src1.name],
                self.suffix,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        if self.suffix == "u32_u24":
            reg_entire = self.node.get_from_state(self.src1).integrity
            new_value = make_op(self.node, self.src0, self.src1, "*", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MUL, OpenCLTypes.UINT
            )
            return set_reg_value(
                self.node,
                new_value,
                self.vdst.name,
                [self.src0.name, self.src1.name],
                self.suffix,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        return super().to_fill_node()
