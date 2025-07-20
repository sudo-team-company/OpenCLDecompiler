from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes


class VSubrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.vcc = self.instruction[2]
        self.src0 = self.instruction[3]
        self.src1 = self.instruction[4]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            temp = f"temp{self.decompiler_data.number_of_temp}"
            mask = f"mask{self.decompiler_data.number_of_mask}"
            self.decompiler_data.write(f"ulong {temp} = (ulong){self.src1} - (ulong){self.src0} // {self.name}\n")
            self.decompiler_data.write(f"{self.vdst} = CLAMP ? ({temp}>>32 ? 0 : {temp}) : {temp}\n")
            self.decompiler_data.write(f"{self.vcc} = 0\n")  # vop2, sdst
            self.decompiler_data.write(f"ulong {mask} = (1ULL<<LANEID)\n")
            self.decompiler_data.write(f"{self.vcc} = ({self.vcc}&~{mask}) | (({temp}>>32) ? {mask} : 0)\n")
            self.decompiler_data.number_of_temp += 1
            self.decompiler_data.number_of_mask += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "u32":
            new_value = make_op(self.node, self.src1, self.src0, "-", "(ulong)", "(ulong)", suffix=self.suffix)

            src0_node = self.get_expression_node(self.src0)
            src1_node = self.get_expression_node(self.src1)
            expr_node = self.expression_manager.add_operation(
                src1_node, src0_node, ExpressionOperationType.MINUS, OpenCLTypes.from_string(self.suffix)
            )

            reg_entire = self.node.state[self.src1].integrity
            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                self.suffix,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        return super().to_fill_node()
