from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value, DecompilerData


class SOrSaveexec(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in ["b32", "b64"]:
            exec_reg = "exec_lo" if self.suffix == "b32" else "exec"
            self.decompiler_data.write(f"{self.sdst} = {exec_reg} // {self.instruction[0]}\n")
            self.decompiler_data.write(f"{exec_reg} = {self.ssrc0} | {exec_reg}\n")
            self.decompiler_data.write(f"scc = {exec_reg} != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ["b32", "b64"]:
            decompiler_data = DecompilerData()
            old_exec_condition = decompiler_data.exec_registers["exec"]
            another = decompiler_data.exec_registers[self.ssrc0]

            decompiler_data.exec_registers[self.sdst] = old_exec_condition
            set_reg_value(self.node, old_exec_condition.top(), self.sdst, ["exec"], None,
                          exec_condition=old_exec_condition)

            new_exec_condition = old_exec_condition | another
            decompiler_data.exec_registers["exec"] = new_exec_condition
            return set_reg_value(self.node, new_exec_condition.top(), "exec", ["exec", self.ssrc0], None,
                                 exec_condition=new_exec_condition)
        return self.to_fill_node()
