from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import is_reg


class VLshlAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            self.decompiler_data.write(f"{self.vdst} = ({self.src0} << {self.src1}) + {self.src2} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3 and is_reg(self.src0) and self.src1.isdigit() and is_reg(self.src2):
            new_reg = self.node.state[self.src0] * int(pow(2, int(self.src1)))
            new_reg = new_reg + self.node.state[self.src2]

            return set_reg(
                node=self.node,
                to_reg=self.vdst,
                from_regs=[self.src0, self.src1, self.src2],
                reg=new_reg,
            )

        if self.suffix == "u32" and self.src1.isdigit():
            new_value = make_op(self.node, self.src0, str(int(pow(2, int(self.src1)))), "*", suffix=self.suffix)
            new_value = make_op(self.node, new_value, self.src2, "+", "(ulong)", "(ulong)", suffix=self.suffix)

            src0_node = self.get_expression_node(self.src0)
            src2_node = self.get_expression_node(self.src2)
            mul_node = self.expression_manager.add_operation(
                src0_node,
                self.expression_manager.add_const_node(pow(2, int(self.src1)), OpenCLTypes.from_string(self.suffix)),
                ExpressionOperationType.MUL,
                OpenCLTypes.from_string(self.suffix),
            )
            expr_node = self.expression_manager.add_operation(
                mul_node, src2_node, ExpressionOperationType.PLUS, OpenCLTypes.from_string(self.suffix)
            )

            return set_reg_value(
                node=self.node,
                new_value=new_value,
                to_reg=self.vdst,
                from_regs=[self.src0, self.src1, self.src2],
                data_type=self.suffix,
                expression_node=expr_node,
            )
        return super().to_fill_node()
