from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.integrity import Integrity
from src.ir.registers.reg import Val, is_predicate
from src.register_type import RegisterType


class SMov(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.operand[0]
        self.ssrc0 = self.operand[1]

    def to_fill_node(self):
        if self.suffix in {"b32", "b64", "i32"}:
            expr_node = None

            if is_predicate(self.ssrc0) or is_predicate(self.sdst):
                self.decompiler_data.exec_registers[self.sdst.name] = self.decompiler_data.exec_registers[
                    self.ssrc0.name
                ]

                expr_node = self.get_expression_node(self.ssrc0)
                new_value = self.node.get_from_state(self.ssrc0).val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.sdst.name,
                    "b64",
                    None,
                    expression_node=expr_node,
                )
            if self.ssrc0.name in self.node.state:
                new_value = self.node.get_from_state(self.ssrc0).val
                reg_type = self.node.get_from_state(self.ssrc0).type
                data_type = self.node.get_from_state(self.ssrc0).data_type
            else:
                assert isinstance(self.ssrc0, Val)
                new_value = self.ssrc0.value
                reg_type = RegisterType.INT32
                expr_node = self.expression_manager.add_register_node(reg_type, new_value)
                data_type = self.suffix

            if expr_node is None:
                expr_node = self.get_expression_node(self.ssrc0)
            if self.suffix == "b64":
                set_reg_value(
                    self.node,
                    new_value,
                    self.sdst.get_element(0).name,
                    [],
                    data_type,
                    integrity=Integrity.LOW_PART,
                    reg_type=reg_type,
                    expression_node=expr_node,
                )
                set_reg_value(
                    self.node,
                    new_value,
                    self.sdst.get_element(1).name,
                    [],
                    data_type,
                    integrity=Integrity.HIGH_PART,
                    reg_type=reg_type,
                    expression_node=expr_node,
                )
            return set_reg_value(
                self.node, new_value, self.sdst.name, [], data_type, reg_type=reg_type, expression_node=expr_node
            )
        return super().to_fill_node()
