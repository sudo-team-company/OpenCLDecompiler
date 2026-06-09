from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import is_reg
from src.register_type import RegisterType


def v_sub_fill_node(node, src0, src1, vdst, new_value, suffix, expr_node):  # noqa: PLR0913
    reg_type = RegisterType.INT32
    if is_reg(src0):
        reg_type = node.get_from_state(src0).integrity
    elif is_reg(src1):
        reg_type = node.get_from_state(src1).integrity
    return set_reg_value(
        node, new_value, vdst.name, [src0.name, src1.name], suffix, reg_type=reg_type, expression_node=expr_node
    )


class VSub(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]

    def to_fill_node(self):
        src0_node = self.get_expression_node(self.src0)
        src1_node = self.get_expression_node(self.src1)
        if self.suffix == "u32":
            new_val = make_op(self.node, self.src0, self.src1, "-", "(ulong)", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MINUS, OpenCLTypes.UINT
            )
            return v_sub_fill_node(self.node, self.src0, self.src1, self.vdst, new_val, self.suffix, expr_node)
        if self.suffix == "f32":
            new_val = make_op(self.node, self.src0, self.src1, "-", "(float)", "(float)", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MINUS, OpenCLTypes.FLOAT
            )
            return v_sub_fill_node(self.node, self.src0, self.src1, self.vdst, new_val, self.suffix, expr_node)
        return super().to_fill_node()
