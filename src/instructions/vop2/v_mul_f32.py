from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register_type import RegisterType


class VMulF32(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        if "/*" in self.instruction:
            self.src1 = self.instruction[6]
        else:
            self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "f32":
            self.decompiler_data.write(f"{self.vdst} = (float){self.src0} * (float){self.src1} // {self.name}\n")
            return self.node
        if self.suffix in ["i32_i24", "u32_u24"]:
            v0 = "V0" + str(self.decompiler_data.number_of_v0)
            v1 = "V1" + str(self.decompiler_data.number_of_v1)
            self.decompiler_data.write(
                "int "
                + v0
                + " (int)(("
                + self.src0
                + "&0x7fffff) | ("
                + self.src0
                + f"&0x800000 ? 0xff800000 : 0)) // {self.instruction[0]}\n"
            )
            self.decompiler_data.write(
                "int " + v1 + " (int)((" + self.src1 + "&0x7fffff) | (" + self.src1 + "&0x800000 ? 0xff800000 : 0))\n"
            )
            self.decompiler_data.write(self.vdst + " = " + v0 + " * " + v1 + "\n")
            self.decompiler_data.number_of_v0 += 1
            self.decompiler_data.number_of_v1 += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "f32":
            if (
                self.src1 in self.node.state
                and self.node.state[self.src1].type == RegisterType.DIVISION_RECIPROCAL
                and self.src0 == "0x4f7ffffe"
            ):
                new_value = self.node.state[self.src1].val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT2,
                )
            reg_entire = self.node.state[self.src1].integrity
            new_value = make_op(self.node, self.src0, self.src1, "*", "(float)", "(float)", suffix=self.suffix)
            return set_reg_value(
                self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix, integrity=reg_entire
            )
        if self.suffix == "i32_i24":
            reg_entire = self.node.state[self.src1].integrity
            new_value = make_op(self.node, self.src0, self.src1, "*", "(int)", "(int)", suffix=self.suffix)
            return set_reg_value(
                self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix, integrity=reg_entire
            )
        if self.suffix == "u32_u24":
            reg_entire = self.node.state[self.src1].integrity
            new_value = make_op(self.node, self.src0, self.src1, "*", suffix=self.suffix)
            return set_reg_value(
                self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix, integrity=reg_entire
            )
        return super().to_fill_node()
