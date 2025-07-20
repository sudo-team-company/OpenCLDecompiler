from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import is_sgpr
from src.register_type import RegisterType

_instruction_special_cases = {
    frozenset(
        {
            RegisterType[f"GLOBAL_OFFSET_{dim}"],
            RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"],
        }
    ): RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"]
    for i, dim in enumerate("XYZ")
}


class SAdd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix in {"u32", "i32"}:
            temp = f"temp{self.decompiler_data.number_of_temp}"
            self.decompiler_data.write(f"ulong {temp} = (ulong){self.ssrc0} + (ulong){self.ssrc1} // {self.name}\n")
            self.decompiler_data.write(f"{self.sdst} = {temp}\n")
            self.decompiler_data.write(f"scc = {temp} >> 32\n")
            self.decompiler_data.number_of_temp += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):  # noqa: C901, PLR0912, PLR0915
        if self.suffix in {"u32", "i32"}:
            if self.decompiler_data.is_rdna3 and self.ssrc0 in self.node.state and self.ssrc1 in self.node.state:
                new_reg = self.node.state[self.ssrc0] + self.node.state[self.ssrc1]
                new_reg.cast_to(self.suffix)
                return set_reg(
                    node=self.node,
                    to_reg=self.sdst,
                    from_regs=[self.ssrc0, self.ssrc1],
                    reg=new_reg,
                )

            new_value = make_op(self.node, self.ssrc0, self.ssrc1, "+", "(ulong)", "(ulong)", suffix=self.suffix)

            ssrc0_reg = is_sgpr(self.ssrc0)
            ssrc1_reg = is_sgpr(self.ssrc1)
            data_type = self.suffix

            expr_node = None
            src0_node = self.get_expression_node(self.ssrc0)
            src1_node = self.get_expression_node(self.ssrc1)

            if (
                self.ssrc1.isdigit()
                and ssrc0_reg
                and self.node.state[self.ssrc0].type == RegisterType.ARGUMENTS_POINTER
            ):
                assert self.node.state[self.ssrc0].val.isdigit()
                new_value = f"{int(self.node.state[self.ssrc0].val) + int(self.ssrc1)}"
                reg_type = RegisterType.ARGUMENTS_POINTER
            elif ssrc0_reg and ssrc1_reg:
                ssrc0_type = self.node.state[self.ssrc0].type
                ssrc1_type = self.node.state[self.ssrc1].type
                src_types = frozenset({ssrc0_type, ssrc1_type})
                if src_types in _instruction_special_cases:
                    reg_type = _instruction_special_cases[src_types]
                elif ssrc0_type == RegisterType.GLOBAL_DATA_POINTER:
                    name = self.node.state[self.ssrc0].val
                    reg_type = RegisterType.GLOBAL_DATA_POINTER
                    if self.node.state[self.ssrc1].data_type == "4 bytes":
                        new_value = make_op(self.node, self.ssrc1, "4", "/", suffix=self.suffix)
                        new_value = make_op(self.node, name, new_value, "+", suffix=self.suffix)
                        data_type = "4 bytes"
                    else:
                        new_value = make_op(self.node, self.ssrc1, "8", "/", suffix=self.suffix)
                        new_value = make_op(self.node, name, new_value, "+", suffix=self.suffix)
                        data_type = "8 bytes"

                    data_size = 4 if self.node.state[self.ssrc1].data_type == "4 bytes" else 8
                    expr_node = self.expression_manager.add_offset_div_data_size_node(
                        src0_node, src1_node, data_size, OpenCLTypes.from_string(self.suffix)
                    )
                elif ssrc0_type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                    reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT
                    if self.node.state[self.ssrc0].data_type in {"u32", "i32", "gi32", "gu32"}:
                        new_value = make_op(self.node, self.ssrc1, "4", "/", suffix=self.suffix)
                        new_value = make_op(self.node, self.ssrc0, new_value, "+", suffix=self.suffix)

                        expr_node = self.expression_manager.add_offset_div_data_size_node(
                            src0_node, src1_node, 4, OpenCLTypes.from_string(self.suffix)
                        )
                elif RegisterType.KERNEL_ARGUMENT_VALUE in src_types:
                    reg_type = RegisterType.KERNEL_ARGUMENT_VALUE
                else:
                    reg_type = RegisterType.UNKNOWN
            else:
                reg_type = RegisterType.INT32
                if ssrc0_reg:
                    reg_type = self.node.state[self.ssrc0].type
                if ssrc1_reg:
                    reg_type = self.node.state[self.ssrc1].type
                if self.node.state[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT and self.node.state[
                    self.ssrc0
                ].data_type in {"u32", "i32", "gi32", "gu32"}:
                    new_value = make_op(self.node, self.ssrc1, "4", "/", suffix=self.suffix)
                    new_value = make_op(self.node, self.ssrc0, new_value, "+", suffix=self.suffix)

                    expr_node = self.expression_manager.add_offset_div_data_size_node(
                        src0_node, src1_node, 4, OpenCLTypes.from_string(self.suffix)
                    )
            if self.node.state[self.ssrc0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT:
                if self.ssrc0 == self.sdst:
                    data_type = self.node.parent[0].state[self.ssrc0].data_type
                else:
                    data_type = self.node.state[self.ssrc0].data_type

            if expr_node is None:
                expr_node = self.expression_manager.add_operation(
                    src0_node, src1_node, ExpressionOperationType.PLUS, OpenCLTypes.from_string(self.suffix)
                )

            assert expr_node is not None
            return set_reg_value(
                self.node,
                new_value,
                self.sdst,
                [self.ssrc0, self.ssrc1],
                data_type,
                reg_type=reg_type,
                expression_node=expr_node,
            )
        return super().to_fill_node()
