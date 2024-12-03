from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value, try_get_reg
from src.register_type import RegisterType


class VCndmask(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]
        self.ssrc2 = self.instruction[4]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(
                f"{self.vdst} = {self.ssrc2}&(1ULL<<LANEID) ? {self.src1} : {self.src0} // {self.name}\n"
            )
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32":
            if self.src1 in self.node.state and self.node.state[self.src1].type == RegisterType.DIVISION_PT8:
                new_value = self.node.state[self.src1].val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT9,
                )
            if self.src1 in self.node.state and self.node.state[self.src1].type == RegisterType.DIVISION_PT10:
                new_value = self.node.state[self.src1].val
                return set_reg_value(
                    self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix, reg_type=RegisterType.UNKNOWN
                )
            if self.ssrc2 in self.node.state and self.node.state[self.ssrc2].type == RegisterType.DIVISION_PASS:
                return set_reg_value(
                    self.node, "", self.vdst, [self.src0, self.src1], self.suffix, reg_type=RegisterType.DIVISION_PASS
                )
            if self.ssrc2 in self.node.state and self.node.state[self.ssrc2].val == "0":
                return set_reg_value(self.node, self.src0, self.vdst, [self.src0, self.src1], self.suffix)
            variable = f"var{self.decompiler_data.num_of_var}"
            if (
                self.vdst in self.node.state
                and self.node.state[self.vdst] is not None
                and self.node.state[self.vdst].type == RegisterType.KERNEL_ARGUMENT_ELEMENT
            ):
                variable = f"*{variable}"
            reg_type = RegisterType.PROGRAM_PARAM
            node = set_reg_value(self.node, variable, self.vdst, [self.src0, self.src1], self.suffix, reg_type=reg_type)
            self.decompiler_data.make_var(node.state[self.vdst].version, variable, self.suffix)
            return node
        return super().to_fill_node()

    def to_print(self):
        if self.suffix == "b32":
            vdst = try_get_reg(self.node, self.vdst)
            ssrc2 = try_get_reg(self.node, self.ssrc2)
            if vdst and vdst.type == RegisterType.DIVISION_PT9:
                return ""
            if vdst and vdst.type == RegisterType.DIVISION_PASS:
                return ""
            if ssrc2 and ssrc2.type == RegisterType.DIVISION_PASS:
                return ""
            if vdst and vdst.val == "0":
                return ""
            if "?" in ssrc2.val:
                ssrc2.register_content._value = f"({ssrc2.val})"
            if "s" in self.src1 or "v" in self.src1:
                src1_parent_val = self.node.parent[0].state[self.src1].val
            else:
                src1_parent_val = self.src1
            if "s" in self.src0 or "v" in self.src0:
                src0_parent_val = self.node.parent[0].state[self.src0].val
            else:
                src0_parent_val = self.src0
            self.output_string = f"{vdst.val} = {ssrc2.val} ? {src1_parent_val} : {src0_parent_val}"
            return self.output_string
        return super().to_print()
