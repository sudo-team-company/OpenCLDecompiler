from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg
from src.register import is_reg, Register


class SSext(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)

        self.sdst = self.instruction[1]
        self.ssrc = self.instruction[2]

        self.to_data_type, self.from_data_type = self.suffix.split("_")

    def to_fill_node(self):
        if is_reg(self.ssrc) \
                and is_reg(self.sdst) \
                and self.node.state.registers[self.ssrc].get_data_type() == self.from_data_type:
            new_reg: Register = self.node.state.registers[self.ssrc].copy()
            new_reg.data_type = self.to_data_type

            return set_reg(
                node=self.node,
                to_reg=self.sdst,
                from_regs=[self.ssrc],
                reg=new_reg,
            )

        return self.node
