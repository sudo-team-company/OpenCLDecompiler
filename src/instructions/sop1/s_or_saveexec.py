from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType, ExpressionType
from src.expression_manager.types.opencl_types import OpenCLTypes


class SOrSaveexec(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in {"b32", "b64"}:
            exec_reg = "exec_lo" if self.suffix == "b32" else "exec"
            self.decompiler_data.write(f"{self.sdst} = {exec_reg} // {self.name}\n")
            self.decompiler_data.write(f"{exec_reg} = {self.ssrc0} | {exec_reg}\n")
            self.decompiler_data.write(f"scc = {exec_reg} != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in {"b32", "b64"}:
            old_exec_condition = self.decompiler_data.exec_registers["exec"]
            another = self.decompiler_data.exec_registers[self.ssrc0]

            prev_exec_cond_node = self.node.get_expression_node("exec")

            self.decompiler_data.exec_registers[self.sdst] = old_exec_condition
            set_reg_value(
                self.node, old_exec_condition.top(), self.sdst, ["exec"], None, exec_condition=old_exec_condition, expression_node=prev_exec_cond_node
            )

            new_exec_cond_node = self.node.get_expression_node(self.ssrc0)

            if prev_exec_cond_node.type == ExpressionType.UNKNOWN:
                expr_node = new_exec_cond_node
            else:
                expr_node = self.expression_manager.add_operation(prev_exec_cond_node, new_exec_cond_node, ExpressionOperationType.OR, OpenCLTypes.UINT if self.suffix == "b32" else OpenCLTypes.ULONG)

            new_exec_condition = old_exec_condition | another
            self.decompiler_data.exec_registers["exec"] = new_exec_condition
            return set_reg_value(
                self.node,
                new_exec_condition.top(),
                "exec",
                ["exec", self.ssrc0],
                None,
                exec_condition=new_exec_condition,
                expression_node=expr_node
            )
        return self.to_fill_node()
