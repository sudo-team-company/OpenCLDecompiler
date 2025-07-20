import copy

from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg, set_reg_value
from src.register import is_reg
from src.register_content import RegisterContent
from src.register_type import RegisterType


class VMov(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(f"{self.vdst} = {self.src0} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32":
            if self.src0 in self.node.state:
                new_reg = copy.deepcopy(self.node.state[self.src0])
                return set_reg(node=self.node, to_reg=self.vdst, from_regs=[self.src0], reg=new_reg)

            data_type = self.suffix
            new_value = self.src0
            reg_type = RegisterType.INT32

            expr_node = self.expression_manager.add_register_node(reg_type, new_value)

            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0],
                data_type,
                reg_type=reg_type,
                register_content_type=(
                    type(self.node.state[self.src0].register_content) if is_reg(self.src0) else RegisterContent
                ),
                expression_node=expr_node,
            )
        return super().to_fill_node()
