from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import is_reg
from src.register_type import RegisterType


class SLshr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} >> ({self.ssrc1} & 31) // {self.name}\n")
            self.decompiler_data.write(f"scc = {self.sdst}!= 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3 and is_reg(self.ssrc0) and self.ssrc1.isdigit():
            new_reg = self.node.state[self.ssrc0] >> int(self.ssrc1)
            new_reg.cast_to(self.suffix)
            return set_reg(
                node=self.node,
                to_reg=self.sdst,
                from_regs=[self.ssrc0, self.ssrc1],
                reg=new_reg,
            )

        if self.suffix == "b32":
            reg_type = self.node.state[self.ssrc0].type
            expr_node = None
            if (
                self.node.state[self.ssrc0].type == RegisterType.GLOBAL_SIZE_X
                and pow(2, int(self.ssrc1)) == self.decompiler_data.config_data.size_of_work_groups[0]
            ):
                new_value = "get_num_groups(0)"
                expr_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_X, "get_num_groups(0)")
            elif (
                self.node.state[self.ssrc0].type == RegisterType.GLOBAL_SIZE_Y
                and pow(2, int(self.ssrc1)) == self.decompiler_data.config_data.size_of_work_groups[1]
            ):
                new_value = "get_num_groups(1)"
                expr_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_Y, "get_num_groups(1)")
            elif (
                self.node.state[self.ssrc0].type == RegisterType.GLOBAL_SIZE_Z
                and pow(2, int(self.ssrc1)) == self.decompiler_data.config_data.size_of_work_groups[2]
            ):
                new_value = "get_num_groups(2)"
                expr_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_Z, "get_num_groups(2)")
            else:
                new_value = make_op(self.node, self.ssrc0, str(pow(2, int(self.ssrc1))), "/", suffix=self.suffix)

                src0_node = self.get_expression_node(self.ssrc0)
                src1_node = self.expression_manager.add_const_node(pow(2, int(self.ssrc1)), OpenCLTypes.UINT)
                expr_node = self.expression_manager.add_operation(
                    src0_node, src1_node, ExpressionOperationType.DIV, OpenCLTypes.UINT
                )

            return set_reg_value(
                self.node,
                new_value,
                self.sdst,
                [self.ssrc0, self.ssrc1],
                self.suffix,
                reg_type=reg_type,
                expression_node=expr_node,
            )
        return super().to_fill_node()
