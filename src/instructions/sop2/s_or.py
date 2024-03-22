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
        if self.decompiler_data.is_rdna3:
            if self.suffix.endswith("32"):
                new_val = make_op(self.node, self.ssrc0, self.ssrc1, " | ")
                return set_reg_value(
                    node=self.node,
                    new_value=new_val,
                    to_reg=self.sdst,
                    from_regs=[self.ssrc0, self.ssrc1],
                    data_type=self.suffix,
                )


        if self.suffix in ["b32", "b64"]:
            if self.sdst == "exec" and self.ssrc0 == "exec":
                new_exec_condition = self.decompiler_data.exec_registers[self.ssrc0] | \
                                     self.decompiler_data.exec_registers[self.ssrc1]
                self.decompiler_data.exec_registers[self.sdst] = new_exec_condition
                return set_reg_value(self.node, new_exec_condition.top(), self.sdst, [self.ssrc0, self.ssrc1], None,
                                     exec_condition=new_exec_condition)
            new_value = make_op(self.node, self.ssrc0, self.ssrc1, " || ")
            if self.ssrc1 not in self.node.state.registers:
                return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix)
            reg_entire = self.node.state.registers[self.ssrc1].integrity
            return set_reg_value(self.node, new_value, self.sdst, [self.ssrc0, self.ssrc1], self.suffix,
                                 integrity=reg_entire)
        return super().to_fill_node()
