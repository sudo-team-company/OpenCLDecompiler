from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value_save
from src.ir.registers.reg import is_predicate
from src.logical_variable import ExecCondition


class SNot(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.operand[0]
        self.ssrc0 = self.operand[1]

    def to_fill_node(self):
        if self.suffix in {"b32", "b64"}:
            src_state = self.node.get_from_state(self.ssrc0)

            new_value = f"!({src_state.val})"
            data_type = self.suffix
            reg_type = src_state.type

            ssrc0_node = self.get_expression_node(self.ssrc0)
            expr_node = self.expression_manager.add_logical_not_node(ssrc0_node)

            if is_predicate(self.sdst) and is_predicate(self.ssrc0):
                self.decompiler_data.exec_registers[self.sdst.name] = ExecCondition([new_value])

            return set_reg_value_save(
                self.node,
                new_value,
                self.sdst,
                [self.ssrc0],
                data_type,
                reg_type=reg_type,
                expression_node=expr_node,
            )

        return super().to_fill_node()
