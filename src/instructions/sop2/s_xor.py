from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.integrity import Integrity


class SXor(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b32':
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} ^ {self.ssrc1} // {self.instruction[0]}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['b32', 'b64']:
            if "exec" in [self.sdst, self.ssrc0]:
                new_exec_condition = self.decompiler_data.exec_registers[self.ssrc0] ^ \
                                     self.decompiler_data.exec_registers[self.ssrc1]
                self.decompiler_data.exec_registers[self.sdst] = new_exec_condition
                return set_reg_value(self.node, new_exec_condition.top(), self.sdst, [self.ssrc0, self.ssrc1], None,
                                     exec_condition=new_exec_condition)
            reg_entire = Integrity.ENTIRE
            if self.node.state.registers.get(self.ssrc1) is not None:
                reg_entire = self.node.state.registers[self.ssrc1].integrity
            if self.node.state.registers.get(self.ssrc0) is not None:
                reg_entire = self.node.state.registers[self.ssrc0].integrity
            new_value = make_op(self.node, self.ssrc0, self.ssrc1, '^', suffix=self.suffix)
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix,
                                 integrity=reg_entire)
        return super().to_fill_node()
