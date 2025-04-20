from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import is_reg, is_sgpr
from src.register_type import RegisterType


class SAddc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            temp = f"temp{self.decompiler_data.number_of_temp}"
            self.decompiler_data.write(
                f"ulong {temp} = (ulong){self.ssrc0} + (ulong){self.ssrc1} + scc // {self.name}\n"
            )
            self.decompiler_data.write(f"{self.sdst} = {temp}\n")
            self.decompiler_data.write(f"scc = {temp} >> 32\n")
            self.decompiler_data.number_of_temp += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3 and is_reg(self.ssrc0) and is_reg(self.ssrc1):
            new_reg = self.node.state[self.ssrc0] + self.node.state[self.ssrc1]

            return set_reg(
                node=self.node,
                to_reg=self.sdst,
                from_regs=[self.ssrc0, self.ssrc1],
                reg=new_reg,
            )

        if self.suffix == "u32":
            new_value = make_op(self.node, self.ssrc0, self.ssrc1, "+", "(ulong)", "(ulong)", suffix=self.suffix)

            expr_node = None
            src0_node = self.node.get_expression_node(self.ssrc0)
            src1_node = self.node.get_expression_node(self.ssrc1)

            ssrc0_reg = is_sgpr(self.ssrc0)
            ssrc1_reg = is_sgpr(self.ssrc1)
            reg_type = RegisterType.INT32
            data_type = self.suffix
            if self.ssrc0.isdigit() and int(self.ssrc0) == 0 and ssrc1_reg:
                new_value = self.node.state[self.ssrc1].val
                reg_type = self.node.state[self.ssrc1].type

                #todo - put it inside optimization?
                expr_node = src1_node
            if self.ssrc1.isdigit() and int(self.ssrc1) == 0 and ssrc0_reg:
                new_value = self.node.state[self.ssrc0].val
                reg_type = self.node.state[self.ssrc0].type

                #todo - same as above
                expr_node = src0_node
            if ssrc0_reg and self.node.state[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                if self.node.state[self.ssrc0].data_type in {"u32", "i32", "gu32", "gi32"}:
                    new_value = make_op(self.node, self.ssrc1, "4", "/", suffix=self.suffix)
                    new_value = make_op(self.node, self.ssrc0, new_value, "+", suffix=self.suffix)

                    expr_node = self.expression_manager.add_offset_div_data_size(
                        src0_node, src1_node, 4, OpenCLTypes.from_string(self.suffix))
                if self.ssrc0 == self.sdst:
                    data_type = self.node.parent[0].state[self.ssrc0].data_type
                else:
                    data_type = self.node.state[self.ssrc0].data_type
                reg_type = self.node.state[self.ssrc0].type

            if expr_node is None:
                expr_node = self.expression_manager.add_operation(src0_node, src1_node, ExpressionOperationType.PLUS, OpenCLTypes.UINT)

            return set_reg_value(
                self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], data_type, reg_type=reg_type, expression_node=expr_node
            )
        return super().to_fill_node()
