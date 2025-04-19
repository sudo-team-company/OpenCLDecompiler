from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.types.opencl_types import OpenCLTypes


class DsAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.addr = self.instruction[1]
        self.vdata0 = self.instruction[2]
        self.offset = int(self.instruction[3][7:]) if len(self.instruction) == 4 else 0  # noqa: PLR2004
        self.varname = self.get_lds_var_name_with_offset()

    def to_print_unresolved(self):
        if self.suffix == "u32":
            v = f"V{self.decompiler_data.number_of_v}"
            self.decompiler_data.write(f"uint* {v} = (uint*)(DS + (({self.addr} + {self.offset})&~3)) // {self.name}\n")
            self.decompiler_data.write(f"*{v} = *{v} + {self.vdata0}  // atomic operation\n")
            self.decompiler_data.number_of_v += 1
            return self.node
        return super().to_print_unresolved()

    def get_lds_var_name_with_offset(self):
            return self.expression_manager.expression_to_string(self.expression_manager.add_offset_thingy_node(
                self.decompiler_data.lds_vars[self.offset],
                self.node.get_expression_node(self.addr),
                4))

    def to_fill_node(self):
        if self.suffix == "u32":
            new_value = f"{self.node.state[self.varname].val} + {self.node.state[self.vdata0].val}"
            expr_node = self.expression_manager.add_operation(self.node.get_expression_node(self.varname),
                                                                       self.node.get_expression_node(self.vdata0),
                                                                       ExpressionOperationType.PLUS,
                                                                       OpenCLTypes.UINT)
            return set_reg_value(self.node, new_value, self.varname, [], self.suffix, expression_node=expr_node)
        return super().to_fill_node()

    def to_print(self):
        if self.suffix == "u32":
            self.output_string = f"{self.varname} += {self.expression_manager.expression_to_string(
                self.node.get_expression_node(self.vdata0))}"
            return self.output_string
        return super().to_print()
