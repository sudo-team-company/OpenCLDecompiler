from typing import Optional

from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import make_op, set_reg, set_reg_value
from src.register import Register, is_reg
from src.register_type import RegisterType


class VAnd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(f"{self.vdst} = {self.src0} & {self.src1} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32":
            if is_reg(self.src1):

                def default_behaviour() -> tuple[object, RegisterType]:
                    new_value = self.node.state[self.src1].val
                    reg_type = RegisterType.UNKNOWN

                    return new_value, reg_type

                size_of_work_groups = self.decompiler_data.config_data.size_of_work_groups
                if self.node.state[self.src1].type == RegisterType.WORK_DIM and self.src0 == "0xffff":
                    new_value = self.node.state[self.src1].val
                    reg_type = self.node.state[self.src1].type
                elif self.node.state[self.src1].type == RegisterType.GLOBAL_SIZE_X and size_of_work_groups[0] == -int(
                    self.src0
                ):
                    new_value = make_op(
                        self.node, "get_num_groups(0)", str(size_of_work_groups[0]), "*", suffix=self.suffix
                    )
                    reg_type = RegisterType.UNKNOWN
                elif self.node.state[self.src1].type == RegisterType.GLOBAL_SIZE_Y and size_of_work_groups[1] == -int(
                    self.src0
                ):
                    new_value = make_op(
                        self.node, "get_num_groups(1)", str(size_of_work_groups[1]), "*", suffix=self.suffix
                    )
                    reg_type = RegisterType.UNKNOWN
                elif self.node.state[self.src1].type == RegisterType.GLOBAL_SIZE_Z and size_of_work_groups[2] == -int(
                    self.src0
                ):
                    new_value = make_op(
                        self.node, "get_num_groups(2)", str(size_of_work_groups[2]), "*", suffix=self.suffix
                    )
                    reg_type = RegisterType.UNKNOWN
                elif (
                    isinstance(self.node.state[self.src1].register_content, CombinedRegisterContent)
                    and isinstance(self.src0, str)
                    and self.src0.startswith("0x")
                ):
                    maybe_new_reg: Optional[Register] = self.node.state[self.src1] & self.src0
                    if maybe_new_reg is None:
                        new_value, reg_type = default_behaviour()
                    else:
                        return set_reg(
                            node=self.node,
                            to_reg=self.vdst,
                            from_regs=[self.src0, self.src1],
                            reg=maybe_new_reg,
                        )

                else:
                    new_value, reg_type = default_behaviour()
                return set_reg_value(
                    node=self.node,
                    new_value=new_value,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1],
                    data_type=self.suffix,
                    reg_type=reg_type,
                    integrity=self.node.state[self.src1].integrity,
                )
        return super().to_fill_node()
