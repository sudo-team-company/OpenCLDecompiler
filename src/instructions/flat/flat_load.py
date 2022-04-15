from src.base_instruction import BaseInstruction
from src.decompiler_data import make_elem_from_addr, make_new_type_without_modifier, set_reg_value
from src.opencl_types import make_opencl_type, evaluate_size, make_asm_type
from src.register import check_and_split_regs, get_next_reg, is_vector_type
from src.register_type import RegisterType


def get_output_for_different_vector_types(output, var_type, data_type):
    if output.find(" + ") != -1:
        open_square_bracket_position = output.find("[")
        close_square_bracket_position = output.find("]")
        element_number = output[open_square_bracket_position + 1:close_square_bracket_position]
        second_term_separator = element_number.find(" + ")
        size_type_part = element_number[second_term_separator + 3:]
        dividend_separator = size_type_part.find("/")
        size_elements = size_type_part[:dividend_separator]
        one_element_size, _ = evaluate_size(make_asm_type(data_type[:-1]), True)
        curr_element = int(int(size_elements) / one_element_size)
        output = output[:output.find(" + ")] + "]"
    else:
        curr_element = 0
    output += "___s"
    new_size = curr_element
    if make_opencl_type(var_type)[-1].isdigit():
        new_size += int(var_type[-1])
    else:
        new_size = 1
    while curr_element < new_size:
        output += str(curr_element)
        curr_element += 1
    return output


class FlatLoad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.vaddr = self.instruction[2]
        self.inst_offset = self.instruction[3] if len(self.instruction) > 3 else "0"

        self.start_to_registers, self.end_to_registers = check_and_split_regs(self.vdst)
        self.from_registers, _ = check_and_split_regs(self.vaddr)

    def to_print_unresolved(self):
        if self.suffix == "dword":
            self.decompiler_data.write(self.vdst + " = *(uint*)(" + self.vaddr + " + "
                                       + self.inst_offset + ") // flat_load_dword\n")
            return self.node
        if self.suffix == "dwordx2":
            self.decompiler_data.write(self.vdst + " = *(uint*)(" + self.vaddr + " + "
                                       + self.inst_offset + ") // flat_load_dword2\n")
            return self.node
        if self.suffix == "dwordx4":
            vm = "vm" + str(self.decompiler_data.number_of_vm)
            self.decompiler_data.write("short* " + vm + " = (" + self.vaddr + " + "
                                       + self.inst_offset + ") // flat_load_dwordx4\n")
            self.decompiler_data.write(self.vdst + "[0] = *(uint*)" + vm + "\n")
            self.decompiler_data.write(self.vdst + "[1] = *(uint*)(" + vm + " + 4)\n")
            self.decompiler_data.write(self.vdst + "[2] = *(uint*)(" + vm + " + 8)\n")
            self.decompiler_data.write(self.vdst + "[3] = *(uint*)(" + vm + " + 12)\n")
            self.decompiler_data.number_of_vm += 1
            return self.node
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
            to_now = self.start_to_registers
            vector_position = 0
            reg_val = variable
            while True:
                if is_vector_type(data_type):
                    reg_val = variable + "___s" + str(vector_position)
                    vector_position += 1
                    data_type = data_type[:-1]
                    if self.suffix[-1].isdigit():
                        data_type += self.suffix[-1]
                    else:
                        data_type = make_asm_type(data_type)
                self.node = set_reg_value(self.node, reg_val, to_now, [], data_type, reg_type=register_type)
                if to_now == self.end_to_registers:
                    break
                to_now = get_next_reg(to_now)
            self.decompiler_data.make_var(self.node.state.registers[self.start_to_registers].version,
                                          self.node.state.registers[self.start_to_registers].val, data_type)
            return self.node
        return super().to_fill_node()

    def to_print(self):
        if self.suffix in ["dword", "dwordx2", "dwordx4"]:
            if self.start_to_registers == self.from_registers:
                output = self.node.parent[0].state.registers[self.from_registers].val
                data_type = self.node.parent[0].state.registers[self.from_registers].data_type
            else:
                output = self.node.state.registers[self.from_registers].val
                data_type = self.node.parent[0].state.registers[self.from_registers].data_type
            if " + " in output:
                output = make_elem_from_addr(output)
            else:
                output = "*(" + make_opencl_type(self.decompiler_data.names_of_vars[output]) + "*)(" + output + ")"
            var_name = self.node.state.registers[self.start_to_registers].val
            if var_name[-2] == 's' and var_name[-1].isdigit():
                var_name = var_name[:-5]
                var_type = self.node.state.registers[self.start_to_registers].data_type
                if data_type != var_type:
                    output = get_output_for_different_vector_types(output, var_type, data_type)
            self.output_string = var_name + " = " + output
            return self.output_string
        return super().to_print()
