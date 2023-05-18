from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.register import check_and_split_regs


class SAnd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix in ['b32', 'b64']:
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} & {self.ssrc1} // {self.instruction[0]}\n")
            self.decompiler_data.write(f"scc = {self.sdst} != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['b32', 'b64']:
            if "exec" in [self.sdst, self.ssrc0, self.ssrc1]:
                if self.ssrc1 == "exec":
                    self.ssrc1, self.ssrc0 = self.ssrc0, self.ssrc1
                old_exec_condition = self.decompiler_data.exec_registers[self.ssrc0]
                new_cond = self.node.state.registers[self.ssrc1].val

                new_exec_condition = old_exec_condition & new_cond
                self.decompiler_data.exec_registers[self.ssrc0] = new_exec_condition
                return set_reg_value(self.node, new_exec_condition.top(), self.sdst, [self.ssrc0, self.ssrc1], None,
                                     exec_condition=new_exec_condition)
            elif self.ssrc0 in self.node.state.registers:
                reg = self.node.state.registers[self.ssrc0]
            else:
                ssrc0 = check_and_split_regs(self.ssrc0)[0]
                reg = self.node.state.registers[ssrc0]
            return set_reg_value(
                node=self.node,
                new_value=reg.val,
                to_reg=self.sdst,
                from_regs=[self.ssrc0, self.ssrc1],
                data_type=self.suffix,
                reg_type=reg.type,
                reg_entire=reg.integrity
            )
        return super().to_fill_node()

    def to_print(self):
        if self.sdst == "exec":
            self.output_string = self.node.state.registers["exec"].val
        return self.output_string
