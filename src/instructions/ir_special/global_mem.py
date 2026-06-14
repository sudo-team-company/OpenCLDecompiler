from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_node import ExpressionValueTypeHint, TypeAddressSpaceQualifiers
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.integrity import Integrity
from src.ir.registers.reg import get_reg_rang
from src.register_type import RegisterType


class GlobalMemory(BaseInstruction):
    def to_fill_node(self):
        dest = self.node.operands[0]
        values = [operand.value for operand in self.node.operands[1:]]
        name = dest.name

        self.decompiler_data.register_global_data(name, values)

        expr_node = self.expression_manager.add_variable_node(
            name,
            ExpressionValueTypeHint(
                OpenCLTypes.UINT,
                TypeAddressSpaceQualifiers.CONST,
                is_pointer=True,
            ),
        )

        dest_lo, dest_hi = get_reg_rang(dest)
        data_type = "b64"
        reg_type = RegisterType.GLOBAL_DATA_POINTER

        set_reg_value(
            self.node,
            name,
            dest_lo.name,
            [],
            data_type,
            integrity=Integrity.LOW_PART,
            reg_type=reg_type,
            expression_node=expr_node,
        )
        set_reg_value(
            self.node,
            name,
            dest_hi.name,
            [],
            data_type,
            integrity=Integrity.HIGH_PART,
            reg_type=reg_type,
            expression_node=expr_node,
        )
        set_reg_value(
            self.node,
            name,
            dest.name,
            [],
            data_type,
            integrity=Integrity.ENTIRE,
            reg_type=reg_type,
            expression_node=expr_node,
        )
        return self.node
