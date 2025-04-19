from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.register import is_reg


class SSub(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        temp = f"temp{self.decompiler_data.number_of_temp}"
        if self.suffix == "i32":
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} - {self.ssrc1} // {self.name}\n")
            self.decompiler_data.write(f"long {temp} = (long){self.ssrc0} - (long){self.ssrc1}\n")
            self.decompiler_data.write(f"scc = {temp} > ((1LL << 31) - 1) || {temp} < (-1LL << 31)\n")
            self.decompiler_data.number_of_temp += 1
            return self.node
        if self.suffix == "u32":
            self.decompiler_data.write(f"ulong {temp} = (ulong){self.ssrc0} - (ulong){self.ssrc1} // {self.name}\n")
            self.decompiler_data.write(f"{self.sdst} = {temp}\n")
            self.decompiler_data.write(f"scc = ({temp}>>32)!=0\n")
            self.decompiler_data.number_of_temp += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        src0_node = self.node.get_expression_node(self.ssrc0)
        src1_node = self.node.get_expression_node(self.ssrc1)
        reg_entire = Integrity.ENTIRE
        if is_reg(self.ssrc1):
            reg_entire = self.node.state[self.ssrc1].integrity
        elif is_reg(self.ssrc0):
            reg_entire = self.node.state[self.ssrc0].integrity
        if self.suffix == "u32":
            new_value = make_op(self.node, self.ssrc0, self.ssrc1, "-", "(ulong)", "(ulong)", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(src0_node, src1_node, ExpressionOperationType.MINUS, OpenCLTypes.ULONG)
            return set_reg_value(
                self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix, integrity=reg_entire, expression_node=expr_node
            )
        if self.suffix == "i32":
            new_value = make_op(self.node, self.ssrc0, self.ssrc1, "-", "(long)", "(long)", suffix=self.suffix)
            expr_node = self.expression_manager.add_operation(src0_node, src1_node, ExpressionOperationType.MINUS, OpenCLTypes.LONG)
            return set_reg_value(
                self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix, integrity=reg_entire, expression_node=expr_node
            )
        return super().to_fill_node()
