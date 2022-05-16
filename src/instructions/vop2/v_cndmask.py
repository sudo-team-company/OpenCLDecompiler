from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.register_type import RegisterType


class VCndmask(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]
        self.ssrc2 = self.instruction[4]

    def to_print_unresolved(self):
        if self.suffix == 'b32':
            self.decompiler_data.write(self.vdst + " = " + self.ssrc2 + "&(1ULL<<LANEID) ? "
                                       + self.src1 + " : " + self.src0 + " // v_cndmask_b32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'b32':
            if self.src1 in self.node.state.registers and \
                    self.node.state.registers[self.src1].type == RegisterType.DIVISION_PT8:
                new_value = self.node.state.registers[self.src1].val
                return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix,
                                     reg_type=RegisterType.DIVISION_PT9)
            if self.src1 in self.node.state.registers and \
                    self.node.state.registers[self.src1].type == RegisterType.DIVISION_PT10:
                new_value = self.node.state.registers[self.src1].val
                return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix,
                                     reg_type=RegisterType.UNKNOWN)
            if self.ssrc2 in self.node.state.registers and \
                    self.node.state.registers[self.ssrc2].type == RegisterType.DIVISION_PASS:
                return set_reg_value(self.node, "", self.vdst, [self.src0, self.src1], self.suffix,
                                     reg_type=RegisterType.DIVISION_PASS)
            if self.ssrc2 in self.node.state.registers and self.node.state.registers[self.ssrc2].val == "0":
                return set_reg_value(self.node, self.src0, self.vdst, [self.src0, self.src1], self.suffix)
            variable = "var" + str(self.decompiler_data.num_of_var)
            if self.vdst in self.node.state.registers and \
                    self.node.state.registers[self.vdst] is not None and \
                    self.node.state.registers[self.vdst].type == RegisterType.KERNEL_ARGUMENT_ELEMENT:
                variable = "*" + variable
            reg_type = RegisterType.PROGRAM_PARAM
            node = set_reg_value(self.node, variable, self.vdst, [self.src0, self.src1], self.suffix, reg_type=reg_type)
            self.decompiler_data.make_var(node.state.registers[self.vdst].version, variable, self.suffix)
            return node
        return super().to_fill_node()

    def to_print(self):
        if self.suffix == 'b32':
            if self.node.state.registers[self.vdst].type == RegisterType.DIVISION_PT9:
                return ""
            if self.node.state.registers[self.vdst].type == RegisterType.DIVISION_PASS:
                return ""
            if self.node.state.registers[self.ssrc2].type == RegisterType.DIVISION_PASS:
                return ""
            if self.node.state.registers[self.vdst].val == "0":
                return ""
            if "?" in self.node.state.registers[self.ssrc2].val:
                self.node.state.registers[self.ssrc2].val = "(" + self.node.state.registers[self.ssrc2].val + ")"
            if 's' in self.src1 or 'v' in self.src1:
                src1_parent_val = self.node.parent[0].state.registers[self.src1].val
            else:
                src1_parent_val = self.src1
            if 's' in self.src0 or 'v' in self.src0:
                src0_parent_val = self.node.parent[0].state.registers[self.src0].val
            else:
                src0_parent_val = self.src0
            self.output_string = self.node.state.registers[self.vdst].val + " = " \
                                 + self.node.state.registers[self.ssrc2].val + " ? " \
                                 + src1_parent_val + " : " + src0_parent_val
            return self.output_string
        return super().to_print()
