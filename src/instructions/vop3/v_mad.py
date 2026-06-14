import copy

from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_save
from src.integrity import Integrity
from src.ir.registers.reg import get_reg_rang, is_range, is_reg


class VMad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.sdst = self.operand[1]
        self.src0 = self.operand[2]
        self.src1 = self.operand[3]
        self.src2 = self.operand[4]

        if is_range(self.src0):
            _, self.src0 = get_reg_rang(self.src0)
        if is_range(self.src1):
            _, self.src1 = get_reg_rang(self.src1)
        if is_range(self.src2):
            _, self.src2 = get_reg_rang(self.src2)

        self.vdst_from, self.vdst_to = get_reg_rang(self.vdst)

    def to_fill_node(self):
        src0 = self.node.get_from_state(self.src0) if is_reg(self.src0) else int(self.src0.value)
        src1 = self.node.get_from_state(self.src1) if is_reg(self.src1) else int(self.src1.value)
        src2 = self.node.get_from_state(self.src2) if is_reg(self.src2) else int(self.src2.value)

        new_reg = src0 * src1
        if src2 != 0:
            new_reg = new_reg + src2

        if self.suffix == "u64_u32":
            new_reg.cast_to("u64")
        else:
            new_reg.cast_to("i64")

        low_part_reg = copy.deepcopy(new_reg)
        low_part_reg.integrity = Integrity.LOW_PART
        high_part_reg = copy.deepcopy(new_reg)
        high_part_reg.integrity = Integrity.LOW_PART

        set_reg_save(
            node=self.node,
            to_reg=self.vdst_from,
            from_regs=[self.src0, self.src1, self.src2],
            reg=low_part_reg,
        )
        set_reg_save(
            node=self.node,
            to_reg=self.vdst_to,
            from_regs=[self.src0, self.src1, self.src2],
            reg=high_part_reg,
        )

        return self.node
