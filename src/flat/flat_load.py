from opencl_types import make_opencl_type
from src.base_instruction import BaseInstruction
from src.decompiler_data import make_elem_from_addr, make_new_type_without_modifier, make_new_value_for_reg
from src.register_type import RegisterType
from src.upload import find_first_last_num_to_from


class FlatLoad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.vaddr = self.instruction[2]
        self.inst_offset = self.instruction[3] if len(self.instruction) > 3 else "0"
        self.first_to, self.last_to, self.name_of_to, self.name_of_from, self.first_from, self.last_from \
            = find_first_last_num_to_from(self.vdst, self.vaddr)
        self.from_registers = self.name_of_from + str(self.first_from)
        self.to_registers = self.name_of_to + str(self.first_to)

    def to_print_unresolved(self):
        if self.suffix == "dword":
            self.decompiler_data.write(self.vdst + " = *(uint*)(" + self.vaddr + " + "
                                       + self.inst_offset + ") // flat_load_dword\n")
            return self.node
        elif self.suffix == "dwordx2":
            self.decompiler_data.write(self.vdst + " = *(uint*)(" + self.vaddr + " + "
                                       + self.inst_offset + ") // flat_load_dword2\n")
            return self.node
        elif self.suffix == "dwordx4":
            vm = "vm" + str(self.decompiler_data.number_of_vm)
            self.decompiler_data.write("short* " + vm + " = (" + self.vaddr + " + "
                                       + self.inst_offset + ") // flat_load_dwordx4\n")
            self.decompiler_data.write(self.vdst + "[0] = *(uint*)" + vm + "\n")
            self.decompiler_data.write(self.vdst + "[1] = *(uint*)(" + vm + " + 4)\n")
            self.decompiler_data.write(self.vdst + "[2] = *(uint*)(" + vm + " + 8)\n")
            self.decompiler_data.write(self.vdst + "[3] = *(uint*)(" + vm + " + 12)\n")
            self.decompiler_data.number_of_vm += 1
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):  # нужно ли здесь делать self.node
        if self.suffix in ["dword", "dwordx2", "dwordx4"]:
            variable = "var" + str(self.decompiler_data.num_of_var)
            data_type = make_new_type_without_modifier(self.node, self.from_registers)
            # probably we should save only const data
            self.decompiler_data.var_value[variable] = self.node.state.registers[self.from_registers].val
            register_type = RegisterType.KERNEL_ARGUMENT_PTR \
                if self.node.state.registers[self.from_registers].type == RegisterType.ADDRESS_KERNEL_ARGUMENT \
                else RegisterType.KERNEL_ARGUMENT_ELEMENT
            node = make_new_value_for_reg(self.node, variable, self.to_registers, [], data_type, reg_type=register_type)
            self.decompiler_data.make_var(node.state.registers[self.to_registers].version, variable, data_type)
            if self.first_to != self.last_to:
                to_now = self.name_of_to + str(self.first_to + 1)
                node = make_new_value_for_reg(node, variable, to_now, [], data_type, reg_type=register_type)
                self.decompiler_data.make_var(node.state.registers[to_now].version, variable, data_type)
            return node
        else:
            return super().to_fill_node()

    def to_print(self):
        if self.suffix in ["dword", "dwordx2", "dwordx4"]:
            if self.to_registers == self.from_registers:
                output = self.node.parent[0].state.registers[self.from_registers].val
            else:
                output = self.node.state.registers[self.from_registers].val
            if " + " in output:
                output = make_elem_from_addr(output)
            else:
                output = "*(" + make_opencl_type(self.decompiler_data.names_of_vars[output]) + "*)(" + output + ")"
            self.output_string = self.node.state.registers[self.to_registers].val + " = " + output
            return self.output_string
        else:
            super().to_print()
