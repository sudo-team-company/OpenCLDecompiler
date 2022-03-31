from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value, make_op
from src.register import is_reg
from src.register_type import RegisterType

_instruction_internal_mapping_by_types = {
    frozenset({
        RegisterType.__getattr__(f"GLOBAL_OFFSET_{dim}"),
        RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"),
    }): (
        f"get_global_id({i})",
        RegisterType.__getattr__(f"GLOBAL_ID_{dim}"),
    ) for i, dim in enumerate(["X", "Y", "Z"])
}


class VAddLshl(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            self.decompiler_data.write(
                f"{self.vdst} = ({self.src0} + {self.src1}) << {self.src2} // {self.instruction[0]}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            if is_reg(self.src0) and is_reg(self.src1) and self.src2.isdigit():
                src_types = frozenset({
                    self.node.state.registers[self.src0].type,
                    self.node.state.registers[self.src1].type,
                })
                if src_types in _instruction_internal_mapping_by_types:
                    new_value, _ = _instruction_internal_mapping_by_types[src_types]
                    new_value = make_op(self.node, new_value, str(pow(2, int(self.src2))), " * ")
                    return set_reg_value(
                        node=self.node,
                        new_value=new_value,
                        to_reg=self.vdst,
                        from_regs=[self.src0, self.src1, self.src2],
                        data_type=self.suffix,
                    )
        return super().to_fill_node()
