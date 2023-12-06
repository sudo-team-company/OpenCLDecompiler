from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register import is_reg
from src.register_type import RegisterType
from src.register_value import RegisterValue


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
                op1 = make_op(self.node, self.src0, str(pow(2, int(self.src1))), " // ", '(ulong)', '(ulong)')
                op2 = make_op(self.node, self.src0, str(pow(2, int(self.src1) + int(self.src2))), " // ", "(ulong)",
                              "(ulong)")
                op3 = make_op(self.node, op2, str(pow(2, int(self.src2))), " * ", "(ulong)", "(ulong)")
                new_value = make_op(self.node, op1, op3, " - ", "(ulong)", "(ulong)")
                reg_type = self.node.state.registers[self.src0].type

                return new_value, reg_type

            if is_reg(self.src0) and \
                    (
                            self.node.state.registers[self.src0].type == RegisterType.WORK_ITEM_ID_YX or
                            self.node.state.registers[self.src0].type == RegisterType.WORK_ITEM_ID_ZYX or
                            self.node.state.registers[self.src0].type == RegisterType.WORK_ITEM_ID_UNKNOWN
                    ):
                if self.node.state.registers[self.src0].type == RegisterType.WORK_ITEM_ID_UNKNOWN:
                    self.node.state.registers[self.src0].type = RegisterType.WORK_ITEM_ID_ZYX
                    register_value = RegisterValue(32, [
                        ("get_local_id(0)", RegisterType.WORK_ITEM_ID_X, 9, 0),
                        ("get_local_id(1)", RegisterType.WORK_ITEM_ID_Y, 19, 10),
                        ("get_local_id(2)", RegisterType.WORK_ITEM_ID_Z, 29, 20),
                        (None, RegisterType.UNKNOWN, 31, 30),
                    ])
                    self.node.state.registers[self.src0].val = register_value
                    self.node.state.registers[self.src0].inc_version()

                end = int(self.src1)
                begin = end + int(self.src2) - 1
                maybe_acquired = self.node.state.registers[self.src0].val.maybe_acquire_value(begin, end)

                if maybe_acquired is None:
                    new_value, reg_type = default_behaviour()
                else:
                    new_value, reg_type = maybe_acquired
            else:
                new_value, reg_type = default_behaviour()

            return set_reg_value(
                node=self.node,
                new_value=new_value,
                to_reg=self.vdst,
                from_regs=[self.src0],
                data_type=self.suffix,
                reg_type=reg_type,
            )
        return super().to_fill_node()
