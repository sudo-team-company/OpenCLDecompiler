from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.integrity import Integrity
from src.register import is_reg
from src.register_type import RegisterType


class VLshlOr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]

    def to_fill_node(self):
        if self.suffix == 'b32':
            if is_reg(self.src0) and self.src1.isdigit() and is_reg(self.src2):
                _mapping_for_work_group_id_work_item_id = {
                    frozenset({
                        RegisterType.WORK_GROUP_ID_X,
                        self.decompiler_data.config_data.size_of_work_groups[0],
                        RegisterType.WORK_ITEM_ID_X,
                    }): ("get_global_id(0) - get_global_offset(0)", RegisterType.WORK_GROUP_ID_X_WORK_ITEM_ID),
                    frozenset({
                        RegisterType.WORK_GROUP_ID_Y,
                        self.decompiler_data.config_data.size_of_work_groups[1],
                        RegisterType.WORK_ITEM_ID_Y,
                    }): ("get_global_id(1) - get_global_offset(1)", RegisterType.WORK_GROUP_ID_Y_WORK_ITEM_ID),
                    frozenset({
                        RegisterType.WORK_GROUP_ID_Z,
                        self.decompiler_data.config_data.size_of_work_groups[2],
                        RegisterType.WORK_ITEM_ID_Z,
                    }): ("get_global_id(2) - get_global_offset(2)", RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID),
                }

                src_types = frozenset({
                    self.node.state.registers[self.src0].type,
                    pow(2, int(self.src1)),
                    self.node.state.registers[self.src2].type,
                })

                if src_types in _mapping_for_work_group_id_work_item_id:
                    new_value, reg_type = _mapping_for_work_group_id_work_item_id[src_types]
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
