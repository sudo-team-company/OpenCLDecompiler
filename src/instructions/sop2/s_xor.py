from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.ir.registers.reg import is_predicate


class SXor(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.operand[0]
        self.ssrc0 = self.operand[1]
        self.ssrc1 = self.operand[2]

    def to_fill_node(self):
        if self.suffix in {"b32", "b64"}:
            src0_node = self.get_expression_node(self.ssrc0)
            src1_node = self.get_expression_node(self.ssrc1)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.XOR, OpenCLTypes.from_string(self.suffix)
            )

            if any(is_predicate(item) for item in {self.sdst, self.ssrc0, self.ssrc1}):
                if is_predicate(self.ssrc1):
                    self.ssrc1, self.ssrc0 = self.ssrc0, self.ssrc1
                old_exec_condition = self.decompiler_data.exec_registers[self.ssrc0.name]
                new_cond = self.decompiler_data.exec_registers[self.ssrc1.name]
                new_exec_condition = old_exec_condition ^ new_cond
                self.decompiler_data.exec_registers[self.sdst.name] = new_exec_condition

                return set_reg_value(
                    self.node,
                    new_exec_condition.top(),
                    self.sdst.name,
                    [self.ssrc0.name, self.ssrc1.name],
                    "b64",
                    exec_condition=new_exec_condition,
                    expression_node=expr_node,
                )
            reg_entire = Integrity.ENTIRE
            if self.ssrc1.name in self.node.state:
                reg_entire = self.node.get_from_state(self.ssrc1).integrity
            if self.ssrc0.name in self.node.state:
                reg_entire = self.node.get_from_state(self.ssrc0).integrity
            new_value = make_op(self.node, self.ssrc0.name, self.ssrc1.name, "^", suffix=self.suffix)

            return set_reg_value(
                self.node,
                new_value,
                self.sdst.name,
                [self.ssrc0.name, self.ssrc1.name],
                self.suffix,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        return super().to_fill_node()
