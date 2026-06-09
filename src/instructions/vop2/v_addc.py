from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.ir.registers.reg import is_reg
from src.register_type import RegisterType


class VAddc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]

    def to_fill_node(self):
        if self.suffix == "u32":
            new_value = make_op(self.node, self.src0, self.src1, "+", "(ulong)", "(ulong)", suffix=self.suffix)
            src0_reg = is_reg(self.src0)
            src1_reg = is_reg(self.src1)
            reg_type = RegisterType.UNKNOWN
            reg_entire = Integrity.ENTIRE

            src0_node = self.get_expression_node(self.src0)
            src1_node = self.get_expression_node(self.src1)
            expr_node = None

            if src0_reg and src1_reg:
                if self.node.get_from_state(self.src1).val == "0":
                    new_value = self.node.get_from_state(self.src0).val
                    reg_type = self.node.get_from_state(self.src0).type
                    reg_entire = self.node.get_from_state(self.src0).integrity

                    expr_node = src0_node
                elif self.node.get_from_state(self.src0).val == "0":
                    new_value = self.node.get_from_state(self.src1).val
                    reg_type = self.node.get_from_state(self.src1).type
                    reg_entire = self.node.get_from_state(self.src1).integrity

                    expr_node = src1_node
                else:
                    reg_entire = self.node.get_from_state(self.src1).integrity
                    if (
                        self.node.get_from_state(self.src0).type == RegisterType.ADDRESS_KERNEL_ARGUMENT
                        and self.node.get_from_state(self.src1).type == RegisterType.GLOBAL_ID_X
                    ):
                        new_value = f"{self.node.get_from_state(self.src0).val}[get_global_id(0)]"
                        reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT
                        global_id_node = self.expression_manager.add_register_node(RegisterType.GLOBAL_ID_X)
                        expr_node = self.expression_manager.add_operation(
                            src0_node,
                            global_id_node,
                            ExpressionOperationType.PLUS,
                            OpenCLTypes.from_string(self.suffix),
                        )
            else:
                reg_type = RegisterType.INT32
                if src0_reg:
                    reg_type = self.node.get_from_state(self.src0).type
                if src1_reg:
                    reg_type = self.node.get_from_state(self.src1).type

            if expr_node is None:
                expr_node = self.expression_manager.add_operation(
                    src0_node, src1_node, ExpressionOperationType.PLUS, OpenCLTypes.from_string(self.suffix)
                )

            return set_reg_value(
                self.node,
                new_value,
                self.vdst.name,
                [self.src0.name, self.src1.name],
                self.suffix,
                reg_type=reg_type,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        return super().to_fill_node()
