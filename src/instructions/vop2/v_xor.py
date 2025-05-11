from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes


class VXor(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(f"{self.vdst} = {self.src0} ^ {self.src1} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32":
            reg_entire = self.node.state[self.src1].integrity
            new_value = make_op(self.node, self.src0, self.src1, "^", suffix=self.suffix)
            src0_node = self.get_expression_node(self.src0)
            src1_node = self.get_expression_node(self.src1)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.XOR, OpenCLTypes.UINT
            )
            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                self.suffix,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        return super().to_fill_node()
