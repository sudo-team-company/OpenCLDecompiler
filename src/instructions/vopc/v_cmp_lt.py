from src.base_instruction import BaseInstruction
from src.decompiler_data import compare_values
from src.opencl_types import make_opencl_type


class VCmpLt(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

        if suffix != 'f32':
            self.new_as_type = '(' + make_opencl_type(suffix) + ')'
        else:
            self.new_as_type = 'as_float('

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            self.decompiler_data.write(self.sdst + " = (uint)" + self.src0 +
                                       " < (uint)" + self.src1 + " // v_cmp_lt_u32\n")
            return self.node
        if self.suffix == 'f64':
            self.decompiler_data.write(self.sdst + "(LANEID) = as_float(" + self.src0 +
                                       ") < as_float(" + self.src1 + ") // v_cmp_lt_f64\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['f64', 'i32']:
            return compare_values(self.node, self.sdst, self.src0, self.src1, self.new_as_type,
                                  self.new_as_type, " < ", self.suffix)
        return super().to_fill_node()
