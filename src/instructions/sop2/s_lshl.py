from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import check_and_split_regs
from src.register_type import RegisterType


class SLshl(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} << ({self.ssrc1} & 31) // {self.name}\n")
            self.decompiler_data.write(f"scc = {self.sdst}!= 0\n")
            return self.node
        if self.suffix == "b64":
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} << ({self.ssrc1} & 63) // {self.name}\n")
            self.decompiler_data.write(f"scc = {self.sdst}!= 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32":
            new_value = make_op(self.node, self.ssrc0, str(pow(2, int(self.ssrc1))), "*", suffix=self.suffix)

            op_node = self.expression_manager.add_operation(
                self.node.get_expression_node(self.ssrc0),
                self.expression_manager.add_const_node(pow(2, int(self.ssrc1)), OpenCLTypes.from_string(self.suffix)),
                ExpressionOperationType.MUL,
                OpenCLTypes.from_string(self.suffix),
            )

            if self.node.state[self.ssrc0].type == RegisterType.WORK_GROUP_ID_X:
                reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
            elif self.node.state[self.ssrc0].type == RegisterType.WORK_GROUP_ID_Y:
                reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
            elif self.node.state[self.ssrc0].type == RegisterType.WORK_GROUP_ID_Z:
                reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE
            else:
                reg_type = self.node.state[self.ssrc0].type
            return set_reg_value(
                self.node,
                new_value,
                self.sdst,
                [self.ssrc0, self.ssrc1],
                self.suffix,
                reg_type=reg_type,
                expression_node=op_node,
            )
        if self.suffix == "b64":
            start_to_register, end_to_register = check_and_split_regs(self.sdst)
            start_from_register, end_from_register = check_and_split_regs(self.ssrc0)
            new_value0 = make_op(self.node, start_from_register, str(pow(2, int(self.ssrc1))), "*", suffix=self.suffix)
            new_value1 = make_op(self.node, end_from_register, str(pow(2, int(self.ssrc1))), "*", suffix=self.suffix)
            reg_type0 = self.node.state[start_from_register].type
            reg_type1 = self.node.state[end_from_register].type

            op_node0 = self.expression_manager.add_operation(
                self.node.get_expression_node(start_from_register),
                self.expression_manager.add_const_node(pow(2, int(self.ssrc1)), OpenCLTypes.from_string(self.suffix)),
                ExpressionOperationType.MUL,
                OpenCLTypes.from_string(self.suffix),
            )

            op_node1 = self.expression_manager.add_operation(
                self.node.get_expression_node(end_from_register),
                self.expression_manager.add_const_node(pow(2, int(self.ssrc1)), OpenCLTypes.from_string(self.suffix)),
                ExpressionOperationType.MUL,
                OpenCLTypes.from_string(self.suffix),
            )

            data_type = self.suffix
            if self.ssrc1 == "3":
                data_type = "8 bytes"
            elif self.ssrc1 == "2":
                data_type = "4 bytes"
            node = set_reg_value(
                self.node,
                new_value0,
                start_to_register,
                [start_from_register, self.ssrc1],
                data_type,
                reg_type=reg_type0,
                expression_node=op_node0,
            )
            return set_reg_value(
                node,
                new_value1,
                end_to_register,
                [end_from_register, self.ssrc1],
                data_type,
                reg_type=reg_type1,
                expression_node=op_node1,
            )

        if self.decompiler_data.is_rdna3:
            new_reg = self.node.state[self.ssrc0] * pow(2, int(self.ssrc1))
            new_reg.cast_to(self.suffix)
            return set_reg(
                node=self.node,
                to_reg=self.sdst,
                from_regs=[self.ssrc0],
                reg=new_reg,
            )

        return super().to_fill_node()
