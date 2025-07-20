from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes


class SAddK(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.src0, self.simm16 = self.instruction[1:3]

    def to_print_unresolved(self):
        if self.suffix == "i32":
            temp = f"temp{self.decompiler_data.number_of_temp}"
            self.decompiler_data.write(f"{temp} = {self.src0}\n")
            self.decompiler_data.write(f"{self.src0} = {self.src0} + {self.simm16} // {self.name}\n")
            self.decompiler_data.write(
                f"scc = (({temp} >> 31) == ({self.simm16} >> 15) && ({temp} >> 31) != ({self.src0} >> 31))\n"
            )
            self.decompiler_data.number_of_temp += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "i32":
            new_value = make_op(self.node, self.src0, self.simm16, "+", "(int)", "(int)", suffix=self.suffix)
            data_type = self.node.state[self.src0].data_type
            reg_type = self.node.state[self.src0].type

            src0_node = self.get_expression_node(self.src0)
            simm16_node = self.expression_manager.add_const_node(self.simm16, OpenCLTypes.INT)
            expr_node = self.expression_manager.add_operation(
                src0_node, simm16_node, ExpressionOperationType.PLUS, OpenCLTypes.INT
            )

            return set_reg_value(
                self.node,
                new_value,
                self.src0,
                [self.src0, self.simm16],
                data_type,
                reg_type=reg_type,
                expression_node=expr_node,
            )
        return super().to_fill_node()
