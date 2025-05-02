from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.register import is_reg
from src.register_type import RegisterType


class VAddc(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.sdst = self.instruction[2]
        self.src0 = self.instruction[3]
        self.src1 = self.instruction[4]
        self.ssrc2 = self.instruction[5]

    def to_print_unresolved(self):
        if self.suffix == "u32":
            temp = f"temp{self.decompiler_data.number_of_temp}"
            mask = f"mask{self.decompiler_data.number_of_mask}"
            cc = f"cc{self.decompiler_data.number_of_cc}"
            self.decompiler_data.write(f"ulong {mask} = (1ULL<<LANEID) // {self.name}\n")
            self.decompiler_data.write(f"uchar {cc} = (({self.ssrc2}&{mask} ? 1 : 0)\n")
            self.decompiler_data.write(f"uint {temp} = (ulong){self.src0} + (ulong){self.src1} + {cc}\n")
            self.decompiler_data.write(f"{self.sdst} = 0\n")
            self.decompiler_data.write(f"{self.vdst} = CLAMP ? min({temp}, 0xffffffff) : {temp}\n")
            self.decompiler_data.write(f"{self.sdst} = ({self.sdst}&~{mask }) | (({temp} >> 32) ? {mask} : 0)\n")
            self.decompiler_data.number_of_temp += 1
            self.decompiler_data.number_of_mask += 1
            self.decompiler_data.number_of_cc += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.decompiler_data.is_rdna3 and is_reg(self.src0) and is_reg(self.src1):
            assert(self.node.state[self.src0].register_content.get_expression_node() is not None and self.node.state[self.src1].register_content.get_expression_node() is not None)
            new_reg = self.node.state[self.src0] + self.node.state[self.src1]

            return set_reg(
                node=self.node,
                to_reg=self.vdst,
                from_regs=[self.src0, self.src1],
                reg=new_reg,
            )

        if self.suffix == "u32":
            new_value = make_op(self.node, self.src0, self.src1, "+", "(ulong)", "(ulong)", suffix=self.suffix)
            src0_reg = is_reg(self.src0)
            src1_reg = is_reg(self.src1)
            reg_type = RegisterType.UNKNOWN
            reg_entire = Integrity.ENTIRE

            src0_node = self.node.get_expression_node(self.src0)
            src1_node = self.node.get_expression_node(self.src1)
            expr_node = None

            if src0_reg and src1_reg:
                if self.node.state[self.src1].val == "0":
                    new_value = self.node.state[self.src0].val
                    reg_type = self.node.state[self.src0].type
                    reg_entire = self.node.state[self.src0].integrity

                    expr_node = src0_node
                elif self.node.state[self.src0].val == "0":
                    new_value = self.node.state[self.src1].val
                    reg_type = self.node.state[self.src1].type
                    reg_entire = self.node.state[self.src1].integrity

                    expr_node = src1_node
                else:
                    reg_entire = self.node.state[self.src1].integrity
                    if (
                        self.node.state[self.src0].type == RegisterType.ADDRESS_KERNEL_ARGUMENT
                        and self.node.state[self.src1].type == RegisterType.GLOBAL_ID_X
                    ):
                        #todo check that default nodes sum will work here, should work
                        new_value = f"{self.node.state[self.src0].val}[get_global_id(0)]"
                        reg_type = RegisterType.ADDRESS_KERNEL_ARGUMENT_ELEMENT
                        global_id_node = self.expression_manager.add_register_node(RegisterType.GLOBAL_ID_X)
                        expr_node = self.expression_manager.add_operation(
                            src0_node, global_id_node, ExpressionOperationType.PLUS, OpenCLTypes.ULONG)
                        # expr_node.value_type_hint.is_address = True
            else:
                reg_type = RegisterType.INT32
                if src0_reg:
                    reg_type = self.node.state[self.src0].type
                if src1_reg:
                    reg_type = self.node.state[self.src1].type

            if expr_node is None:
                expr_node = self.expression_manager.add_operation(
                    src0_node, src1_node, ExpressionOperationType.PLUS, OpenCLTypes.from_string(self.suffix))

            return set_reg_value(
                self.node,
                new_value,
                self.vdst,
                [self.src0, self.src1],
                self.suffix,
                reg_type=reg_type,
                integrity=reg_entire,
                expression_node=expr_node,
            )
        return super().to_fill_node()
