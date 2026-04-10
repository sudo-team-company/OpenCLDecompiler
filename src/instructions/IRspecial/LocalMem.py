from src.base_instruction import BaseInstruction
from src.register_type import RegisterType
from src.register import split_range
from src.decompiler_data import set_reg_value
from src.integrity import Integrity

class LocalMemory(BaseInstruction):
    def to_fill_node(self):
        dest = self.node.instruction[1]
        size = self.node.instruction[2]

        offset = self.decompiler_data.config_data.local_size
        self.decompiler_data.config_data.local_size += int(size)

        self.decompiler_data.check_lds_vars(offset, 'b32')
        reg_type = RegisterType.LOCAL_DATA_POINTER
        expr_node = self.decompiler_data.lds_vars[offset]
        new_value = expr_node.value
        data_type = "b64"

        dest_lo, dest_hi = split_range(dest)

        set_reg_value(
                self.node, new_value, dest_lo, [], data_type, integrity=Integrity.LOW_PART, reg_type=reg_type, expression_node=expr_node
            )
        set_reg_value(
                self.node, new_value, dest_hi, [], data_type, integrity=Integrity.HIGH_PART, reg_type=reg_type, expression_node=expr_node
            )
        return self.node
    