from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.integrity import Integrity
from src.register import is_reg
from src.register_type import RegisterType


class VLshlOr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]
        self._instruction_internal_mapping_by_types = {
            (
                RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}"),
                self.decompiler_data.config_data.size_of_work_groups[i],
                RegisterType.__getattr__(f"WORK_ITEM_ID_{dim}"),
            ): (
                f"get_global_id({i}) - get_global_offset({i})",
                RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"),
            ) for i, dim in enumerate(["X", "Y", "Z"])
        }

    def to_fill_node(self):
        if self.suffix == 'b32':
            if is_reg(self.src0) and self.src1.isdigit() and is_reg(self.src2):
                src_types = (
                    self.node.state.registers[self.src0].type,
                    pow(2, int(self.src1)),
                    self.node.state.registers[self.src2].type,
                )
                if src_types in self._instruction_internal_mapping_by_types:
                    new_value, reg_type = self._instruction_internal_mapping_by_types[src_types]
                    return set_reg_value(
                        node=self.node,
                        new_value=new_value,
                        to_reg=self.vdst,
                        from_regs=[self.src0, self.src1, self.src2],
                        data_type=self.suffix,
                        reg_type=reg_type,
                        reg_entire=Integrity.ENTIRE,
                    )
        return super().to_fill_node()
