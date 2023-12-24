from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import is_reg
from src.register_content_combiner import RegisterContentCombiner
from src.register_type import RegisterType


class VBfe(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]
        self.src2 = self.instruction[4]

    def to_fill_node(self):
        if self.suffix in ["u32"]:
            def default_behaviour() -> (any, RegisterType):
                op1 = make_op(self.node, self.src0, str(pow(2, int(self.src1))), " / ", '(ulong)', '(ulong)')
                op2 = make_op(self.node, self.src0, str(pow(2, int(self.src1) + int(self.src2))), " / ", "(ulong)",
                              "(ulong)")
                op3 = make_op(self.node, op2, str(pow(2, int(self.src2))), " * ", "(ulong)", "(ulong)")
                new_value = make_op(self.node, op1, op3, " - ", "(ulong)", "(ulong)")
                reg_type = self.node.state.registers[self.src0].type

                return set_reg_value(
                    node=self.node,
                    new_value=new_value,
                    to_reg=self.vdst,
                    from_regs=[self.src0],
                    data_type=self.suffix,
                    reg_type=reg_type,
                )

            if self.node.state.registers[self.src0].type == RegisterType.COMBINE:
                maybe_shift_register_content_combiner: RegisterContentCombiner = self.node.state.registers[self.src0] \
                                                                                 >> int(self.src1)

                if maybe_shift_register_content_combiner is not None:
                    maybe_and_register_content = maybe_shift_register_content_combiner & hex((1 << int(self.src2)) - 1)

                    if maybe_and_register_content is not None:
                        new_value = maybe_and_register_content.content
                        reg_type = maybe_and_register_content.type
                    else:
                        return default_behaviour()
                else:
                    return default_behaviour()
            else:
                return default_behaviour()

            return set_reg_value(
                node=self.node,
                new_value=new_value,
                to_reg=self.vdst,
                from_regs=[self.src0],
                data_type=self.suffix,
                reg_type=reg_type,
            )
        return super().to_fill_node()
