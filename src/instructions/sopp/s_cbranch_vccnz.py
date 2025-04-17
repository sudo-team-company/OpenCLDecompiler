from src.expression_manager.expression_node import expression_to_string
from src.instructions.sopp.s_cbranch import SCbranch


class SCbranchVccnz(SCbranch):
    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write(f"pc = vcc!=0 ?{reladdr} : pc+4 // {self.name}\n")
        return self.node

    def to_print(self):
        self.output_string = self.node.state["vcc"].val
        self.output_string = expression_to_string(self.node.get_expression_node("vcc"))
        return self.output_string
