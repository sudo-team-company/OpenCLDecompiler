from src.types.opencl_types import OpenCLTypes
from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.register import is_sgpr
from src.register_type import RegisterType


class SMul(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "i32":
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} * {self.ssrc1} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "i32":
            src0_node = self.node.get_expression_node(self.ssrc0)
            src1_node = self.node.get_expression_node(self.ssrc1)
            expr_node = self.expression_manager.add_operation(src0_node, src1_node, ExpressionOperationType.MUL, OpenCLTypes.INT)

            new_value = make_op(self.node, self.ssrc0, self.ssrc1, "*", suffix=self.suffix)
            ssrc0_reg = is_sgpr(self.ssrc0)
            ssrc1_reg = is_sgpr(self.ssrc1)
            reg_type = RegisterType.UNKNOWN
            if ssrc0_reg and ssrc1_reg:
                if (
                    self.node.state[self.ssrc0].type == RegisterType.LOCAL_SIZE_X
                    and self.node.state[self.ssrc1].type == RegisterType.WORK_GROUP_ID_X
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
                elif (
                    self.node.state[self.ssrc0].type == RegisterType.LOCAL_SIZE_Y
                    and self.node.state[self.ssrc1].type == RegisterType.WORK_GROUP_ID_Y
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
                elif (
                    self.node.state[self.ssrc0].type == RegisterType.LOCAL_SIZE_Z
                    and self.node.state[self.ssrc1].type == RegisterType.WORK_GROUP_ID_Z
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE
            return set_reg_value(
                self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix, reg_type=reg_type, expression_node=expr_node
            )
        return super().to_fill_node()
