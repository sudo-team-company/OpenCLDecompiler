from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.ir.registers.reg import Val, get_reg_rang, is_reg
from src.register_type import RegisterType

REG64_LEN = 2


class VLshlrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]

    def to_fill_node(self):  # noqa: PLR0912
        if self.suffix in {"b16", "b32"}:
            if is_reg(self.src1) and self.node.state[self.src1.name].val == "0":
                new_value = "0"
                reg_type = RegisterType.INT32
            else:
                new_value = make_op(
                    self.node, self.src1, Val(str(pow(2, int(self.src0.value)))), "*", suffix=self.suffix
                )
                if self.node.get_from_state(self.src1).type == RegisterType.WORK_GROUP_ID_X:
                    reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
                elif self.node.get_from_state(self.src1).type == RegisterType.WORK_GROUP_ID_Y:
                    reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
                elif self.node.get_from_state(self.src1).type == RegisterType.WORK_GROUP_ID_Z:
                    reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE
                else:
                    reg_type = self.node.get_from_state(self.src1).type

            left_node = self.get_expression_node(self.src1)
            right_node = self.expression_manager.add_const_node(
                pow(2, int(self.src0.value)), OpenCLTypes.from_string(self.suffix)
            )
            expr_node = self.expression_manager.add_operation(
                left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.from_string(self.suffix)
            )

            return set_reg_value(
                self.node,
                new_value,
                self.vdst.name,
                [self.src0.name, self.src1.name],
                self.suffix,
                reg_type=reg_type,
                expression_node=expr_node,
            )
        if self.suffix == "b64":
            dest_regs = get_reg_rang(self.vdst)
            src_regs = get_reg_rang(self.src1)
            start_to_register, end_to_register = dest_regs[0], dest_regs[1]
            start_from_register, end_from_register = (
                (src_regs[0], src_regs[1]) if len(src_regs) == REG64_LEN else (src_regs[0], src_regs[0])
            )

            new_value0 = make_op(
                self.node, start_from_register, Val(str(pow(2, int(self.src0.value)))), "*", suffix=self.suffix
            )
            new_value1 = make_op(
                self.node, end_from_register, Val(str(pow(2, int(self.src0.value)))), "*", suffix=self.suffix
            )
            src1_flag = is_reg(start_from_register)
            src0_flag = is_reg(self.src0)

            reg_entire0 = Integrity.LOW_PART
            reg_entire1 = Integrity.HIGH_PART

            const_node = self.expression_manager.add_const_node(
                pow(2, int(self.src0.value)), OpenCLTypes.from_string(self.suffix)
            )
            start_from_register_node = self.get_expression_node(start_from_register)
            end_from_register_node = self.get_expression_node(end_from_register)
            new_value0_node = self.expression_manager.add_operation(
                start_from_register_node, const_node, ExpressionOperationType.MUL, OpenCLTypes.from_string(self.suffix)
            )
            new_value1_node = self.expression_manager.add_operation(
                end_from_register_node, const_node, ExpressionOperationType.MUL, OpenCLTypes.from_string(self.suffix)
            )

            if src0_flag and src1_flag:
                reg_type = self.node.get_from_state(start_from_register).type
                if not (
                    self.node.get_from_state(start_from_register).type
                    in {RegisterType.GLOBAL_ID_X, RegisterType.GLOBAL_ID_Y, RegisterType.GLOBAL_ID_Z}
                    and self.node.get_from_state(end_from_register).val == "0"
                ):
                    new_value0 = self.node.get_from_state(start_from_register)
                    new_value1 = self.node.get_from_state(end_from_register)
            else:
                reg_type = RegisterType.INT32
                if src0_flag:
                    reg_type = self.node.get_from_state(self.src0).type
                if src1_flag:
                    reg_type = self.node.get_from_state(start_from_register).type
            data_type = self.suffix
            if src0_flag:
                data_type = f"{pow(2, int(self.src1.value))} bytes"
            elif src1_flag:
                data_type = f"{pow(2, int(self.src0.value))} bytes"

            node = set_reg_value(
                self.node,
                new_value0,
                start_to_register.name,
                [start_from_register.name],
                data_type,
                reg_type=reg_type,
                integrity=reg_entire0,
                expression_node=new_value0_node,
            )
            return set_reg_value(
                node,
                new_value1,
                end_to_register.name,
                [end_from_register.name],
                data_type,
                reg_type=reg_type,
                integrity=reg_entire1,
                expression_node=new_value1_node,
            )
        return super().to_fill_node()
