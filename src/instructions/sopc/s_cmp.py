from ...base_instruction import BaseInstruction
from ...decompiler_data import compare_values
from ...node import Node
from ...opencl_types import make_opencl_type


class SCmp(BaseInstruction):
    def __init__(self, node: Node, suffix: str, op: str):
        super().__init__(node, suffix)
        self.op: str = op

    @property
    def s0(self) -> str:
        return self.instruction[1]

    @property
    def s1(self) -> str:
        return self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in {"i32", "u32", "u64"}:
            datatype = f"({make_opencl_type(self.suffix)})"
            self.decompiler_data.write(f"scc = {datatype}{self.s0} {self.op} {datatype}{self.s1} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in {"i32", "u32", "u64"}:
            return compare_values(self.node, "scc", self.s0, self.s1, self.op, self.suffix)
        return super().to_fill_node()
