from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.register import is_reg
from src.register_type import RegisterType

_instruction_internal_mapping_by_types = {
    frozenset(
        {
            RegisterType[f"GLOBAL_OFFSET_{dim}"],
            RegisterType[f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"],
        }
    ): (
        f"get_global_id({i})",
        RegisterType[f"GLOBAL_ID_{dim}"],
    )
    for i, dim in enumerate("XYZ")
}


class VAddNc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1 = self.instruction[1:4]

    def to_print_unresolved(self):
        if self.suffix in {"u16", "u32"}:
            self.decompiler_data.write(f"{self.vdst} = {self.src0} + {self.src1} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in {"u16", "u32"}:
            if self.decompiler_data.is_rdna3:
                try:
                    new_reg = self.node.state[self.src0] + self.node.state[self.src1]
                    return set_reg(
                        node=self.node,
                        to_reg=self.vdst,
                        from_regs=[self.src0, self.src1],
                        reg=new_reg,
                    )
                except Exception:
                    pass

            if self.src1 in self.node.state and self.node.state[self.src1].type == RegisterType.DIVISION_PT5:
                new_value = self.node.state[self.src1].val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT6,
                )
            if self.src1 in self.node.state and self.node.state[self.src1].type == RegisterType.DIVISION_PT7:
                new_value = self.node.state[self.src1].val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT8,
                )
            if self.src1 in self.node.state and self.node.state[self.src1].type == RegisterType.DIVISION_PT9:
                new_value = self.node.state[self.src1].val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT10,
                )
            if (
                is_reg(self.src0)
                and self.node.state[self.src0].type == RegisterType.NUM_GROUPS_X
                and self.node.state[self.src1].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
            ):
                new_value = "get_global_size(0)"
                reg_type = RegisterType.GLOBAL_SIZE_X
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=reg_type,
                )
            if (
                is_reg(self.src0)
                and self.node.state[self.src0].type == RegisterType.NUM_GROUPS_Y
                and self.node.state[self.src1].type == RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
            ):
                new_value = "get_global_size(1)"
                reg_type = RegisterType.GLOBAL_SIZE_Y
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=reg_type,
                )
            if (
                is_reg(self.src0)
                and self.node.state[self.src0].type == RegisterType.NUM_GROUPS_Z
                and self.node.state[self.src1].type == RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE
            ):
                new_value = "get_global_size(2)"
                reg_type = RegisterType.GLOBAL_SIZE_Z
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=reg_type,
                )

            new_value = make_op(self.node, self.src0, self.src1, "+", "(ulong)", "(ulong)", suffix=self.suffix)
            reg_type = RegisterType.UNKNOWN
            if is_reg(self.src0) and is_reg(self.src1):
                src_types = frozenset(
                    {
                        self.node.state[self.src0].type,
                        self.node.state[self.src1].type,
                    }
                )
                if src_types in _instruction_internal_mapping_by_types:
                    new_value, reg_type = _instruction_internal_mapping_by_types[src_types]
                if self.node.state[self.src1].val == "0":
                    new_value = self.node.state[self.src0].val
                    reg_type = self.node.state[self.src0].type
            return set_reg_value(
                node=self.node,
                new_value=new_value,
                to_reg=self.vdst,
                from_regs=[self.src0, self.src1],
                data_type=self.suffix,
                reg_type=reg_type,
            )
        return super().to_fill_node()
