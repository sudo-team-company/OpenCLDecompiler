from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType, ExpressionType
from src.expression_manager.types.opencl_types import OpenCLTypes


class SAndn2(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "b64":
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} & ~{self.ssrc1} // {self.name}\n")
            self.decompiler_data.write(f"scc = {self.sdst} != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in {"b32", "b64"}:
            if "exec" in {self.sdst, self.ssrc0, self.ssrc1}:
                if self.ssrc1 == "exec":
                    self.ssrc1, self.ssrc0 = self.ssrc0, self.ssrc1
                new_exec_condition = (
                    self.decompiler_data.exec_registers[self.ssrc0] ^ self.decompiler_data.exec_registers[self.ssrc1]
                )
                self.decompiler_data.exec_registers[self.sdst] = new_exec_condition
                print(new_exec_condition.top())

                left_node = self.node.get_expression_node(self.ssrc0)
                right_node = self.node.get_expression_node(self.ssrc1)
                expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.XOR, OpenCLTypes.from_string(self.suffix))

                return set_reg_value(
                    self.node,
                    new_exec_condition.top(),
                    self.sdst,
                    [self.ssrc0, self.ssrc1],
                    None,
                    exec_condition=new_exec_condition,
                    expression_node=expr_node
                )
            return self.node
        return super().to_fill_node()
