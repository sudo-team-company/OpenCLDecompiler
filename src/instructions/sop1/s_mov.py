from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_manager import VariableAddressSpaceQualifiers
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.global_data import get_gdata_offset
from src.register_type import RegisterType


class SMov(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in {"b32", "b64"}:
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in {"b32", "b64"}:
            expr_node = None

            if self.sdst == "exec":
                new_exec_condition = (
                    self.decompiler_data.exec_registers["exec"] | self.decompiler_data.exec_registers[self.ssrc0]
                )

                #todo double check
                exec_node = self.node.get_expression_node("exec")
                src0_node = self.node.get_expression_node(self.ssrc0)
                expr_node = self.expression_manager.add_operation(
                    exec_node, src0_node, ExpressionOperationType.OR, OpenCLTypes.from_string(self.suffix))

                return set_reg_value(
                    self.node,
                    new_exec_condition.top(),
                    self.sdst,
                    [self.ssrc0],
                    None,
                    exec_condition=new_exec_condition,
                    expression_node=expr_node
                )
            if self.ssrc0 in self.node.state:
                new_value = self.node.state[self.ssrc0].val
                reg_type = self.node.state[self.ssrc0].type
                data_type = self.node.state[self.ssrc0].data_type
            else:
                if ".gdata" in self.ssrc0:
                    new_value = f"gdata{get_gdata_offset(self.ssrc0)}"
                    reg_type = RegisterType.GLOBAL_DATA_POINTER
                    #todo fix
                    expr_node = self.expression_manager.add_variable_node(
                        f"*{new_value}",
                        OpenCLTypes.from_string(self.suffix),
                        VariableAddressSpaceQualifiers.GLOBAL)
                else:
                    new_value = self.ssrc0
                    reg_type = RegisterType.INT32
                    expr_node = self.expression_manager.add_register_node(reg_type, new_value)
                data_type = self.suffix

            if expr_node is None:
                expr_node = self.node.get_expression_node(self.ssrc0)

            return set_reg_value(self.node, new_value, self.sdst, [], data_type, reg_type=reg_type, expression_node=expr_node)
        return super().to_fill_node()
