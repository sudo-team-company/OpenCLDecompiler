from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.register import is_vector_type
from src.register_type import RegisterType


class VPerm(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.src0 = self.operand[1]
        self.src1 = self.operand[2]
        self.src2 = self.operand[3]

    def to_fill_node(self):
        if self.suffix == "b32":
            if self.node.get_from_state(self.src2).val == "0x2010004":
                new_value = f"{self.node.get_from_state(self.src0).val}, {self.node.get_from_state(self.src1).val}"
                reg_type = RegisterType.KERNEL_ARGUMENT_VALUE

                expr_node = self.expression_manager.add_permute_node(
                    self.get_expression_node(self.src0),
                    self.get_expression_node(self.src1),
                )

                if is_vector_type(self.node.get_from_state(self.src0).data_type):
                    src0_data_type_name = self.node.get_from_state(self.src0).data_type[:1]
                    src0_data_type_size = self.node.get_from_state(self.src0).data_type[-1:]
                else:
                    src0_data_type_name = self.node.get_from_state(self.src0).data_type
                    src0_data_type_size = 1

                if is_vector_type(self.node.get_from_state(self.src1).data_type):
                    src1_data_type_name = self.node.get_from_state(self.src1).data_type[:1]
                    src1_data_type_size = int(self.node.get_from_state(self.src1).data_type[-1:])
                else:
                    src1_data_type_name = self.node.get_from_state(self.src1).data_type
                    src1_data_type_size = 1

                if src1_data_type_name == src0_data_type_name:
                    data_type = f"{src1_data_type_name}{src1_data_type_size + src0_data_type_size}"
                else:
                    data_type = self.node.get_from_state(self.src1).data_type
                set_reg_value(
                    self.node, new_value, self.vdst.name, [], data_type, reg_type=reg_type, expression_node=expr_node
                )
            return self.node
        return super().to_fill_node()
