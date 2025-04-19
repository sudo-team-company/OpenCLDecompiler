from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes


class SMulk(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.simm16 = self.instruction[2][self.instruction[2].find("x") + 1 :]
        self.unmodified_simm16 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == "i32":
            self.decompiler_data.write(f"{self.sdst} = {self.sdst} * {self.simm16} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3:
            simm16 = self.unmodified_simm16
            if str(simm16).startswith("0x"):
                simm16 = str(int(simm16, 16))

            if simm16.isdigit():
                simm16 = int(simm16)
                max_bit_number = 4 * len(self.simm16) - 1
                max_bit = simm16 & (1 << max_bit_number)
                if max_bit != 0:
                    simm16 = simm16 ^ ((1 << (max_bit_number + 1)) - 1)
                    simm16 += 1
                    simm16 *= -1

                new_reg = self.node.state[self.sdst] * simm16
                new_reg.cast_to(self.suffix)
                return set_reg(
                    node=self.node,
                    to_reg=self.sdst,
                    from_regs=[self.sdst],
                    reg=new_reg,
                )

        if self.suffix == "i32":
            new_value = make_op(self.node, self.sdst, self.simm16, "*", suffix=self.suffix)
            expr_node = self.expression_manager(self.node.get_expression_node(self.sdst), self.node.get_expression_node(self.simm16), ExpressionOperationType.MUL, OpenCLTypes.INT)
            return set_reg_value(self.node, new_value, self.sdst, [self.sdst], self.suffix)
        return super().to_fill_node()
