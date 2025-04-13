from src.expression_manager.expression_node import ExpressionOperationType
from src.types.opencl_types import OpenCLTypes
from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.operation_register_content import OperationRegisterContent
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
    for i, dim in enumerate(["X", "Y", "Z"])
}


class VAddLshl(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            self.decompiler_data.write(f"{self.vdst} = ({self.src0} + {self.src1}) << {self.src2} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "u32" and is_reg(self.src0) and is_reg(self.src1) and self.src2.isdigit():
            if not isinstance(self.node.state[self.src0].register_content, OperationRegisterContent) and not isinstance(
                self.node.state[self.src1].register_content,
                OperationRegisterContent,
            ):
                src_types = frozenset(
                    {
                        self.node.state[self.src0].type,
                        self.node.state[self.src1].type,
                    }
                )
                if src_types in _instruction_internal_mapping_by_types:
                    new_value, reg_type = _instruction_internal_mapping_by_types[src_types]
                    new_value = make_op(self.node, new_value, str(pow(2, int(self.src2))), "*", suffix=self.suffix)
                    src0_node = self.expression_manager.add_register_node(reg_type, new_value)
                    src1_node = self.expression_manager.add_const_node(pow(2, int(self.src2)), OpenCLTypes.UINT)
                    expr_node = self.expression_manager.add_operation(src0_node, src1_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
                    return set_reg_value(
                        node=self.node,
                        new_value=new_value,
                        to_reg=self.vdst,
                        from_regs=[self.src0, self.src1, self.src2],
                        data_type=self.suffix,
                        expression_node=expr_node
                    )
            else:
                new_reg = self.node.state[self.src0] + self.node.state[self.src1]

                if not isinstance(new_reg.register_content, OperationRegisterContent):
                    new_value = make_op(self.node, new_reg.val, str(pow(2, int(self.src2))), "*", suffix=self.suffix)
                    return set_reg_value(
                        node=self.node,
                        new_value=new_value,
                        to_reg=self.vdst,
                        from_regs=[self.src0, self.src1, self.src2],
                        data_type=self.suffix,
                    )
        return super().to_fill_node()
