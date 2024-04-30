from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values
from src.node import Node
from src.opencl_types import make_opencl_type


class VCmp(BaseInstruction):
    def __init__(self, node: Node, suffix: str, sign: str):
        super().__init__(node, suffix)
        self.sign: str = sign

    @property
    def sdst(self) -> str:
        return self.instruction[1]

    @property
    def src0(self) -> str:
        return self.instruction[2]

    @property
    def src1(self) -> str:
        return self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix in ['i16', 'i32', 'i64', 'u16', 'u32', 'u64', 'f16', 'f32', 'f64']:
            datatype = f'({make_opencl_type(self.suffix)})'
            self.decompiler_data.write(
                f'{self.sdst}[laneId] = {datatype}{self.src0} {self.sign} {datatype}{self.src1} // {self.name}\n')
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['i16', 'i32', 'i64', 'u16', 'u32', 'u64', 'f16', 'f32', 'f64']:
            return compare_values(self.node, self.sdst, self.src0, self.src1, self.sign, self.suffix)
        return super().to_fill_node()
