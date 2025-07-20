from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import is_reg
from src.register_type import RegisterType


class VSubNc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        if "rev" in self.name:
            self.vdst, self.src1, self.src0 = self.instruction[1:4]
        else:
            self.vdst, self.src0, self.src1 = self.instruction[1:4]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            self.decompiler_data.write(f"{self.vdst} = (uint){self.src0} - (uint){self.src1} // {self.name}\n")
            return self.node
        if self.suffix == "u16":
            self.decompiler_data.write(f"{self.vdst} = (ushort){self.src0} - (ushort){self.src1} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        src0_node = self.get_expression_node(self.src0)
        src1_node = self.get_expression_node(self.src1)

        reg_type = RegisterType.INT32
        if is_reg(self.src0):
            reg_type = self.node.state[self.src0].integrity
        elif is_reg(self.src1):
            reg_type = self.node.state[self.src1].integrity
        if self.suffix == "u32":
            new_value = make_op(self.node, self.src0, self.src1, "-", "(uint)", "(uint)", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MINUS, OpenCLTypes.UINT
            )
            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                self.suffix,
                reg_type=reg_type,
                expression_node=expr_node,
            )
        if self.suffix == "u16":
            new_value = make_op(self.node, self.src0, self.src1, "-", "(ushort)", "(ushort)", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MINUS, OpenCLTypes.USHORT
            )
            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                self.suffix,
                reg_type=reg_type,
                expression_node=expr_node,
            )
        return super().to_fill_node()
