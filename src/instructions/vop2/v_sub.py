from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import is_reg
from src.register_type import RegisterType


def v_sub_fill_node(node, src0, src1, vdst, new_value, suffix):  # noqa: PLR0913
    reg_type = RegisterType.INT32
    if is_reg(src0):
        reg_type = node.state[src0].integrity
    elif is_reg(src1):
        reg_type = node.state[src1].integrity
    return set_reg_value(node, new_value, vdst, [src0, src1], suffix, reg_type=reg_type)


class VSub(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        if self.suffix == "u32":
            self.vcc = self.instruction[2]
            self.src0 = self.instruction[3]
            self.src1 = self.instruction[4]
        else:
            self.src0 = self.instruction[2]
            self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            temp = f"temp{self.decompiler_data.number_of_temp}"
            mask = f"mask{self.decompiler_data.number_of_mask}"
            self.decompiler_data.write(f"ulong {temp} = (ulong){self.src0} - (ulong){self.src1} // {self.name}\n")
            self.decompiler_data.write(f"{self.vdst} = CLAMP ? ({temp}>>32 ? 0 : {temp}) : {temp}\n")
            self.decompiler_data.write(f"{self.vcc} = 0\n")  # vop2, sdst
            self.decompiler_data.write(f"ulong {mask} = (1ULL<<LANEID)\n")
            self.decompiler_data.write(f"{self.vcc} = ({self.vcc}&~{mask}) | (({temp}>>32) ? {mask} : 0)\n")
            self.decompiler_data.number_of_temp += 1
            self.decompiler_data.number_of_mask += 1
            return self.node
        if self.suffix == "f32":
            self.decompiler_data.write(f"{self.vdst} = (float){self.src0} - (float){self.src1} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "u32":
            new_val = make_op(self.node, self.src0, self.src1, "-", "(ulong)", suffix=self.suffix)
            return v_sub_fill_node(self.node, self.src0, self.src1, self.vdst, new_val, self.suffix)
        if self.suffix == "f32":
            new_val = make_op(self.node, self.src0, self.src1, "-", "(float)", "(float)", suffix=self.suffix)
            return v_sub_fill_node(self.node, self.src0, self.src1, self.vdst, new_val, self.suffix)
        return super().to_fill_node()
