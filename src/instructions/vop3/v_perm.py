from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.register import is_vector_type
from src.register_type import RegisterType


class VPerm(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]
        self.src2 = self.instruction[4]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            tab = "    "
            qword = f"qword{self.decompiler_data.number_of_qword}"
            choice = f"choice{self.decompiler_data.number_of_choice}"
            result = f"result{self.decompiler_data.number_of_result}"
            self.decompiler_data.write(f"{self.vdst} = 0 // {self.name}\n")
            self.decompiler_data.write(f"ulong {qword} = (((ulong){self.src0})<<32) | {self.src1}\n")
            self.decompiler_data.write("for (int i = 0; i < 4; i++)\n")
            self.decompiler_data.write("{\n")
            self.decompiler_data.write(f"{tab}byte {choice} = ({self.src2} >> (8*i)) & 0xff\n")
            self.decompiler_data.write(f"{tab}byte {result}\n")
            self.decompiler_data.write(f"{tab}if ({choice} >= 13)\n")
            self.decompiler_data.write(f"{tab}{tab}{result} = 0xff\n")
            self.decompiler_data.write(f"{tab}else if ({choice} == 12)\n")
            self.decompiler_data.write(f"{tab}{tab}{result} = 0\n")
            self.decompiler_data.write(f"{tab}else if ({choice} >= 8)\n")
            self.decompiler_data.write(f"{tab}{tab}{result} = 0xff * {qword}>>(({choice}-8)*16 + 15)\n")
            self.decompiler_data.write(f"{tab}else\n")
            self.decompiler_data.write(f"{tab}{tab}{result} = ({qword}>>({choice}*8)) & 0xff\n")
            self.decompiler_data.write(f"{tab}{self.vdst} |= ({result} << (i * 8))\n")
            self.decompiler_data.write("}\n")
            self.decompiler_data.number_of_qword += 1
            self.decompiler_data.number_of_choice += 1
            self.decompiler_data.number_of_result += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32":
            if self.node.state[self.src2].val == "0x2010004":
                new_value = f"{self.node.state[self.src0].val}, {self.node.state[self.src1].val}"
                reg_type = RegisterType.KERNEL_ARGUMENT_VALUE

                expr_node = self.expression_manager.add_permute_node(
                    self.node.get_expression_node(self.src0),
                    self.node.get_expression_node(self.src1),
                )

                if is_vector_type(self.node.state[self.src0].data_type):
                    src0_data_type_name = self.node.state[self.src0].data_type[:1]
                    src0_data_type_size = self.node.state[self.src0].data_type[-1:]
                else:
                    src0_data_type_name = self.node.state[self.src0].data_type
                    src0_data_type_size = 1

                if is_vector_type(self.node.state[self.src1].data_type):
                    src1_data_type_name = self.node.state[self.src1].data_type[:1]
                    src1_data_type_size = int(self.node.state[self.src1].data_type[-1:])
                else:
                    src1_data_type_name = self.node.state[self.src1].data_type
                    src1_data_type_size = 1

                if src1_data_type_name == src0_data_type_name:
                    data_type = f"{src1_data_type_name}{src1_data_type_size + src0_data_type_size}"
                else:
                    data_type = self.node.state[self.src1].data_type
                set_reg_value(
                    self.node, new_value, self.vdst, [], data_type, reg_type=reg_type, expression_node=expr_node
                )
            return self.node
        return super().to_fill_node()
