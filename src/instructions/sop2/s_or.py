from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value


class SOr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix in ["b32", "b64"]:
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} | {self.ssrc1} // {self.instruction[0]}\n")
            self.decompiler_data.write(f"scc = {self.sdst} != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ["b32", "b64"]:
            if "exec" in [self.sdst, self.ssrc0, self.ssrc1]:
                assert self.sdst == self.ssrc0 == "exec"
                new_exec_condition = self.node.state.registers["exec"].exec_condition \
                    | self.node.state.registers[self.ssrc1].exec_condition
                return set_reg_value(self.node, new_exec_condition.top(), self.sdst, [self.ssrc0, self.ssrc1], None,
                                     exec_condition=new_exec_condition)
            if self.sdst == "exec" and self.ssrc0 == "exec" and self.node.state.registers.get(self.ssrc1) is None:
                new_value = self.node.state.registers[self.ssrc0].val
                reg_entire = self.node.state.registers[self.ssrc0].integrity
            else:
                new_value = make_op(self.node, self.ssrc0, self.ssrc1, " | ")
                reg_entire = self.node.state.registers[self.ssrc1].integrity
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix,
                                 reg_entire=reg_entire)
        return super().to_fill_node()
