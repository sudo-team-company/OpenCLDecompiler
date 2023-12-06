from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values
from src.opencl_types import make_opencl_type


class VCmpNe(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

        self.new_as_type = '(' + make_opencl_type(suffix) + ')'

    def to_fill_node(self):
        if self.suffix in ['u16']:
            return compare_values(self.node, self.sdst, self.src0, self.src1, self.new_as_type,
                                  self.new_as_type, " != ", self.suffix)
        return super().to_fill_node()
