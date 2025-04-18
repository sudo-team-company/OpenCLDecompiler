from src.expression_manager.expression_manager import ExpressionManager
from src.instructions.sopp.s_cbranch import SCbranch


class SCbranchScc0(SCbranch):
    def to_print_unresolved(self):
        reladdr = self.instruction[1]
        self.decompiler_data.write(f"pc = scc==0 ?{reladdr} : pc+4 // {self.name}\n")
        return self.node

    def to_print(self):
        self.output_string = self.node.state["scc"].val
        self.output_string = ExpressionManager().expression_to_string(self.node.get_expression_node("scc"))
        return self.output_string
