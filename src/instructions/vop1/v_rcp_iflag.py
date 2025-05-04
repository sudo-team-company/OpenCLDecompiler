from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.register_type import RegisterType


class VRcpIflag(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == "f32":
            self.decompiler_data.write(f"{self.vdst} = 1.0 / {self.src0} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "f32":
            data_type = self.suffix
            new_value = self.node.state[self.src0].val
            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0],
                data_type,
                reg_type=RegisterType.DIVISION_RECIPROCAL,
                expression_node=self.node.get_expression_node(self.src0),
            )
        return super().to_fill_node()
