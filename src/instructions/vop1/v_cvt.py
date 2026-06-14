from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_node import ExpressionType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import get_reg_rang
from src.opencl_types import make_opencl_type
from src.register_type import RegisterType


class VCvt(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]

        self.to_registers = get_reg_rang(self.vdst)[0]
        self.from_registers = get_reg_rang(self.src0)[0]

    def to_fill_node(self):
        if self.suffix in {"f32_u32", "f64_i32", "f64_u32", "i32_f64", "u32_f64", "u32_f32", "i32_f32", "f32_i32"}:
            if (
                self.src0.name in self.node.state
                and self.node.get_from_state(self.src0).type == RegisterType.DIVISION_PT2
            ):
                new_value = self.node.get_from_state(self.src0).val
                return set_reg_value(
                    self.node,
                    new_value,
                    self.vdst.name,
                    [self.src0.name],
                    self.suffix,
                    reg_type=RegisterType.DIVISION_PT3,
                    expression_node=self.get_expression_node(self.src0),
                )

            asm_type = self.suffix[4:]

            var_node = self.get_expression_node(self.from_registers)
            assert var_node.type == ExpressionType.VAR
            var_node = self.expression_manager.cast_node(var_node, OpenCLTypes.from_string(asm_type))
            self.decompiler_data.names_of_vars[self.node.get_from_state(self.from_registers).val] = asm_type
            new_value = f"({make_opencl_type(self.suffix[:3])}){self.node.get_from_state(self.from_registers).val}"
            reg_type = self.node.get_from_state(self.from_registers).type
            return set_reg_value(
                self.node, new_value, self.to_registers.name, [], asm_type, reg_type=reg_type, expression_node=var_node
            )
        return super().to_fill_node()
