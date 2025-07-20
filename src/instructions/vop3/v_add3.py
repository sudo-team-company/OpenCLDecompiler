from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import is_reg
from src.register_type import RegisterType

_instruction_internal_mapping_by_types = {
    **{
        frozenset(
            {
                RegisterType[f"GLOBAL_OFFSET_{dim}"],
                RegisterType[f"WORK_ITEM_ID_{dim}"],
                RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"],
            }
        ): (
            f"get_global_id({i})",
            RegisterType[f"GLOBAL_ID_{dim}"],
        )
        for i, dim in enumerate("XYZ")
    },
    **{
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
    },
    **{
        frozenset(
            {
                RegisterType[f"WORK_ITEM_ID_{dim}"],
                RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"],
            }
        ): (
            f"get_global_id({i})",
            RegisterType[f"GLOBAL_ID_{dim}"],
        )
        for i, dim in enumerate("XYZ")
    },
}


class VAdd3(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            temp = f"temp{self.decompiler_data.number_of_temp}"
            mask = f"mask{self.decompiler_data.number_of_mask}"
            self.decompiler_data.write(
                f"uint {temp} = (ulong){self.src0} + (ulong){self.src1} + (ulong){self.src2} // {self.name}\n"
            )
            self.decompiler_data.write(f"{self.vdst} = CLAMP ? min({temp}, 0xffffffff) : {temp}\n")
            self.decompiler_data.write(f"ulong {mask} = (1ULL<<LANEID)\n")
            self.decompiler_data.number_of_temp += 1
            self.decompiler_data.number_of_mask += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "u32":
            if self.decompiler_data.is_rdna3:
                new_reg = self.node.state[self.src0] + self.node.state[self.src1]
                new_reg = new_reg + self.node.state[self.src2]
                new_reg.cast_to(self.suffix)
                return set_reg(
                    node=self.node,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1, self.src2],
                    reg=new_reg,
                )

            new_value = make_op(self.node, self.src0, self.src1, "+", "(ulong)", "(ulong)", suffix=self.suffix)
            new_value = make_op(self.node, new_value, self.src2, "+", "", "(ulong)", suffix=self.suffix)
            reg_type = RegisterType.UNKNOWN
            reg_permutations_for_sum_mapping = [
                (self.src0, self.src1, self.src2),
                (self.src0, self.src2, self.src1),
                (self.src1, self.src2, self.src0),
            ]

            src0_node = self.get_expression_node(self.src0)
            src1_node = self.get_expression_node(self.src1)
            src2_node = self.get_expression_node(self.src2)
            expr_node = None

            for src0, src1, src2 in reg_permutations_for_sum_mapping:
                if is_reg(src0) and is_reg(src1):
                    src_types = frozenset(
                        {
                            self.node.state[src0].type,
                            self.node.state[src1].type,
                        }
                    )
                    if src_types in _instruction_internal_mapping_by_types:
                        new_value, reg_type = _instruction_internal_mapping_by_types[src_types]
                        new_value = make_op(self.node, new_value, src2, "+", "(ulong)", "(ulong)", suffix=self.suffix)

                        sum_node = self.expression_manager.add_register_node(reg_type, "")
                        expr_node = self.expression_manager.add_operation(
                            sum_node,
                            self.get_expression_node(src2),
                            ExpressionOperationType.PLUS,
                            OpenCLTypes.UINT,
                        )
            if is_reg(self.src0) and is_reg(self.src1) and is_reg(self.src2):
                src_types = frozenset(
                    {
                        self.node.state[self.src0].get_type(),
                        self.node.state[self.src1].get_type(),
                        self.node.state[self.src2].get_type(),
                    }
                )
                if src_types in _instruction_internal_mapping_by_types:
                    new_value, reg_type = _instruction_internal_mapping_by_types[src_types]

                    expr_node = self.expression_manager.add_register_node(reg_type, "")

            if expr_node is None:
                sum_node = self.expression_manager.add_operation(
                    src0_node, src1_node, ExpressionOperationType.PLUS, OpenCLTypes.from_string(self.suffix)
                )
                expr_node = self.expression_manager.add_operation(
                    sum_node, src2_node, ExpressionOperationType.PLUS, OpenCLTypes.from_string(self.suffix)
                )

            return set_reg_value(
                node=self.node,
                new_value=new_value,
                to_reg=self.vdst,
                from_regs=[self.src0, self.src1, self.src2],
                data_type=self.suffix,
                reg_type=reg_type,
                expression_node=expr_node,
            )
        return super().to_fill_node()
