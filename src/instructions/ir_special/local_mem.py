from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.integrity import Integrity
from src.ir.registers.reg import get_reg_rang
from src.register_type import RegisterType


class LocalMemory(BaseInstruction):
    def to_fill_node(self):
        dest = self.node.operands[0]
        size = self.node.operands[1].value

        offset = self.decompiler_data.config_data.local_size
        self.decompiler_data.config_data.local_size += int(size)

        self.decompiler_data.check_lds_vars(offset, "b32")
        reg_type = RegisterType.LOCAL_DATA_POINTER
        expr_node = self.decompiler_data.lds_vars[offset]
        new_value = expr_node.value
        data_type = "b64"

        dest_lo, dest_hi = get_reg_rang(dest)

        set_reg_value(
            self.node,
            new_value,
            dest_lo.name,
            [],
            data_type,
            integrity=Integrity.LOW_PART,
            reg_type=reg_type,
            expression_node=expr_node,
        )
        set_reg_value(
            self.node,
            new_value,
            dest_hi.name,
            [],
            data_type,
            integrity=Integrity.HIGH_PART,
            reg_type=reg_type,
            expression_node=expr_node,
        )
        set_reg_value(
            self.node,
            new_value,
            dest.name,
            [],
            data_type,
            integrity=Integrity.ENTIRE,
            reg_type=reg_type,
            expression_node=expr_node,
        )
        return self.node
