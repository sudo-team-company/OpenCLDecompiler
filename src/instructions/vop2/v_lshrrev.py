from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import Register, is_reg
from src.register_type import RegisterType


class VLshrrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "b64":
            self.decompiler_data.write(f"{self.vdst} = {self.src1} >> ({self.src0} & 63) // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32" and is_reg(self.src1):

            def default_behaviour():
                new_value = make_op(self.node, self.src1, str(pow(2, int(self.src0))), "//", suffix=self.suffix)
                reg_type = self.node.state[self.src1].type

                src1_node = self.node.get_expression_node(self.src1)
                const_node = self.expression_manager.add_const_node(pow(2, int(self.src0)), OpenCLTypes.UINT)
                expr_node = self.expression_manager.add_operation(
                    src1_node, const_node, ExpressionOperationType.DIV, OpenCLTypes.UINT)

                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=reg_type,
                    expression_node=expr_node
                )

            if isinstance(self.node.state[self.src1].register_content, CombinedRegisterContent):
                maybe_new_register: Register = self.node.state[self.src1] >> int(self.src0)

                if maybe_new_register is not None:
                    return set_reg(
                        node=self.node,
                        to_reg=self.vdst,
                        from_regs=[self.src0, self.src1],
                        reg=maybe_new_register,
                    )

            if self.node.state[self.src1].val == "0":
                new_value = "0"
                reg_type = RegisterType.INT32
                expr_node = self.expression_manager.add_const_node(0, OpenCLTypes.UINT)
            else:
                return default_behaviour()

            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                self.suffix,
                reg_type=reg_type,
                expression_node=expr_node
            )

        return super().to_fill_node()
