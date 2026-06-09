from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.ir.registers.reg import Val, get_reg_rang


class VAshrrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]

    def to_fill_node(self):
        if self.suffix == "i32":
            new_value = make_op(
                self.node, self.src1, Val(str(pow(2, int(self.src0.value)))), "/", "(int)", suffix=self.suffix
            )

            src1_node = self.get_expression_node(self.src1)
            const_node = self.expression_manager.add_const_node(pow(2, int(self.src0.value)), OpenCLTypes.UINT)
            expr_node = self.expression_manager.add_operation(
                src1_node, const_node, ExpressionOperationType.DIV, OpenCLTypes.INT
            )

            self.node = set_reg_value(
                self.node,
                new_value,
                self.vdst.name,
                [self.src0.name, self.src1.name],
                self.suffix,
                expression_node=expr_node,
            )
            return self.node
        if self.suffix == "i64":
            start_to_register, end_to_register = get_reg_rang(self.vdst)
            start_from_register, end_from_register = get_reg_rang(self.src1)
            if self.node.get_from_state(start_from_register).val == "0":
                self.node.get_from_state(start_from_register).register_content._value = self.node.get_from_state(  # noqa: SLF001
                    end_from_register
                ).val

            start_from_register_node = self.get_expression_node(start_from_register)
            if str(start_from_register_node.value) == "0":
                start_from_register_node = self.get_expression_node(end_from_register)
            power_node = self.expression_manager.add_const_node(pow(2, 32 - int(self.src0.value)), OpenCLTypes.LONG)
            expr_node = self.expression_manager.add_operation(
                start_from_register_node, power_node, ExpressionOperationType.MUL, OpenCLTypes.LONG
            )

            new_value = make_op(
                self.node,
                start_from_register,
                Val(str(pow(2, 32 - int(self.src0.value)))),
                "*",
                "",
                "(long)",
                suffix=self.suffix,
            )
            reg_type = self.node.get_from_state(start_from_register).type
            node = set_reg_value(
                self.node,
                new_value,
                start_to_register.name,
                [start_from_register.name],
                self.suffix,
                reg_type=reg_type,
                integrity=Integrity.LOW_PART,
                expression_node=expr_node,
            )
            return set_reg_value(
                node,
                new_value,
                end_to_register.name,
                [end_from_register.name],
                self.suffix,
                reg_type=reg_type,
                integrity=Integrity.HIGH_PART,
                expression_node=expr_node,
            )
        return super().to_fill_node()
