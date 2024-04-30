from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import make_op, set_reg_value, set_reg
from src.register import is_reg, Register
from src.register_type import RegisterType


class VLshrrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b64':
            self.decompiler_data.write(self.vdst + " = " + self.src1 + " >> ("
                                       + self.src0 + " & 63) // v_lshrrev_b64\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['b32']:
            if is_reg(self.src1):
                def default_behaviour():
                    new_value = make_op(self.node, self.src1, str(pow(2, int(self.src0))), '//')
                    reg_type = self.node.state.registers[self.src1].type

                    return set_reg_value(
                        self.node,
                        new_value,
                        self.vdst,
                        [self.src0, self.src1],
                        self.suffix,
                        reg_type=reg_type,
                    )

                if isinstance(self.node.state.registers[self.src1].register_content, CombinedRegisterContent):
                    maybe_new_register: Register = self.node.state.registers[self.src1] >> int(self.src0)

                    if maybe_new_register is not None:
                        return set_reg(
                            node=self.node,
                            to_reg=self.vdst,
                            from_regs=[self.src0, self.src1],
                            reg=maybe_new_register,
                        )

                if self.node.state.registers[self.src1].val == '0':
                    new_value = '0'
                    reg_type = RegisterType.INT32
                else:
                    return default_behaviour()

                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=reg_type,
                )

        return super().to_fill_node()
