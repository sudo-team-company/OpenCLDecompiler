from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_manager import VariableAddressSpaceQualifiers
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.opencl_types import evaluate_size, make_asm_type, most_common_type
from src.operation_register_content import OperationRegisterContent, OperationType
from src.register import check_and_split_regs, is_reg
from src.register_content import CONSTANT_VALUES
from src.register_type import RegisterType


class VAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        if suffix == "u32":
            self.sdst = self.instruction[2]
            self.src0 = self.instruction[3]
            self.src1 = self.instruction[4]
        else:
            self.src0 = self.instruction[2]
            self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            temp = f"temp{self.decompiler_data.number_of_temp}"
            mask = f"mask{self.decompiler_data.number_of_mask}"
            self.decompiler_data.write(f"uint {temp} = (ulong){self.src0} + (ulong){self.src1} // {self.name}\n")
            self.decompiler_data.write(f"{self.vdst} = CLAMP ? min({temp}, 0xffffffff) : {temp}\n")
            self.decompiler_data.write(f"{self.sdst} = 0\n")
            self.decompiler_data.write(f"ulong {mask} = (1ULL<<LANEID)\n")
            self.decompiler_data.write(f"{self.sdst} = ({self.sdst}&~{mask}) | (({temp} >> 32) ? {mask} : 0)\n")
            self.decompiler_data.number_of_temp += 1
            self.decompiler_data.number_of_mask += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):  # noqa: C901, PLR0912, PLR0915
        if self.suffix == "u32":
            if self.decompiler_data.is_rdna3:
                if self.node.state[
                    self.src0
                ].type == RegisterType.ADDRESS_KERNEL_ARGUMENT and self.decompiler_data.type_params.get(
                    f"*{self.node.state[self.src0].val}"
                ):
                    reg_type = self.node.state[self.src1].type
                    data_type = self.node.state[self.src0].data_type
                    data_size, _ = evaluate_size(data_type, only_size=True)
                    new_value = make_op(self.node, self.src1, str(data_size), "/", suffix=self.suffix)

                    expr_node = self.expression_manager.add_offset_div_data_size(
                        self.node.get_expression_node(self.src0),
                        self.node.get_expression_node(self.src1),
                        data_size,
                        OpenCLTypes.from_string(self.suffix))

                    return set_reg_value(
                        self.node,
                        [
                            self.node.state[self.src0].val,
                            new_value,
                        ],
                        self.vdst,
                        [self.src0, self.src1],
                        self.suffix,
                        reg_type=[
                            self.node.state[self.src0].type,
                            self.node.state[self.src1].type,
                        ],
                        integrity=Integrity.ENTIRE,
                        register_content_type=OperationRegisterContent,
                        operation=OperationType.PLUS,
                        expression_node=expr_node
                    )

                new_reg = self.node.state[self.src0] + self.node.state[self.src1]
                new_reg.cast_to(self.suffix)
                return set_reg(
                    node=self.node,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1],
                    reg=new_reg,
                )

            new_value = make_op(self.node, self.src0, self.src1, "+", "(ulong)", "(ulong)", suffix=self.suffix)
            src0_reg = is_reg(self.src0)
            src1_reg = is_reg(self.src1)
            data_type = self.suffix

            left_node = None
            right_node = None
            expr_node = None
            if src0_reg and src1_reg:
                assert(self.src0 in self.node.state and self.src1 in self.node.state)
                left_node = self.node.get_expression_node(self.src0)
                right_node = self.node.get_expression_node(self.src1)
            elif src0_reg:
                assert(self.src0 in self.node.state)
                left_node = self.node.get_expression_node(self.src0)
                right_node = self.expression_manager.add_const_node(self.src1, OpenCLTypes.UINT) #todo: optimize type here? or inside func
            elif src1_reg:
                assert(self.src1 in self.node.state)
                left_node = self.expression_manager.add_const_node(self.src0, OpenCLTypes.UINT)
                right_node = self.node.get_expression_node(self.src1)
            else:
                left_node = self.expression_manager.add_const_node(self.src0, OpenCLTypes.UINT)
                right_node = self.expression_manager.add_const_node(self.src1, OpenCLTypes.UINT)

            expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.PLUS, OpenCLTypes.UINT)

            reg_type = RegisterType.UNKNOWN
            reg_entire = Integrity.ENTIRE
            if src0_reg and src1_reg:
                #todo - all this could be hidden inside tree?
                reg_entire = self.node.state[self.src1].integrity
                if (
                    self.node.state[self.src0].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE_OFFSET
                    and self.node.state[self.src1].type == RegisterType.WORK_ITEM_ID_X
                ) or (
                    self.node.state[self.src0].type == RegisterType.GLOBAL_OFFSET_X
                    and self.node.state[self.src1].type == RegisterType.WORK_GROUP_ID_X_WORK_ITEM_ID
                ):
                    new_value = "get_global_id(0)"
                    reg_type = RegisterType.GLOBAL_ID_X

                    expr_node = self.expression_manager.add_register_node(reg_type, new_value)
                elif (
                    self.node.state[self.src0].type == RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE_OFFSET
                    and self.node.state[self.src1].type == RegisterType.WORK_ITEM_ID_Y
                ) or (
                    self.node.state[self.src0].type == RegisterType.GLOBAL_OFFSET_Y
                    and self.node.state[self.src1].type == RegisterType.WORK_GROUP_ID_Y_WORK_ITEM_ID
                ):
                    new_value = "get_global_id(1)"
                    reg_type = RegisterType.GLOBAL_ID_Y

                    expr_node = self.expression_manager.add_register_node(reg_type, new_value)
                elif (
                    (
                        self.node.state[self.src0].type == RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE_OFFSET
                        and self.node.state[self.src1].type == RegisterType.WORK_ITEM_ID_Z
                    )
                    or (
                        self.node.state[self.src0].type == RegisterType.GLOBAL_OFFSET_Z
                        and self.node.state[self.src1].type == RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID
                    )
                    or (
                        self.node.state[self.src1].type == RegisterType.GLOBAL_OFFSET_Z
                        and self.node.state[self.src0].type == RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID
                    )
                ):
                    new_value = "get_global_id(2)"
                    reg_type = RegisterType.GLOBAL_ID_Z

                    expr_node = self.expression_manager.add_register_node(reg_type, new_value)

                elif self.node.state[self.src0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT
                    argument = self.node.state[self.src0].val
                    if self.decompiler_data.type_params.get(f"*{argument}"):
                        data_type = make_asm_type(self.decompiler_data.type_params[f"*{argument}"])
                    else:
                        data_type = self.node.state[self.src0].data_type
                    data_size, _ = evaluate_size(data_type, only_size=True)
                    new_value1 = make_op(self.node, self.src1, str(data_size), "/", suffix=self.suffix)
                    new_value = make_op(self.node, argument, new_value1, "+", suffix=self.suffix)

                    src0_node = self.node.get_expression_node(self.src0)
                    src1_node = self.node.get_expression_node(self.src1)
                    expr_node = self.expression_manager.add_offset_div_data_size(
                        src0_node, src1_node, data_size, OpenCLTypes.from_string(self.suffix))
                elif self.node.state[self.src0].type == RegisterType.GLOBAL_DATA_POINTER:
                    data_type = self.node.state[self.src1].data_type
                    name = self.node.state[self.src0].val
                    reg_entire = Integrity.ENTIRE
                    if "bytes" in data_type:
                        position = data_type.find(" ")
                        value = data_type[:position]
                        new_value = make_op(self.node, self.src1, value, "/", suffix=self.suffix)
                        new_value = make_op(self.node, name, new_value, "+", suffix=self.suffix)
                        reg_type = RegisterType.GLOBAL_DATA_POINTER

                        src0_node = self.expression_manager.add_variable_node(f"*{name}",
                                                                              OpenCLTypes.UINT,
                                                                              VariableAddressSpaceQualifiers.GLOBAL)
                        src1_node = self.node.get_expression_node(self.src1)
                        expr_node = self.expression_manager.add_offset_div_data_size(
                            src0_node, src1_node, value, OpenCLTypes.from_string(self.suffix))
                elif (
                    self.node.state[self.src0].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
                    and self.node.state[self.src1].type == RegisterType.WORK_ITEM_ID_X
                ):
                    new_value = "get_global_id(0) - get_global_offset(0)"
                    reg_type = RegisterType.WORK_GROUP_ID_X_WORK_ITEM_ID

                    left_node = self.expression_manager.add_register_node(RegisterType.GLOBAL_ID_X, CONSTANT_VALUES[RegisterType.GLOBAL_ID_X][0])
                    right_node = self.expression_manager.add_register_node(RegisterType.GLOBAL_OFFSET_X, CONSTANT_VALUES[RegisterType.GLOBAL_OFFSET_X][0])
                    expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.MINUS, OpenCLTypes.UINT)
                elif (
                    self.node.state[self.src0].type == RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE
                    and self.node.state[self.src1].type == RegisterType.WORK_ITEM_ID_Y
                ):
                    new_value = "get_global_id(1) - get_global_offset(1)"
                    reg_type = RegisterType.WORK_GROUP_ID_Y_WORK_ITEM_ID

                    left_node = self.expression_manager.add_register_node(RegisterType.GLOBAL_ID_Y, CONSTANT_VALUES[RegisterType.GLOBAL_ID_Y][0])
                    right_node = self.expression_manager.add_register_node(RegisterType.GLOBAL_OFFSET_Y, CONSTANT_VALUES[RegisterType.GLOBAL_OFFSET_Y][0])
                    expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.MINUS, OpenCLTypes.UINT)
                elif (
                    self.node.state[self.src0].type == RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE
                    and self.node.state[self.src1].type == RegisterType.WORK_ITEM_ID_Z
                ):
                    new_value = "get_global_id(2) - get_global_offset(2)"
                    reg_type = RegisterType.WORK_GROUP_ID_Z_WORK_ITEM_ID

                    left_node = self.expression_manager.add_register_node(RegisterType.GLOBAL_ID_Z, CONSTANT_VALUES[RegisterType.GLOBAL_ID_Z][0])
                    right_node = self.expression_manager.add_register_node(RegisterType.GLOBAL_OFFSET_Z, CONSTANT_VALUES[RegisterType.GLOBAL_OFFSET_Z][0])
                    expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.MINUS, OpenCLTypes.UINT)
                elif (
                    self.node.state[self.src0].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
                    and self.node.state[self.src1].type == RegisterType.WORK_ITEM_ID_X
                ) or (
                    self.node.state[self.src1].type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE
                    and self.node.state[self.src0].type == RegisterType.WORK_ITEM_ID_X
                ):
                    new_value = "get_global_id(0) - get_global_offset(0)"
                else:
                    data_type = self.node.state[self.src1].data_type
            else:
                reg_type = RegisterType.INT32
                if src0_reg:
                    reg_type = self.node.state[self.src0].type
                    if self.node.state[self.src0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT:
                        reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT
                        data_type = self.node.state[self.src0].data_type
                        data_size, _ = evaluate_size(data_type, only_size=True)
                        new_value = make_op(self.node, self.src1, str(data_size), "/", suffix=self.suffix)
                        new_value = make_op(self.node, self.src0, new_value, "+", suffix=self.suffix)

                        src0_node = self.node.get_expression_node(self.src0)
                        src1_node = self.node.get_expression_node(self.src1)
                        expr_node = self.expression_manager.add_offset_div_data_size(
                            src0_node, src1_node, data_size, OpenCLTypes.from_string(self.suffix))
                if src1_reg:
                    reg_type = self.node.state[self.src1].type

            print("v_add::to_fill_node", "to_reg:", self.vdst, "new_value:", new_value)
            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                data_type,
                reg_type=reg_type,
                integrity=reg_entire,
                expression_node=expr_node
            )
        if self.suffix == "f64":
            # TODO: Сделать честное присвоение в пару
            start_from_src0, _ = check_and_split_regs(self.src0)
            start_from_src1, _ = check_and_split_regs(self.src1)
            start_to_register, _ = check_and_split_regs(self.vdst)
            data_type = most_common_type(
                self.node.state[start_from_src0].data_type, self.node.state[start_from_src1].data_type
            )
            reg_type = self.node.state[start_from_src1].type

            src0_node = self.node.get_expression_node(start_from_src0)
            src1_node = self.node.get_expression_node(start_from_src1)
            expr_node = None

            if self.node.state[start_from_src1].val == self.node.state[start_from_src0].val:
                new_value = self.node.state[start_from_src1].val
                expr_node = src1_node
            else:
                new_value = make_op(
                    self.node, start_from_src0, start_from_src1, "+", "(double)", "(double)", suffix=self.suffix
                )
                expr_node = self.expression_manager.add_operation(src0_node, src1_node, ExpressionOperationType.PLUS, OpenCLTypes.DOUBLE)
            return set_reg_value(
                self.node,
                new_value,
                start_to_register,
                [start_from_src0, start_from_src1],
                data_type,
                reg_type=reg_type,
                expression_node=expr_node
            )
        return super().to_fill_node()
