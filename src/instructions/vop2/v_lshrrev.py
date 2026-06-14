from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import make_op, set_reg, set_reg_value_save
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import Val, is_range, is_reg
from src.register import Register
from src.register_type import RegisterType


class VLshrrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        if is_range(self.operand[1]):
            self.src0 = self.operand[1].get_element(0)
        self.src1 = self.operand[2]
        if is_range(self.operand[2]):
            self.src1 = self.operand[2].get_element(0)

    def to_fill_node(self):
        if self.suffix in {"b32", "b64"} and (is_reg(self.src1) or is_range(self.src1)):
            assert isinstance(self.src0, Val)

            def default_behaviour():
                new_value = make_op(
                    self.node, self.src1, Val(str(pow(2, int(self.src0.value)))), "//", suffix=self.suffix
                )
                reg_type = self.node.get_from_state(self.src1).type

                src1_node = self.get_expression_node(self.src1)
                const_node = self.expression_manager.add_const_node(pow(2, int(self.src0.value)), OpenCLTypes.UINT)
                expr_node = self.expression_manager.add_operation(
                    src1_node, const_node, ExpressionOperationType.DIV, OpenCLTypes.UINT
                )

                return set_reg_value_save(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=reg_type,
                    expression_node=expr_node,
                )

            if isinstance(self.node.get_from_state(self.src1).register_content, CombinedRegisterContent):
                maybe_new_register: Register = self.node.get_from_state(self.src1) >> int(self.src0.value)

                if maybe_new_register is not None:
                    return set_reg(
                        node=self.node,
                        to_reg=self.vdst.name,
                        from_regs=[self.src0.name, self.src1.name],
                        reg=maybe_new_register,
                    )
            reg_type = self.node.get_from_state(self.src1).type
            expr_node = None

            if self.node.get_from_state(self.src1).val == "0":
                new_value = "0"
                reg_type = RegisterType.INT32
                expr_node = self.expression_manager.add_const_node(0, OpenCLTypes.UINT)
            elif (
                self.node.get_from_state(self.src1).type == RegisterType.GLOBAL_SIZE_X
                and pow(2, int(self.src0.value)) == self.decompiler_data.config_data.size_of_work_groups[0]
            ):
                new_value = "get_num_groups(0)"
                expr_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_X, "get_num_groups(0)")
            elif (
                self.node.get_from_state(self.src1).type == RegisterType.GLOBAL_SIZE_Y
                and pow(2, int(self.src0.value)) == self.decompiler_data.config_data.size_of_work_groups[1]
            ):
                new_value = "get_num_groups(1)"
                expr_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_Y, "get_num_groups(1)")
            elif (
                self.node.get_from_state(self.src1).type == RegisterType.GLOBAL_SIZE_Z
                and pow(2, int(self.src0.value)) == self.decompiler_data.config_data.size_of_work_groups[2]
            ):
                new_value = "get_num_groups(2)"
                expr_node = self.expression_manager.add_register_node(RegisterType.NUM_GROUPS_Z, "get_num_groups(2)")
            else:
                return default_behaviour()

            return set_reg_value_save(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                self.suffix,
                reg_type=reg_type,
                expression_node=expr_node,
            )

        return super().to_fill_node()
