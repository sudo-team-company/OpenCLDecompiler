from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import is_reg
from src.register_type import RegisterType


class VMulLo(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]

    def to_fill_node(self):
        if self.suffix in {"u16", "u32", "i32"}:
            src0_node = self.get_expression_node(self.src0)
            src1_node = self.get_expression_node(self.src1)
            expr_node = None

            if (
                self.src1.name in self.node.state
                and self.node.get_from_state(self.src1).type == RegisterType.DIVISION_PT3
            ):
                new_value = self.node.get_from_state(self.src1).val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst.name,
                    [self.src0.name, self.src1.name],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT4,
                )
            if (
                self.src1.name in self.node.state
                and self.node.get_from_state(self.src1).type == RegisterType.DIVISION_PT4
            ):
                new_value = self.node.get_from_state(self.src1).val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst.name,
                    [self.src0.name, self.src1.name],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT5,
                )
            if (
                self.src1.name in self.node.state
                and self.node.get_from_state(self.src1).type == RegisterType.DIVISION_PT6
            ):
                new_value = make_op(self.node, self.src0, self.src1, "/", suffix=self.suffix)
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst.name,
                    [self.src0.name, self.src1.name],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT7,
                )
            if (
                self.src0.name in self.node.state
                and self.node.get_from_state(self.src0).type == RegisterType.DIVISION_PT7
            ):
                new_value = ""
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst.name,
                    [self.src0.name, self.src1.name],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PASS,
                )

            src0_node = self.get_expression_node(self.src0)
            src1_node = self.get_expression_node(self.src1)
            expr_node = self.expression_manager.add_operation(
                src0_node, src1_node, ExpressionOperationType.MUL, OpenCLTypes.INT
            )

            reg_entire = self.node.get_from_state(self.src0).integrity
            new_value = make_op(self.node, self.src0, self.src1, "*", suffix=self.suffix)
            src0_reg = is_reg(self.src0)
            src1_reg = is_reg(self.src1)
            reg_type = RegisterType.UNKNOWN
            if src0_reg and src1_reg:
                if (
                    self.node.get_from_state(self.src0).type == RegisterType.LOCAL_SIZE_X
                    and self.node.get_from_state(self.src1).type == RegisterType.WORK_GROUP_ID_X
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
                elif (
                    self.node.get_from_state(self.src0).type == RegisterType.LOCAL_SIZE_Y
                    and self.node.get_from_state(self.src1).type == RegisterType.WORK_GROUP_ID_Y
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
                elif (
                    self.node.get_from_state(self.src0).type == RegisterType.LOCAL_SIZE_Z
                    and self.node.get_from_state(self.src1).type == RegisterType.WORK_GROUP_ID_Z
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE

            return set_reg_value(
                self.node,
                new_value,
                self.vdst.name,
                [self.src0.name, self.src1.name],
                self.suffix,
                reg_type=reg_type,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        return super().to_fill_node()


class VMulHi(VMulLo):
    pass
