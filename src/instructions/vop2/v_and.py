from src.expression_manager.expression_node import ExpressionNode, ExpressionOperationType
from src.types.opencl_types import OpenCLTypes
from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.register import Register, is_reg
from src.register_type import RegisterType


class VAnd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(f"{self.vdst} = {self.src0} & {self.src1} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32" and is_reg(self.src1):

            def default_behaviour() -> tuple[object, RegisterType, ExpressionNode]:
                new_value = self.node.state[self.src1].val
                reg_type = RegisterType.UNKNOWN
                expr_node = self.node.get_expression_node(self.src1)

                return new_value, reg_type, expr_node

            expr_node = None

            size_of_work_groups = self.decompiler_data.config_data.size_of_work_groups
            if self.node.state[self.src1].type == RegisterType.WORK_DIM and self.src0 == "0xffff":
                new_value = self.node.state[self.src1].val
                reg_type = self.node.state[self.src1].type
                expr_node = self.node.get_expression_node(self.src1)
            elif self.node.state[self.src1].type == RegisterType.GLOBAL_SIZE_X and size_of_work_groups[0] == -int(
                self.src0
            ):
                new_value = make_op(
                    self.node, "get_num_groups(0)", str(size_of_work_groups[0]), "*", suffix=self.suffix
                )
                reg_type = RegisterType.UNKNOWN
                left_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_X, "get_num_groups(0)")
                right_node = self.expression_manager.add_const_node(size_of_work_groups[0], OpenCLTypes.UINT)
                expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
            elif self.node.state[self.src1].type == RegisterType.GLOBAL_SIZE_Y and size_of_work_groups[1] == -int(
                self.src0
            ):
                new_value = make_op(
                    self.node, "get_num_groups(1)", str(size_of_work_groups[1]), "*", suffix=self.suffix
                )
                reg_type = RegisterType.UNKNOWN
                left_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_Y, "get_num_groups(1)")
                right_node = self.expression_manager.add_const_node(size_of_work_groups[1], OpenCLTypes.UINT)
                expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
            elif self.node.state[self.src1].type == RegisterType.GLOBAL_SIZE_Z and size_of_work_groups[2] == -int(
                self.src0
            ):
                new_value = make_op(
                    self.node, "get_num_groups(2)", str(size_of_work_groups[2]), "*", suffix=self.suffix
                )
                reg_type = RegisterType.UNKNOWN
                left_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_Z, "get_num_groups(2)")
                right_node = self.expression_manager.add_const_node(size_of_work_groups[2], OpenCLTypes.UINT)
                expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
            elif (
                isinstance(self.node.state[self.src1].register_content, CombinedRegisterContent)
                and isinstance(self.src0, str)
                and self.src0.startswith("0x")
            ):
                maybe_new_reg: Register | None = self.node.state[self.src1] & self.src0
                if maybe_new_reg is None:
                    new_value, reg_type, expr_node = default_behaviour()
                else:
                    return set_reg(
                        node=self.node,
                        to_reg=self.vdst,
                        from_regs=[self.src0, self.src1],
                        reg=maybe_new_reg,
                    )

            else:
                new_value, reg_type, expr_node = default_behaviour()
            return set_reg_value(
                node=self.node,
                new_value=new_value,
                to_reg=self.vdst,
                from_regs=[self.src0, self.src1],
                data_type=self.suffix,
                reg_type=reg_type,
                integrity=self.node.state[self.src1].integrity,
                expression_node=expr_node
            )
        return super().to_fill_node()
