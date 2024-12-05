from src.base_instruction import BaseInstruction
from src.decompiler_data import check_reg_for_val, set_reg_value


class VFma(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]
        self.src2 = self.instruction[4]

    def to_print_unresolved(self):
        if self.suffix == "f32":
            self.decompiler_data.write(
                f"{self.vdst} = as_double({self.src0}) * as_double({self.src1}) + as_double({self.src2})"
                f" // {self.name}\n"
            )
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "f32":
            self.src0, _ = check_reg_for_val(self.node, self.src0)
            self.src1, _ = check_reg_for_val(self.node, self.src1)
            self.src2, _ = check_reg_for_val(self.node, self.src2)
            new_value = f"fma({self.src0}, {self.src1}, {self.src2})"
            return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1, self.src2], self.suffix)
        return super().to_fill_node()
