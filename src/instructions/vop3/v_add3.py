from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value, make_op
from src.register import is_reg
from src.register_type import RegisterType

_instruction_internal_mapping_by_types = {
    **{
        frozenset({
            RegisterType.__getattr__(f"GLOBAL_OFFSET_{dim}"),
            RegisterType.__getattr__(f"WORK_ITEM_ID_{dim}"),
            RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"),
        }): (
            f"get_global_id({i})",
            RegisterType.__getattr__(f"GLOBAL_ID_{dim}"),
        ) for i, dim in enumerate("XYZ")
    },
    **{
        frozenset({
            RegisterType.__getattr__(f"GLOBAL_OFFSET_{dim}"),
            RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"),
        }): (
            f"get_global_id({i})",
            RegisterType.__getattr__(f"GLOBAL_ID_{dim}"),
        ) for i, dim in enumerate("XYZ")
    },
    **{
        frozenset({
            RegisterType.__getattr__(f"WORK_ITEM_ID_{dim}"),
            RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"),
        }): (
            f"get_global_id({i})",
            RegisterType.__getattr__(f"GLOBAL_ID_{dim}"),
        ) for i, dim in enumerate("XYZ")
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
            new_value = make_op(self.node, self.src0, self.src1, " + ", '(ulong)', '(ulong)')
            new_value = make_op(self.node, new_value, self.src2, " + ", '(ulong)', '(ulong)')
            reg_type = RegisterType.UNKNOWN
            reg_permutations_for_sum_mapping = [
                (self.src0, self.src1, self.src2),
                (self.src0, self.src2, self.src1),
                (self.src1, self.src2, self.src0),
            ]
            for src0, src1, src2 in reg_permutations_for_sum_mapping:
                if is_reg(src0) and is_reg(src1):
                    src_types = frozenset({
                        self.node.state.registers[src0].type,
                        self.node.state.registers[src1].type,
                    })
                    if src_types in _instruction_internal_mapping_by_types:
                        new_value, _ = _instruction_internal_mapping_by_types[src_types]
                        new_value = make_op(self.node, new_value, src2, " + ", '(ulong)', '(ulong)')
            if is_reg(self.src0) and is_reg(self.src1) and is_reg(self.src2):
                src_types = frozenset({
                    self.node.state.registers[self.src0].type,
                    self.node.state.registers[self.src1].type,
                    self.node.state.registers[self.src2].type,
                })
                if src_types in _instruction_internal_mapping_by_types:
                    new_value, reg_type = _instruction_internal_mapping_by_types[src_types]
            return set_reg_value(
                node=self.node,
                new_value=new_value,
                to_reg=self.vdst,
                from_regs=[self.src0, self.src1, self.src2],
                data_type=self.suffix,
                reg_type=reg_type,
            )
        return super().to_fill_node()
