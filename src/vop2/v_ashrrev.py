from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, make_new_value_for_reg
from src.integrity import Integrity
from src.upload import find_first_last_num_to_from


class VAshrrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == 'i32':
            self.decompiler_data.write(self.vdst + " = (int)" + self.src1 + " >> ("
                                       + self.src0 + "&31) // v_ashrrev_i32\n")
            return self.node
        elif self.suffix == 'i64':
            self.decompiler_data.write(self.vdst + " = (long)" + self.src1 + " >> ("
                                       + self.src0 + "&63) // v_ashrrev_i64\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == 'i32':
            new_value = self.node.state.registers[self.src1].val
            reg_type = self.node.state.registers[self.src1].type
            return make_new_value_for_reg(self.node, new_value, self.vdst, [self.src0, self.src1],
                                          self.suffix, reg_type=reg_type)
        elif self.suffix == 'i64':
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(self.vdst, self.src1)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if self.node.state.registers[from_registers].val == "0":
                self.node.state.registers[from_registers].val = \
                    self.node.state.registers[name_of_from + str(first_from + 1)].val
            new_value, src1_flag, src0_flag = make_op(self.node, from_registers, str(pow(2, int(self.src0))),
                                                      " / ", '', '(long)')
            reg_type = self.node.state.registers[from_registers].type
            node = make_new_value_for_reg(self.node, new_value, to_registers, [from_registers], self.suffix,
                                          reg_type=reg_type, reg_entire=Integrity.LOW_PART)
            to_registers_1 = name_of_to + str(last_to)
            from_registers_1 = name_of_from + str(last_from)
            node = make_new_value_for_reg(node, new_value, to_registers_1, [from_registers_1], self.suffix,
                                          reg_type=reg_type, reg_entire=Integrity.HIGH_PART)
            return node
        else:
            return super().to_fill_node()
