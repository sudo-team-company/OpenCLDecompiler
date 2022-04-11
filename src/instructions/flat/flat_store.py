from src.base_instruction import BaseInstruction
from src.decompiler_data import make_elem_from_addr, make_new_type_without_modifier
from src.opencl_types import make_opencl_type
from src.register import check_and_split_regs, is_vgpr, is_vector_type, get_next_reg


def get_vector_name(vector_element):
    separator = vector_element.find("__")
    vector_name = vector_element[:separator]
    return vector_name


def get_vector_element_number(vector_element):
    separator = vector_element.find("__")
    vector_element_number = int(vector_element[separator + 4:])
    return vector_element_number


def check_vector_part(new_vector):
    el_name = get_vector_name(new_vector[0])
    el_number = get_vector_element_number(new_vector[0])
    for new_el in new_vector[1:]:
        new_el_number = get_vector_element_number(new_el)
        if el_name != get_vector_name(new_el) or el_number + 1 != new_el_number:
            return False
        el_number = new_el_number
    return True


def prepare_vector_type_output(from_registers, from_registers_1, suffix, to_registers, node):
    curr_reg = from_registers
    new_vector = [node.state.registers[curr_reg].val]
    while curr_reg != from_registers_1:
        curr_reg = get_next_reg(curr_reg)
        new_vector.append(node.state.registers[curr_reg].val)
    if check_vector_part(new_vector):
        output_string = get_vector_name(node.state.registers[from_registers].val)
        if len(new_vector) != int(suffix[-1]):
            output_string += "."
            start_number = get_vector_element_number(new_vector[0])
            end_number = get_vector_element_number(new_vector[-1])
            for s_id in range(start_number, end_number + 1):
                output_string = output_string + "s" + str(s_id)
    else:
        output_string = "(" + node.state.registers[to_registers].data_type + ")("
        for el in new_vector:
            output_string = output_string + el + ", "
        output_string = output_string[:-2] + ")"
    return output_string


class FlatStore(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vaddr = self.instruction[1]
        self.vdata = self.instruction[2]
        self.inst_offset = "0" if len(self.instruction) < 4 else self.instruction[3]

        self.to_registers, _ = check_and_split_regs(self.vaddr)
        self.from_registers, self.from_registers_1 = check_and_split_regs(self.vdata)

    def to_print_unresolved(self):
        if self.suffix in ["dword", "byte"]:
            self.decompiler_data.write("*(uint32*)(" + self.vaddr + " + " + self.inst_offset
                                       + ") = " + self.vdata + " // flat_store_dword\n")
            return self.node
        if self.suffix == "dwordx2":
            self.decompiler_data.write("*(ulong*)(" + self.vaddr + " + " + self.inst_offset
                                       + " = " + self.vdata + " // flat_store_dwordx2\n")
            return self.node
        if self.suffix == "dwordx4":
            vm = "vm" + str(self.decompiler_data.number_of_vm)
            self.decompiler_data.write(
                "short* " + vm + " = (" + self.vaddr + " + " + self.inst_offset + ") // flat_store_dwordx4\n")
            self.decompiler_data.write("*(uint*)(" + vm + ") = " + self.vdata + "[0]\n")
            self.decompiler_data.write("*(uint*)(" + vm + " + 4) = " + self.vdata + "[1]\n")
            self.decompiler_data.write("*(uint*)(" + vm + " + 8) = " + self.vdata + "[2]\n")
            self.decompiler_data.write("*(uint*)(" + vm + " + 12) = " + self.vdata + "[3]\n")
            self.decompiler_data.number_of_vm += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ["dword", "dwordx2", "dwordx4", "byte"]:
            if is_vgpr(self.vaddr):
                self.node.state.registers[self.to_registers].version = \
                    self.node.parent[0].state.registers[self.to_registers].version
                self.node.state.registers[self.to_registers].data_type = self.suffix
            # TODO: Сделать присвоение в пары
            else:
                if self.node.state.registers[self.from_registers].data_type is not None \
                        and 'bytes' in self.node.state.registers[self.from_registers].data_type:
                    self.node.state.registers[self.from_registers].data_type = \
                        self.node.state.registers[self.to_registers].data_type
                    self.decompiler_data.names_of_vars[self.node.state.registers[self.from_registers].val] = \
                        self.node.state.registers[self.to_registers].data_type
                else:
                    if str(self.node.state.registers[self.from_registers].data_type) not in \
                            self.node.state.registers[self.to_registers].data_type \
                            and not is_vector_type(self.node.state.registers[self.from_registers].data_type):
                        if self.node.state.registers[self.from_registers].val in self.decompiler_data.names_of_vars:
                            val = self.node.state.registers[self.from_registers].val
                            self.node.state.registers[self.from_registers].val = \
                                '(' + make_opencl_type(
                                    make_new_type_without_modifier(self.node, self.to_registers)) + ')' \
                                + self.node.state.registers[self.from_registers].val
                            # init var - i32, gdata - i64. var = gdata -> var - i64
                            self.decompiler_data.names_of_vars[val] = \
                                self.node.state.registers[self.from_registers].data_type
                        else:
                            self.node.state.registers[self.from_registers].data_type = \
                                make_new_type_without_modifier(self.node, self.to_registers)
                            self.decompiler_data.names_of_vars[self.node.state.registers[self.from_registers].val] = \
                                self.node.state.registers[self.from_registers].data_type
            return self.node
        return super().to_fill_node()

    def to_print(self):
        if self.suffix in ["dword", "dwordx2", "dwordx4", "byte"]:
            var = self.node.state.registers[self.to_registers].val
            if " + " in var:
                var = make_elem_from_addr(var)
            else:
                if self.decompiler_data.names_of_vars.get(var):
                    var = "*(" + make_opencl_type(self.decompiler_data.names_of_vars[var]) + "*)(" + var + ")"
                else:
                    var = "*" + var
            if self.node.state.registers.get(self.from_registers):
                if self.node.state.registers[self.from_registers].val == "0" \
                        and self.node.state.registers.get(self.from_registers_1):
                    self.output_string = self.node.state.registers[self.from_registers_1].val
                else:
                    if is_vector_type(self.node.state.registers[self.to_registers].data_type):
                        self.output_string = prepare_vector_type_output(self.from_registers, self.from_registers_1,
                                                                        self.suffix, self.to_registers, self.node)
                    else:
                        self.output_string = self.node.state.registers[self.from_registers].val
            else:
                self.output_string = self.decompiler_data.initial_state.registers[self.from_registers].val
            return var + " = " + self.output_string
        return super().to_print()
