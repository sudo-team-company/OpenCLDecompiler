from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values
from src.node import Node
from src.opencl_types import make_opencl_type


class SCmp(BaseInstruction):
    def __init__(self, node: Node, suffix: str, sign: str):
        super().__init__(node, suffix)
        self.sign: str = sign

    @property
    def ssrc0(self) -> str:
        return self.instruction[1]

    @property
    def ssrc1(self) -> str:
        return self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in ['i32', 'u32', 'u64']:
            datatype = f'({make_opencl_type(self.suffix)})'
            self.decompiler_data.write(
                f'scc = {datatype}{self.ssrc0} {self.sign} {datatype}{self.ssrc1} // {self.instruction[0]}\n')
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['i32', 'u32', 'u64']:
            return compare_values(self.node, 'scc', self.ssrc0, self.ssrc1, self.sign, self.suffix)
        return super().to_fill_node()
