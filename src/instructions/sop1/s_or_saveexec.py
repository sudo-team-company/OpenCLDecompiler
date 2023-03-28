from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value


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
            set_reg_value(self.node, "exec", self.sdst, [], None)
            return set_reg_value(self.node, "exec", "exec", [], None)
        return super().to_fill_node()
