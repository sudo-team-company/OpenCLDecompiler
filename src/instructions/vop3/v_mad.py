import copy

from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg
from src.integrity import Integrity
from src.register import check_and_split_regs, is_reg, is_range


class VMad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.sdst = self.instruction[2]
        self.src0 = self.instruction[3]
        self.src1 = self.instruction[4]
        self.src2 = self.instruction[5]

        if is_range(self.src0):
            _, self.src0 = check_and_split_regs(self.src0)
        if is_range(self.src1):
            _, self.src1 = check_and_split_regs(self.src1)
        if is_range(self.src2):
            _, self.src2 = check_and_split_regs(self.src2)

        self.vdst_from, self.vdst_to = check_and_split_regs(self.vdst)

    def to_fill_node(self):
        src0 = self.node.state.registers[self.src0] if is_reg(self.src0) else int(self.src0)
        src1 = self.node.state.registers[self.src1] if is_reg(self.src1) else int(self.src1)
        src2 = self.node.state.registers[self.src2] if is_reg(self.src2) else int(self.src2)

        new_reg = src0 * src1
        if src2 != 0:
            new_reg = new_reg + src2

        if self.suffix == "u64_u32":
            new_reg.cast_to("u64")

        low_part_reg = copy.deepcopy(new_reg)
        low_part_reg.integrity = Integrity.LOW_PART
        high_part_reg = copy.deepcopy(new_reg)
        high_part_reg.integrity = Integrity.LOW_PART

        set_reg(
            node=self.node,
            to_reg=self.vdst_from,
            from_regs=[self.src0, self.src1, self.src2],
            reg=low_part_reg,
        )
        set_reg(
            node=self.node,
            to_reg=self.vdst_to,
            from_regs=[self.src0, self.src1, self.src2],
            reg=high_part_reg,
        )

        return self.node
