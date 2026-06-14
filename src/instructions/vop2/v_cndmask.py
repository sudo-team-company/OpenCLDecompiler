from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value_save, try_get_reg
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import ExpressionType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import is_reg
from src.register_type import RegisterType


class VCndmask(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]
        self.ssrc2 = self.operand[3]

    def to_fill_node(self):
        if self.suffix == "b32":
            if (
                self.src1.name in self.node.state
                and self.node.get_from_state(self.src1).type == RegisterType.DIVISION_PT8
            ):
                new_value = self.node.get_from_state(self.src1).val
                return set_reg_value_save(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT9,
                    expression_node=self.get_expression_node(self.src1),
                )
            if (
                self.src1.name in self.node.state
                and self.node.get_from_state(self.src1).type == RegisterType.DIVISION_PT10
            ):
                new_value = self.node.get_from_state(self.src1).val
                return set_reg_value_save(
                    self.node,
                    new_value,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    reg_type=RegisterType.UNKNOWN,
                    expression_node=self.get_expression_node(self.src1),
                )
            if (
                self.ssrc2.name in self.node.state
                and self.node.get_from_state(self.ssrc2).type == RegisterType.DIVISION_PASS
            ):
                return set_reg_value_save(
                    self.node, "", self.vdst, [self.src0, self.src1], self.suffix, reg_type=RegisterType.DIVISION_PASS
                )
            if self.ssrc2.name in self.node.state and self.node.get_from_state(self.ssrc2).val == "0":
                return set_reg_value_save(
                    self.node,
                    self.src0.name,
                    self.vdst,
                    [self.src0, self.src1],
                    self.suffix,
                    expression_node=self.get_expression_node(self.src0),
                )

            variable = f"var{self.decompiler_data.num_of_var}"
            if (
                self.vdst.name in self.node.state
                and self.node.get_from_state(self.vdst) is not None
                and self.node.get_from_state(self.vdst).type == RegisterType.KERNEL_ARGUMENT_ELEMENT
            ):
                variable = f"*{variable}"
            reg_type = RegisterType.PROGRAM_PARAM
            src0_src1_common_type = self.expression_manager.get_common_type(
                self.get_expression_node(self.src0), self.get_expression_node(self.src1)
            ).set_is_const(False)
            var_node = self.expression_manager.add_variable_node(variable, src0_src1_common_type)
            node = set_reg_value_save(
                self.node,
                variable,
                self.vdst,
                [self.src0, self.src1],
                self.suffix,
                reg_type=reg_type,
                expression_node=var_node,
            )
            self.decompiler_data.make_var(node.get_from_state(self.vdst).version, variable, self.suffix)
            return node
        return super().to_fill_node()

    def to_print(self):
        if self.suffix == "b32":
            vdst = try_get_reg(self.node, self.vdst)
            ssrc2 = try_get_reg(self.node, self.ssrc2)
            if vdst and vdst.type == RegisterType.DIVISION_PT9:
                return ""
            if vdst and vdst.type == RegisterType.DIVISION_PASS:
                return ""
            if ssrc2 and ssrc2.type == RegisterType.DIVISION_PASS:
                return ""
            if vdst and vdst.get_expression_node().value == 0:
                return ""
            ssrc2_node = ssrc2.get_expression_node()
            ssrc2_val = ExpressionManager().expression_to_string(ssrc2_node)
            if ssrc2_node.type == ExpressionType.IF_TERNARY:
                ssrc2_val = f"({ssrc2_val})"

            if is_reg(self.src1):
                src1_parent_val = self.node.parent[0].get_from_state(self.src1).val
                src1_parent_val = ExpressionManager().expression_to_string(
                    self.node.parent[0].get_or_add_expression_node(self.src1, OpenCLTypes.from_string(self.suffix))
                )
            else:
                src1_parent_val = self.src1.name
            if is_reg(self.src0):
                src0_parent_val = self.node.parent[0].get_from_state(self.src0).val
                src0_parent_val = ExpressionManager().expression_to_string(
                    self.node.parent[0].get_or_add_expression_node(self.src0, OpenCLTypes.from_string(self.suffix))
                )
            else:
                src0_parent_val = self.src0.name
            self.output_string = (
                f"{vdst.get_expression_node().value} = {ssrc2_val} ? {src0_parent_val} : {src1_parent_val}"
            )
            return self.output_string
        return super().to_print()
