from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import Val


class DsAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.addr = self.operand[0]
        self.vdata0 = self.operand[1]
        self.varname = self.expression_manager.expression_to_string(self.get_expression_node(self.addr))

    def get_lds_var_name_with_offset(self):
        return self.expression_manager.expression_to_string(
            self.expression_manager.add_offset_div_data_size_node(
                self.decompiler_data.lds_vars[self.offset],
                self.get_expression_node(self.addr),
                4,
                OpenCLTypes.from_string(self.suffix),
            )
        )

    def to_fill_node(self):
        if self.suffix == "u32":
            new_value = f"{self.node.state[self.varname].val} + {self.node.get_from_state(self.vdata0).val}"
            expr_node = self.expression_manager.add_operation(
                self.get_expression_node(Val(self.varname)),
                self.get_expression_node(self.vdata0),
                ExpressionOperationType.PLUS,
                OpenCLTypes.UINT,
            )
            return set_reg_value(self.node, new_value, self.varname, [], self.suffix, expression_node=expr_node)
        return super().to_fill_node()

    def to_print(self):
        if self.suffix == "u32":
            self.output_string = f"{self.varname} += {
                self.expression_manager.expression_to_string(self.get_expression_node(self.vdata0))
            }"
            return self.output_string
        return super().to_print()
