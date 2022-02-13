from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.integrity import Integrity
from src.register import is_reg
from src.register_type import RegisterType

_types_of_sum_for_global_id = {
    RegisterType.GLOBAL_ID_X: {
        RegisterType.GLOBAL_OFFSET_X,
        RegisterType.WORK_ITEM_ID_X,
        RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE,
    },
    RegisterType.GLOBAL_ID_Y: {
        RegisterType.GLOBAL_OFFSET_Y,
        RegisterType.WORK_ITEM_ID_Y,
        RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE,
    },
    RegisterType.GLOBAL_ID_Z: {
        RegisterType.GLOBAL_OFFSET_Z,
        RegisterType.WORK_ITEM_ID_Z,
        RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE,
    },
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
            src0_reg = is_reg(self.src0)
            src1_reg = is_reg(self.src1)
            src2_reg = is_reg(self.src2)
            if src0_reg and src1_reg and src2_reg:
                src_types = {
                    self.node.state.registers[self.src0].type,
                    self.node.state.registers[self.src1].type,
                    self.node.state.registers[self.src2].type,
                }
                data_type = self.suffix
                reg_entire = Integrity.ENTIRE

                for i, reg_type in enumerate(_types_of_sum_for_global_id):
                    if src_types == _types_of_sum_for_global_id[reg_type]:
                        return set_reg_value(self.node, f"get_global_id({i})", self.vdst,
                                             [self.src0, self.src1], data_type,
                                             reg_type=reg_type,
                                             reg_entire=reg_entire)

        return super().to_fill_node()
