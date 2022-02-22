from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.integrity import Integrity
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


class VAddNc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1 = self.instruction[1:4]

    def to_fill_node(self):
        if is_reg(self.src0) and is_reg(self.src1):
            src_types = frozenset({
                self.node.state.registers[self.src0].type,
                self.node.state.registers[self.src1].type,
            })
            if src_types in _instruction_internal_mapping_by_types:
                new_value, reg_type = _instruction_internal_mapping_by_types[src_types]
                return set_reg_value(
                    node=self.node,
                    new_value=new_value,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1],
                    data_type=self.suffix,
                    reg_type=reg_type,
                    reg_entire=Integrity.ENTIRE,
                )
        return super().to_fill_node()
