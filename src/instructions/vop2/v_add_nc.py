from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.integrity import Integrity
from src.register import is_reg
from src.register_type import RegisterType

_types_of_sum_for_global_id = {
    frozenset({
        RegisterType.GLOBAL_OFFSET_X,
        RegisterType.WORK_GROUP_ID_X_WORK_ITEM_ID,
    }): ("get_global_id(0)", RegisterType.GLOBAL_ID_X),
    frozenset({
        RegisterType.GLOBAL_OFFSET_Y,
        RegisterType.WORK_GROUP_ID_Y_WORK_ITEM_ID,
    }): ("get_global_id(1)", RegisterType.GLOBAL_ID_Y),
    frozenset({
        RegisterType.GLOBAL_OFFSET_Z,
        RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID,
    }): ("get_global_id(2)", RegisterType.GLOBAL_ID_Z),
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

            if src_types in _types_of_sum_for_global_id:
                new_value, reg_type = _types_of_sum_for_global_id[src_types]
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
