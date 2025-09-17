from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import Register
from src.register_type import RegisterType


class VBfe(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]
        self.src2 = self.instruction[4]

    def to_fill_node(self):
        if self.suffix == "u32":

            def default_behaviour() -> (object, RegisterType):
                op1 = make_op(
                    self.node, self.src0, str(pow(2, int(self.src1))), "/", "(ulong)", "(ulong)", suffix=self.suffix
                )
                op2 = make_op(
                    self.node,
                    self.src0,
                    str(pow(2, int(self.src1) + int(self.src2))),
                    "/",
                    "(ulong)",
                    "(ulong)",
                    suffix=self.suffix,
                )
                op3 = make_op(
                    self.node, op2, str(pow(2, int(self.src2))), "*", "(ulong)", "(ulong)", suffix=self.suffix
                )
                new_value = make_op(self.node, op1, op3, "-", "(ulong)", "(ulong)", suffix=self.suffix)
                reg_type = self.node.state[self.src0].type

                src0_node = self.get_expression_node(self.src0)
                const1_node = self.expression_manager.add_const_node(pow(2, int(self.src1)), OpenCLTypes.UINT)
                op1_node = self.expression_manager.add_operation(
                    src0_node, const1_node, ExpressionOperationType.DIV, OpenCLTypes.UINT
                )
                const2_node = self.expression_manager.add_const_node(
                    pow(2, int(self.src1) + int(self.src2)), OpenCLTypes.UINT
                )
                op2_node = self.expression_manager.add_operation(
                    src0_node, const2_node, ExpressionOperationType.DIV, OpenCLTypes.UINT
                )
                const3_node = self.expression_manager.add_const_node(pow(2, int(self.src2)), OpenCLTypes.UINT)
                op3_node = self.expression_manager.add_operation(
                    op2_node, const3_node, ExpressionOperationType.MUL, OpenCLTypes.UINT
                )
                expr_node = self.expression_manager.add_operation(
                    op1_node, op3_node, ExpressionOperationType.MINUS, OpenCLTypes.UINT
                )
                return set_reg_value(
                    node=self.node,
                    new_value=new_value,
                    to_reg=self.vdst,
                    from_regs=[self.src0],
                    data_type=self.suffix,
                    reg_type=reg_type,
                    expression_node=expr_node,
                )

            if isinstance(self.node.state[self.src0].register_content, CombinedRegisterContent):
                maybe_shift_register: Register = self.node.state[self.src0] >> int(self.src1)

                if maybe_shift_register is not None:
                    if isinstance(maybe_shift_register.register_content, CombinedRegisterContent):
                        new_reg = maybe_shift_register & hex((1 << int(self.src2)) - 1)
                    elif maybe_shift_register.register_content.get_size() == int(self.src2):
                        new_reg = maybe_shift_register
                    else:
                        return default_behaviour()

                    if new_reg is not None:
                        return set_reg(
                            node=self.node,
                            to_reg=self.vdst,
                            from_regs=[self.src0],
                            reg=new_reg,
                        )

            return default_behaviour()

        return super().to_fill_node()
