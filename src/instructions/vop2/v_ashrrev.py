from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.integrity import Integrity
from src.register import check_and_split_regs


class VAshrrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "i32":
            self.decompiler_data.write(f"{self.vdst} = (int){self.src1} >> ({self.src0}&31) // {self.name}\n")
            return self.node
        if self.suffix == "i64":
            self.decompiler_data.write(f"{self.vdst} = (long){self.src1} >> ({self.src0}&63) // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "i32":
            new_value = self.node.state[self.src1].val
            reg_type = self.node.state[self.src1].type
            expr_node = self.node.get_expression_node(self.src1)
            return set_reg_value(
                self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix, reg_type=reg_type, expression_node=expr_node
            )
        if self.suffix == "i64":
            start_to_register, end_to_register = check_and_split_regs(self.vdst)
            start_from_register, end_from_register = check_and_split_regs(self.src1)
            if self.node.state[start_from_register].val == "0":
                self.node.state[start_from_register].register_content._value = self.node.state[end_from_register].val  # noqa: SLF001
            new_value = make_op(
                self.node, start_from_register, str(pow(2, 32 - int(self.src0))), "*", "", "(long)", suffix=self.suffix
            )
            reg_type = self.node.state[start_from_register].type
            node = set_reg_value(
                self.node,
                new_value,
                start_to_register,
                [start_from_register],
                self.suffix,
                reg_type=reg_type,
                integrity=Integrity.LOW_PART,
            )
            return set_reg_value(
                node,
                new_value,
                end_to_register,
                [end_from_register],
                self.suffix,
                reg_type=reg_type,
                integrity=Integrity.HIGH_PART,
            )
        return super().to_fill_node()
