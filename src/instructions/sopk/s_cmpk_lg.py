from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values
from src.opencl_types import make_opencl_type


class SCmpkLg(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.src0: str = self.instruction[1]
        self.simm16: str = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in {"u32", "i32"}:
            datatype = f"({make_opencl_type(self.suffix)})"
            self.decompiler_data.write(f"scc = {datatype}{self.src0} != {datatype}{self.simm16} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in {"u32", "i32"}:
            return compare_values(self.node, "scc", self.src0, self.simm16, "!=", self.suffix)
        return super().to_fill_node()
