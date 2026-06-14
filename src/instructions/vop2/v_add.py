from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value_save
from src.expression_manager.expression_node import (
    ExpressionOperationType,
    ExpressionValueTypeHint,
    TypeAddressSpaceQualifiers,
)
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.ir.registers.reg import Val, get_reg_rang
from src.opencl_types import evaluate_size, make_asm_type, most_common_type
from src.register_content import CONSTANT_VALUES
from src.register_type import RegisterType


def _byte_data_size(data_type):
    if isinstance(data_type, str) and data_type.endswith(" bytes"):
        return int(data_type.split()[0])
    return None


def _combine_byte_data_type(first, second):
    first_size = _byte_data_size(first)
    second_size = _byte_data_size(second)
    if first_size is None and second_size is None:
        return first
    if first_size is None:
        return second
    if second_size is None:
        return first
    return f"{min(first_size, second_size)} bytes"


patterns_get_global_id_x = {
    (RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE_OFFSET, RegisterType.WORK_ITEM_ID_X),
    (RegisterType.GLOBAL_OFFSET_X, RegisterType.WORK_GROUP_ID_X_WORK_ITEM_ID),
}
patterns_get_global_id_y = {
    (RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE_OFFSET, RegisterType.WORK_ITEM_ID_Y),
    (RegisterType.GLOBAL_OFFSET_Y, RegisterType.WORK_GROUP_ID_Y_WORK_ITEM_ID),
}
patterns_get_global_id_z = {
    (RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE_OFFSET, RegisterType.WORK_ITEM_ID_Z),
    (RegisterType.GLOBAL_OFFSET_Z, RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID),
}


patterns_work_item_id_x = {
    (RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE, RegisterType.WORK_ITEM_ID_X),
}
patterns_work_item_id_y = {
    (RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE, RegisterType.WORK_ITEM_ID_Y),
}
patterns_work_item_id_z = {
    (RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE, RegisterType.WORK_ITEM_ID_Z),
}


patterns_work_group_id_x_local_size_offset = {
    (RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE, RegisterType.GLOBAL_OFFSET_X),
}
patterns_work_group_id_y_local_size_offset = {
    (RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE, RegisterType.GLOBAL_OFFSET_Y),
}
patterns_work_group_id_z_local_size_offset = {
    (RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE, RegisterType.GLOBAL_OFFSET_Z),
}


class VAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]

    def to_fill_node(self):  # noqa: C901, PLR0912, PLR0915
        if self.suffix in {"u32", "u64"}:
            new_value = make_op(self.node, self.src0, self.src1, "+", "(ulong)", "(ulong)", suffix=self.suffix)
            src0_reg = not isinstance(self.src0, Val)
            src1_reg = not isinstance(self.src1, Val)
            start_from_src0 = get_reg_rang(self.src0)[0]
            start_from_src1 = get_reg_rang(self.src1)[0]
            data_type = "u32"

            left_node = None
            right_node = None
            expr_node = None
            if src0_reg:
                if self.node.get_from_state(start_from_src0).type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT
                    reg_entire = Integrity.ENTIRE
                    argument = self.node.get_from_state(start_from_src0).val
                    if self.decompiler_data.type_params.get(f"*{argument}"):
                        data_type = make_asm_type(self.decompiler_data.type_params[f"*{argument}"])
                    else:
                        data_type = self.node.get_from_state(start_from_src0).data_type
                    data_size, _ = evaluate_size(data_type, only_size=True)
                    new_value1 = make_op(self.node, self.src1, Val(str(data_size)), "/", suffix=self.suffix)
                    new_value = make_op(self.node, Val(argument), Val(new_value1), "+", suffix=self.suffix)

                    src0_node = self.get_expression_node(start_from_src0)
                    src1_node = self.get_expression_node(self.src1)
                    expr_node = self.expression_manager.add_offset_div_data_size_node(
                        src0_node, src1_node, data_size, OpenCLTypes.from_string(self.suffix)
                    )
                elif self.node.get_from_state(start_from_src0).type == RegisterType.LOCAL_DATA_POINTER:
                    data_type = "u32"
                    reg_type = RegisterType.LOCAL_DATA_POINTER
                    name = self.node.get_from_state(start_from_src0).val
                    reg_entire = Integrity.ENTIRE

                    data_size, _ = evaluate_size(data_type, only_size=True)
                    new_value = make_op(self.node, self.src1, Val(str(data_size)), "/", suffix=self.suffix)
                    new_value = make_op(self.node, Val(name), Val(new_value), "+", suffix=self.suffix)

                    src0_node = self.expression_manager.add_variable_node(
                        name,
                        ExpressionValueTypeHint(
                            OpenCLTypes.from_string(data_type), TypeAddressSpaceQualifiers.LOCAL, is_pointer=True
                        ),
                    )
                    src1_node = self.get_expression_node(self.src1)
                    expr_node = self.expression_manager.add_offset_div_data_size_node(
                        src0_node, src1_node, data_size, OpenCLTypes.from_string(self.suffix)
                    )
                elif self.node.get_from_state(start_from_src0).type == RegisterType.GLOBAL_DATA_POINTER:
                    data_type = self.node.get_from_state(start_from_src1).data_type if src1_reg else data_type
                    name = self.node.get_from_state(start_from_src0).val
                    reg_entire = Integrity.ENTIRE
                    data_size = _byte_data_size(data_type)
                    if data_size is not None:
                        new_value = make_op(self.node, self.src1, Val(str(data_size)), "/", suffix=self.suffix)
                        new_value = make_op(self.node, Val(name), Val(new_value), "+", suffix=self.suffix)
                        reg_type = RegisterType.GLOBAL_DATA_POINTER

                        src0_node = self.expression_manager.add_variable_node(
                            name,
                            ExpressionValueTypeHint(
                                OpenCLTypes.from_string(self.suffix), TypeAddressSpaceQualifiers.CONST, is_pointer=True
                            ),
                        )
                        src1_node = self.get_expression_node(self.src1)
                        expr_node = self.expression_manager.add_offset_div_data_size_node(
                            src0_node, src1_node, data_size, OpenCLTypes.from_string(self.suffix)
                        )

            if expr_node:
                return set_reg_value_save(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    data_type,
                    reg_type=reg_type,
                    integrity=reg_entire,
                    expression_node=expr_node,
                )

            reg_type = RegisterType.UNKNOWN
            reg_entire = Integrity.ENTIRE
            if src0_reg and src1_reg:
                reg_entire = self.node.get_from_state(start_from_src1).integrity
                if self._check_type_pattern(start_from_src0, start_from_src1, patterns_get_global_id_x):
                    new_value = "get_global_id(0)"
                    reg_type = RegisterType.GLOBAL_ID_X
                    expr_node = self.expression_manager.add_register_node(reg_type, new_value)
                elif self._check_type_pattern(start_from_src0, start_from_src1, patterns_get_global_id_y):
                    new_value = "get_global_id(1)"
                    reg_type = RegisterType.GLOBAL_ID_Y
                    expr_node = self.expression_manager.add_register_node(reg_type, new_value)
                elif self._check_type_pattern(start_from_src0, start_from_src1, patterns_get_global_id_z):
                    new_value = "get_global_id(2)"
                    reg_type = RegisterType.GLOBAL_ID_Z
                    expr_node = self.expression_manager.add_register_node(reg_type, new_value)
                elif self._check_type_pattern(start_from_src0, start_from_src1, patterns_work_item_id_x):
                    new_value = "get_global_id(0) - get_global_offset(0)"
                    reg_type = RegisterType.WORK_GROUP_ID_X_WORK_ITEM_ID
                    expr_node = self._add_sub_operation(RegisterType.GLOBAL_ID_X, RegisterType.GLOBAL_OFFSET_X)
                elif self._check_type_pattern(start_from_src0, start_from_src1, patterns_work_item_id_y):
                    new_value = "get_global_id(1) - get_global_offset(1)"
                    reg_type = RegisterType.WORK_GROUP_ID_Y_WORK_ITEM_ID
                    expr_node = self._add_sub_operation(RegisterType.GLOBAL_ID_Y, RegisterType.GLOBAL_OFFSET_Y)
                elif self._check_type_pattern(start_from_src0, start_from_src1, patterns_work_item_id_z):
                    new_value = "get_global_id(2) - get_global_offset(2)"
                    reg_type = RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID
                    expr_node = self._add_sub_operation(RegisterType.GLOBAL_ID_Z, RegisterType.GLOBAL_OFFSET_Z)
                elif self._check_type_pattern(
                    start_from_src0, start_from_src1, patterns_work_group_id_x_local_size_offset
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE_OFFSET
                    left_node = self.get_expression_node(start_from_src0)
                    right_node = self.get_expression_node(start_from_src1)
                elif self._check_type_pattern(
                    start_from_src0, start_from_src1, patterns_work_group_id_y_local_size_offset
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE_OFFSET
                    left_node = self.get_expression_node(start_from_src0)
                    right_node = self.get_expression_node(start_from_src1)
                elif self._check_type_pattern(
                    start_from_src0, start_from_src1, patterns_work_group_id_z_local_size_offset
                ):
                    reg_type = RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE_OFFSET
                    left_node = self.get_expression_node(start_from_src0)
                    right_node = self.get_expression_node(start_from_src1)
                else:
                    data_type = _combine_byte_data_type(
                        self.node.get_from_state(start_from_src0).data_type,
                        self.node.get_from_state(start_from_src1).data_type,
                    )
                    left_node = self.get_expression_node(start_from_src0)
                    right_node = self.get_expression_node(start_from_src1)
            elif src0_reg:
                assert self.src0.name in self.node.state
                left_node = self.get_expression_node(start_from_src0)
                right_node = self.expression_manager.add_const_node(start_from_src1.value, OpenCLTypes.UINT)
            elif src1_reg:
                assert start_from_src1.name in self.node.state
                left_node = self.expression_manager.add_const_node(start_from_src0.value, OpenCLTypes.UINT)
                right_node = self.get_expression_node(start_from_src1)
            else:
                reg_type = RegisterType.INT32
                left_node = self.expression_manager.add_const_node(start_from_src0.value, OpenCLTypes.UINT)
                right_node = self.expression_manager.add_const_node(start_from_src1.value, OpenCLTypes.UINT)

            if not expr_node:
                expr_node = self.expression_manager.add_operation(
                    left_node, right_node, ExpressionOperationType.PLUS, OpenCLTypes.UINT
                )

            return set_reg_value_save(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                data_type,
                reg_type=reg_type,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        if self.suffix == "f64":
            start_from_src0, _ = get_reg_rang(self.src0)
            start_from_src1, _ = get_reg_rang(self.src1)
            data_type = most_common_type(
                self.node.get_from_state(start_from_src0).data_type, self.node.get_from_state(start_from_src1).data_type
            )
            reg_type = self.node.get_from_state(start_from_src1).type

            src0_node = self.get_expression_node(start_from_src0)
            src1_node = self.get_expression_node(start_from_src1)
            expr_node = None

            if self.node.get_from_state(start_from_src1).val == self.node.get_from_state(start_from_src0).val:
                new_value = self.node.get_from_state(start_from_src1).val
                expr_node = src1_node
            else:
                new_value = make_op(
                    self.node, start_from_src0, start_from_src1, "+", "(double)", "(double)", suffix=self.suffix
                )
                expr_node = self.expression_manager.add_operation(
                    src0_node, src1_node, ExpressionOperationType.PLUS, OpenCLTypes.DOUBLE
                )
            return set_reg_value_save(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                data_type,
                reg_type=reg_type,
                expression_node=expr_node,
            )
        return super().to_fill_node()

    def _check_type_pattern(self, src0, src1, patterns: tuple) -> bool:
        type0 = self.node.get_from_state(src0).type
        type1 = self.node.get_from_state(src1).type

        return (type0, type1) in patterns or (type1, type0) in patterns

    def _add_sub_operation(self, reg0: RegisterType, reg1: RegisterType):
        left_node = self.expression_manager.add_register_node(reg0, CONSTANT_VALUES[reg0][0])
        right_node = self.expression_manager.add_register_node(reg1, CONSTANT_VALUES[reg1][0])
        return self.expression_manager.add_operation(
            left_node, right_node, ExpressionOperationType.MINUS, OpenCLTypes.UINT
        )
