from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.integrity import Integrity
from src.register import check_and_split_regs, is_reg, Register
from src.register_type import RegisterType


class VLshlrev(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix in ['b16', 'b32', 'b64']:
            num = int(self.suffix[1:]) - 1
            self.decompiler_data.write(f"{self.vdst} = {self.src1} << ({self.src0}&{num}) // {self.instruction[0]}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['b16', 'b32']:
            if is_reg(self.src1) and self.node.state.registers[self.src1].val == '0':
                new_value = '0'
                reg_type = RegisterType.INT32
            else:
                new_value = make_op(self.node, self.src1, str(pow(2, int(self.src0))), " * ")
                reg_type = self.node.state.registers[self.src1].type
            return set_reg_value(self.node, new_value, self.vdst, [self.src0, self.src1], self.suffix,
                                 reg_type=reg_type)
        if self.suffix == 'b64':
            start_to_register, end_to_register = check_and_split_regs(self.vdst)
            start_from_register, end_from_register = check_and_split_regs(self.src1)
            new_value0 = make_op(self.node, start_from_register, str(pow(2, int(self.src0))), " * ")
            new_value1 = make_op(self.node, end_from_register, str(pow(2, int(self.src0))), " * ")
            src1_flag = is_reg(start_from_register)
            src0_flag = is_reg(self.src0)
            reg_entire0 = Integrity.LOW_PART
            reg_entire1 = Integrity.HIGH_PART
            if src0_flag and src1_flag:
                reg_type = self.node.state.registers[start_from_register].type
                if not (self.node.state.registers[start_from_register].type
                        in [RegisterType.GLOBAL_ID_X, RegisterType.GLOBAL_ID_Y, RegisterType.GLOBAL_ID_Z]
                        and self.node.state.registers[end_from_register].val == "0"):
                    new_value0 = self.node.state.registers[start_from_register]
                    new_value1 = self.node.state.registers[end_from_register]
            else:
                reg_type = RegisterType.INT32
                if src0_flag:
                    reg_type = self.node.state.registers[self.src0].type
                if src1_flag:
                    reg_type = self.node.state.registers[start_from_register].type
            data_type = self.suffix
            if src0_flag:
                data_type = str(pow(2, int(self.src1))) + ' bytes'
            elif src1_flag:
                data_type = str(pow(2, int(self.src0))) + ' bytes'
            node = set_reg_value(self.node, new_value0, start_to_register, [start_from_register], data_type,
                                 reg_type=reg_type, integrity=reg_entire0)
            node = set_reg_value(node, new_value1, end_to_register, [end_from_register], data_type, reg_type=reg_type,
                                 integrity=reg_entire1)
            return node
        return super().to_fill_node()
