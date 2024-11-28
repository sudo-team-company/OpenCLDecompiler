from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import set_reg, set_reg_value
from src.register import is_reg
from src.register_type import RegisterType


class SBfe(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        tab = "    "
        shift = f"shift{self.decompiler_data.number_of_shift}"
        length = f"length{self.decompiler_data.number_of_length}"

        if self.suffix == "u32":
            self.decompiler_data.write(f"uchar {shift} = {self.ssrc1} & 31 // {self.name}\n")
            self.decompiler_data.write(f"uchar {length} = ({self.ssrc1}>>16) & 07xf\n")
            self.decompiler_data.write(f"if ({length}==0)\n")
            self.decompiler_data.write(f"{tab}{self.sdst} = 0\n")
            self.decompiler_data.write(f"if ({shift} + {length} < 32)\n")
            self.decompiler_data.write(
                f"{tab}{self.sdst} = {self.ssrc0} << (32 - {shift} - {length}) >> (32 - {length})\n"
            )
            self.decompiler_data.write("else\n")
            self.decompiler_data.write(f"{tab}{self.sdst} = {self.ssrc0} >> {shift}\n")
            self.decompiler_data.write(f"scc = {self.sdst} != 0\n")
            self.decompiler_data.number_of_length += 1
            self.decompiler_data.number_of_shift += 1
            return self.node
        if self.suffix == "i32":
            self.decompiler_data.write(f"uchar {shift} = {self.ssrc1} & 31 // {self.name}\n")
            self.decompiler_data.write(f"uchar {length} = ({self.ssrc1}>>16) & 07xf\n")
            self.decompiler_data.write(f"if ({length}==0)\n")
            self.decompiler_data.write(f"{tab}{self.sdst} = 0\n")
            self.decompiler_data.write(f"if ({shift} + {length} < 32)\n")
            self.decompiler_data.write(
                f"{tab}{self.sdst} = (int){self.ssrc0} << (32 - {shift} - {length}) >> (32 - {length})\n"
            )
            self.decompiler_data.write("else\n")
            self.decompiler_data.write(f"{tab}{self.sdst} = (int){self.ssrc0} >> {shift}\n")
            self.decompiler_data.write(f"scc = {self.sdst} != 0\n")
            self.decompiler_data.number_of_length += 1
            self.decompiler_data.number_of_shift += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if (
            self.decompiler_data.is_rdna3
            and self.suffix.endswith("32")
            and is_reg(self.ssrc0)
            and isinstance(self.node.state[self.ssrc0].register_content, CombinedRegisterContent)
        ):
            shift_by = int(self.ssrc1, 16) & ((1 << 4) - 1)
            and_by = hex((1 << ((int(self.ssrc1, 16) >> 16) & ((1 << 6) - 1))) - 1)

            new_reg = self.node.state[self.ssrc0] >> shift_by
            new_reg = new_reg & and_by
            new_reg.cast_to(self.suffix)

            set_reg(
                node=self.node,
                to_reg=self.sdst,
                from_regs=[self.ssrc0, self.ssrc1],
                reg=new_reg,
            )

            is_zero = str(new_reg.get_value()) == "0"

            set_reg_value(
                node=self.node,
                new_value=str(int(not is_zero)),
                to_reg="scc",
                from_regs=[self.sdst],
                data_type=self.suffix,
            )

            return self.node

        if self.suffix == "u32":
            if self.ssrc1 == "0x20010":
                new_value = "get_work_dim()"
                reg_type = RegisterType.WORK_DIM
            elif self.ssrc1 == "0x100010":
                new_value = "get_local_size(1)"
                reg_type = RegisterType.LOCAL_SIZE_Y
            elif self.decompiler_data.bfe_offsets.get((self.node.state[self.ssrc0].val, self.ssrc1)):
                new_value = self.decompiler_data.bfe_offsets[self.node.state[self.ssrc0].val, self.ssrc1]
                reg_type = RegisterType.KERNEL_ARGUMENT_VALUE
            else:
                print("Unknown pattern in s_bfe")

                raise NotImplementedError()
            return set_reg_value(self.node, new_value, self.sdst, [], self.suffix, reg_type=reg_type)
        if self.suffix == "i32":
            if self.decompiler_data.bfe_offsets.get((self.node.state[self.ssrc0].val, self.ssrc1)):
                new_value = self.decompiler_data.bfe_offsets[self.node.state[self.ssrc0].val, self.ssrc1]
                reg_type = RegisterType.KERNEL_ARGUMENT_VALUE
                set_reg_value(self.node, new_value, self.sdst, [], self.suffix, reg_type=reg_type)
            return self.node
        return super().to_fill_node()
