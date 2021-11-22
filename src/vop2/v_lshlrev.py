from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg
from src.integrity import Integrity
from src.register_type import RegisterType
from src.upload import find_first_last_num_to_from


class VLshlrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'b32':
            self.decompiler_data.write(self.vdst + " = " + self.src1 + " << (" + self.src0 + "&31) // v_lshlrev_b32\n")
            return self.node
        elif self.suffix == 'b64':
            self.decompiler_data.write(self.vdst + " = " + self.src1 + " << (" + self.src0 + "&63) // v_lshlrev_b64\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'b32':
            new_value, _, _ = make_op(self.node, self.src1, str(pow(2, int(self.src0))), " * ")
            reg_type = self.node.state.registers[self.src1].type
            return make_new_value_for_reg(self.node, new_value, self.vdst, [self.src0, self.src1],
                                          self.suffix, reg_type=reg_type)
        elif self.suffix == 'b64':
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(self.vdst, self.src1)
            if "s" in name_of_from or "v" in name_of_from:
                from_registers = name_of_from + str(first_from)
            else:
                from_registers = self.src1
            to_registers = name_of_to + str(first_to)
            to_registers1 = name_of_to + str(last_to)
            from_registers1 = name_of_from + str(first_from + 1)
            new_value0, src1_flag, src0_flag = make_op(self.node, from_registers, str(pow(2, int(self.src0))), " * ")
            new_value1, src1_flag, src0_flag = make_op(self.node, from_registers1, str(pow(2, int(self.src0))), " * ")
            reg_entire0 = Integrity.LOW_PART
            reg_entire1 = Integrity.HIGH_PART
            if src0_flag and src1_flag:
                reg_type = self.node.state.registers[from_registers].type
                if not (self.node.state.registers[from_registers].type
                        in [RegisterType.GLOBAL_ID_X, RegisterType.GLOBAL_ID_Y, RegisterType.GLOBAL_ID_Z]
                        and self.node.state.registers[name_of_to + str(first_from + 1)].val == "0"):
                    new_value0 = self.node.state.registers[from_registers]
                    new_value1 = self.node.state.registers[from_registers1]
            else:
                reg_type = RegisterType.INT32
                if src0_flag:
                    reg_type = self.node.state.registers[self.src0].type
                if src1_flag:
                    reg_type = self.node.state.registers[from_registers].type
            data_type = self.suffix
            if src0_flag:
                data_type = str(pow(2, int(self.src1))) + ' bytes'
            elif src1_flag:
                data_type = str(pow(2, int(self.src0))) + ' bytes'
            node = make_new_value_for_reg(self.node, new_value0, to_registers, [from_registers], data_type,
                                          reg_type=reg_type, reg_entire=reg_entire0)
            node = make_new_value_for_reg(node, new_value1, to_registers1, [from_registers1], data_type,
                                          reg_type=reg_type, reg_entire=reg_entire1)
            return node
        else:
            return super().to_fill_node()
