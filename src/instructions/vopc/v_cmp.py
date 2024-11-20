from ...base_instruction import BaseInstruction
from ...decompiler_data import compare_values
from ...node import Node
from ...opencl_types import make_opencl_type


class VCmp(BaseInstruction):
    def __init__(self, node: Node, suffix: str, op: str):
        super().__init__(node, suffix)
        self.op: str = op

    @property
    def d0(self) -> str:
        return self.instruction[1]

    @property
    def s0(self) -> str:
        return self.instruction[2]

    @property
    def s1(self) -> str:
        return self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix in ["i16", "i32", "i64", "u16", "u32", "u64", "f16", "f32", "f64"]:
            datatype = f"({make_opencl_type(self.suffix)})"
            self.decompiler_data.write(
                f"{self.d0}[laneId] = {datatype}{self.s0} {self.op} {datatype}{self.s1} // {self.name}\n"
            )
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ["i16", "i32", "i64", "u16", "u32", "u64", "f16", "f32", "f64"]:
            return compare_values(self.node, self.d0, self.s0, self.s1, self.op, self.suffix)
        return super().to_fill_node()
