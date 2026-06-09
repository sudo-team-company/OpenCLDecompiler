from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import make_op, set_reg_save, set_reg_value_save
from src.expression_manager.expression_node import ExpressionNode, ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import Val, get_reg_rang, is_predicate, is_reg
from src.register import Register
from src.register_type import RegisterType


class SAnd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]

    def to_fill_node(self):  # noqa: PLR0912, PLR0915
        if self.suffix in {"b32", "b64"}:
            src0_node = self.get_expression_node(self.src0)
            src1_node = self.get_expression_node(self.src1)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.AND, OpenCLTypes.from_string(self.suffix)
            )

            if any(is_predicate(item) for item in {self.vdst, self.src0, self.src1}):
                if not is_predicate(self.src0):
                    self.src1, self.src0 = self.src0, self.src1
                old_exec_condition = self.decompiler_data.exec_registers[self.src0.name]
                new_cond = self.node.get_from_state(self.src1).val

                new_exec_condition = old_exec_condition & new_cond
                self.decompiler_data.exec_registers[self.vdst.name] = new_exec_condition
                new_exec_cond_node = self.get_expression_node(self.src1)

                return set_reg_value_save(
                    self.node,
                    new_exec_condition.top(),
                    self.vdst,
                    [self.src0, self.src1],
                    "b64",
                    exec_condition=new_exec_condition,
                    expression_node=new_exec_cond_node,
                )
            if self.src0.name in self.node.state and self.src1.name in self.node.state:
                ssrc0 = self.node.get_from_state(self.src0)

                return set_reg_value_save(
                    node=self.node,
                    new_value=make_op(self.node, self.src0, self.src1, "&&", suffix=self.suffix),
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1],
                    data_type=self.suffix,
                    reg_type=ssrc0.type,
                    integrity=ssrc0.integrity,
                    expression_node=expr_node,
                )

            def default_behaviour() -> tuple[object, RegisterType, ExpressionNode]:
                new_value = self.node.get_from_state(self.src1).val
                reg_type = RegisterType.UNKNOWN
                expr_node = self.get_expression_node(self.src1)

                return new_value, reg_type, expr_node

            expr_node = None

            if is_reg(self.src1):
                size_of_work_groups = self.decompiler_data.config_data.size_of_work_groups
                if self.node.get_from_state(self.src1).type == RegisterType.WORK_DIM and self.src0.value == "0xffff":
                    new_value = self.node.get_from_state(self.src1).val
                    reg_type = self.node.get_from_state(self.src1).type
                    expr_node = self.get_expression_node(self.src1)
                elif self.node.get_from_state(self.src1).type == RegisterType.GLOBAL_SIZE_X and size_of_work_groups[
                    0
                ] == -int(self.src0):
                    new_value = make_op(
                        self.node, Val("get_num_groups(0)"), Val(str(size_of_work_groups[0])), "*", suffix=self.suffix
                    )
                    reg_type = RegisterType.UNKNOWN
                    left_node = self.expression_manager.add_register_node(
                        RegisterType.NUM_GROUPS_X, "get_num_groups(0)"
                    )
                    right_node = self.expression_manager.add_const_node(size_of_work_groups[0], OpenCLTypes.UINT)
                    expr_node = self.expression_manager.add_operation(
                        left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT
                    )
                elif self.node.get_from_state(self.src1).type == RegisterType.GLOBAL_SIZE_Y and size_of_work_groups[
                    1
                ] == -int(self.src0):
                    new_value = make_op(
                        self.node, Val("get_num_groups(1)"), Val(str(size_of_work_groups[1])), "*", suffix=self.suffix
                    )
                    reg_type = RegisterType.UNKNOWN
                    left_node = self.expression_manager.add_register_node(
                        RegisterType.NUM_GROUPS_Y, "get_num_groups(1)"
                    )
                    right_node = self.expression_manager.add_const_node(size_of_work_groups[1], OpenCLTypes.UINT)
                    expr_node = self.expression_manager.add_operation(
                        left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT
                    )
                elif self.node.get_from_state(self.src1).type == RegisterType.GLOBAL_SIZE_Z and size_of_work_groups[
                    2
                ] == -int(self.src0):
                    new_value = make_op(
                        self.node, Val("get_num_groups(2)"), Val(str(size_of_work_groups[2])), "*", suffix=self.suffix
                    )
                    reg_type = RegisterType.UNKNOWN
                    left_node = self.expression_manager.add_register_node(
                        RegisterType.NUM_GROUPS_Z, "get_num_groups(2)"
                    )
                    right_node = self.expression_manager.add_const_node(size_of_work_groups[2], OpenCLTypes.UINT)
                    expr_node = self.expression_manager.add_operation(
                        left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT
                    )
                elif (
                    isinstance(self.node.get_from_state(self.src1).register_content, CombinedRegisterContent)
                    and isinstance(self.src0, Val)
                    and self.src0.value.startswith("0x")
                ):
                    maybe_new_reg: Register | None = self.node.get_from_state(self.src1) & self.src0.value
                    if maybe_new_reg is None:
                        new_value, reg_type, expr_node = default_behaviour()
                    else:
                        return set_reg_save(
                            node=self.node,
                            to_reg=self.vdst,
                            from_regs=[self.src0, self.src1],
                            reg=maybe_new_reg,
                        )
                else:
                    new_value, reg_type, expr_node = default_behaviour()
                return set_reg_value_save(
                    node=self.node,
                    new_value=new_value,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1],
                    data_type=self.suffix,
                    reg_type=reg_type,
                    integrity=self.node.get_from_state(self.src1).integrity,
                    expression_node=expr_node,
                )
            if self.src0 in self.node.state:
                reg = self.node.get_from_state(self.src0)
                expr_node = self.get_expression_node(self.src0)
            else:
                src0 = get_reg_rang(self.src0)[0]
                reg = self.node.get_from_state(src0)
                expr_node = self.get_expression_node(src0)
            return set_reg_value_save(
                node=self.node,
                new_value=reg.val,
                to_reg=self.vdst,
                from_regs=[self.src0, self.src1],
                data_type=self.suffix,
                reg_type=reg.type,
                integrity=reg.integrity,
                expression_node=expr_node,
            )
        return super().to_fill_node()
