from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes


class SAshr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "i32":
            self.decompiler_data.write(f"{self.sdst} = (int){self.ssrc0} >> ({self.ssrc1} & 31) // {self.name}\n")
            self.decompiler_data.write(f"scc = {self.sdst}!=0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "i32":
            new_value = make_op(self.node, self.ssrc0, str(pow(2, int(self.ssrc1))), "/", "(int)", suffix=self.suffix)

            src0_node = self.get_expression_node(self.ssrc0)
            const_node = self.expression_manager.add_const_node(pow(2, int(self.ssrc1)), OpenCLTypes.UINT)
            expr_node = self.expression_manager.add_operation(
                src0_node, const_node, ExpressionOperationType.DIV, OpenCLTypes.INT
            )

            self.node = set_reg_value(
                self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix, expression_node=expr_node
            )
            return self.node
        return super().to_fill_node()
