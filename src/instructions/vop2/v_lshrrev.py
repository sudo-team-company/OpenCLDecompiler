from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import is_reg
from src.register_content import EmptyRegisterContent
from src.register_content_combiner import RegisterContentCombiner
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
                    new_value = make_op(self.node, self.src1, str(pow(2, int(self.src0))), " // ")
                    reg_type = self.node.state.registers[self.src1].type

                    return set_reg_value(
                        self.node,
                        new_value,
                        self.vdst,
                        [self.src0, self.src1],
                        self.suffix,
                        reg_type=reg_type,
                    )

                if self.node.state.registers[self.src1].type == RegisterType.COMBINE:
                    maybe_new_combiner: RegisterContentCombiner = self.node.state.registers[self.src1] >> int(self.src0)

                    if maybe_new_combiner.get_count() == 2 and \
                            isinstance(maybe_new_combiner.maybe_get_by_idx(0), EmptyRegisterContent):
                        new_value = make_op(
                            node=self.node,
                            register0=maybe_new_combiner.maybe_get_by_idx(1).content,
                            register1=str(2 ** int(maybe_new_combiner.maybe_get_by_idx(0).size)),
                            operation="*",
                            type0="",
                            type1="",
                        )
                        return set_reg_value(
                            self.node,
                            new_value,
                            self.vdst,
                            [self.src0, self.src1],
                            self.suffix,
                            reg_type=maybe_new_combiner.maybe_get_by_idx(1).type,
                        )

                    if maybe_new_combiner is not None:
                        return set_reg_value(
                            self.node,
                            maybe_new_combiner,
                            self.vdst,
                            [self.src0, self.src1],
                            self.suffix,
                            reg_type=RegisterType.COMBINE,
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
