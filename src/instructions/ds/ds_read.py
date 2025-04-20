from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_node import ExpressionNode
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register_type import RegisterType


class DsRead(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.addr = self.instruction[2]
        self.offset = int(self.instruction[3][7:]) if len(self.instruction) == 4 else 0  # noqa: PLR2004

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(
                f"{self.vdst} = *(uint*)(DS + (({self.addr} + {self.offset})&~3)) // {self.name}\n"
            )
            return self.node
        if self.suffix == "b64":
            self.decompiler_data.write(
                f"{self.vdst} = *(ulong*)(DS + (({self.addr} + {self.offset})&~7)) // {self.name}\n"
            )
            return self.node
        return super().to_print_unresolved()

    def get_lds_var_node_with_offset(self) -> ExpressionNode:
        return self.expression_manager.add_offset_div_data_size(
            self.decompiler_data.lds_vars[self.offset],
            self.node.get_expression_node(self.addr),
            4,
            OpenCLTypes.from_string(self.suffix))

    def to_fill_node(self):
        if self.suffix == "b32":
            var_node_with_offset = self.get_lds_var_node_with_offset()
            name = self.expression_manager.expression_to_string(var_node_with_offset)
            reg_type = self.node.state[name].type if name in self.node.state else RegisterType.UNKNOWN
            return set_reg_value(self.node,
                                 name,
                                 self.vdst,
                                 [],
                                 f"u{self.suffix[1:]}",
                                 reg_type=reg_type,
                                 expression_node=var_node_with_offset)
        if self.suffix == "b64":
            var_node_with_offset = self.get_lds_var_node_with_offset()
            name = self.expression_manager.expression_to_string(var_node_with_offset)
            reg_type = self.node.state[name].type
            return set_reg_value(self.node,
                                 name,
                                 self.vdst,
                                 [],
                                 f"u{self.suffix[1:]}",
                                 reg_type=reg_type,
                                 expression_node=var_node_with_offset)
        return super().to_fill_node()
