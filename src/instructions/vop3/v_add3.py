from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.integrity import Integrity
from src.register import is_reg
from src.register_type import RegisterType

_types_of_sum_for_global_id = {
    frozenset({
        RegisterType.GLOBAL_OFFSET_X,
        RegisterType.WORK_ITEM_ID_X,
        RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE,
    }): ("get_global_id(0)", RegisterType.GLOBAL_ID_X),
    frozenset({
        RegisterType.GLOBAL_OFFSET_Y,
        RegisterType.WORK_ITEM_ID_Y,
        RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE,
    }): ("get_global_id(1)", RegisterType.GLOBAL_ID_Y),
    frozenset({
        RegisterType.GLOBAL_OFFSET_Z,
        RegisterType.WORK_ITEM_ID_Z,
        RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE,
    }): ("get_global_id(2)", RegisterType.GLOBAL_ID_Z),
}


class VAdd3(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]

    def to_print_unresolved(self):
        if self.suffix == 'u32':
            temp = "temp" + str(self.decompiler_data.number_of_temp)
            mask = "mask" + str(self.decompiler_data.number_of_mask)
            self.decompiler_data.write("uint " + temp + " = (ulong)" + self.src0 +
                                       " + (ulong)" + self.src1 +
                                       " + (ulong)" + self.src2 + " // v_add3_u32\n")
            self.decompiler_data.write(self.vdst + " = CLAMP ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
            self.decompiler_data.write("ulong " + mask + " = (1ULL<<LANEID)\n")
            self.decompiler_data.number_of_temp += 1
            self.decompiler_data.number_of_mask += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'u32':
            if is_reg(self.src0) and is_reg(self.src1) and is_reg(self.src2):
                src_types = frozenset({
                    self.node.state.registers[self.src0].type,
                    self.node.state.registers[self.src1].type,
                    self.node.state.registers[self.src2].type,
                })

                if src_types in _types_of_sum_for_global_id:
                    new_value, reg_type = _types_of_sum_for_global_id[src_types]
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
