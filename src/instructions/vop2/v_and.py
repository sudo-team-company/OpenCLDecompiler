from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import is_reg
from src.register_type import RegisterType


class VAnd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b32':
            self.decompiler_data.write(self.vdst + " = " + self.src0 + " & " + self.src1 + " // v_and_b32\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'b32':
            if is_reg(self.src1):
                if self.node.state.registers[self.src1].type == RegisterType.WORK_DIM and \
                        self.src0 == "0xffff":
                    new_value = self.node.state.registers[self.src1].val
                    reg_type = self.node.state.registers[self.src1].type
                else:
                    new_value = make_op(self.node, self.src1, self.src0[1:], " * ")
                    reg_type = RegisterType.UNKNOWN
                return set_reg_value(
                    node=self.node,
                    new_value=new_value,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1],
                    data_type=self.suffix,
                    reg_type=reg_type,
                    reg_entire=self.node.state.registers[self.src1].integrity
                )
        return super().to_fill_node()
