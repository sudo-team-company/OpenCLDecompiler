from src.base_instruction import BaseInstruction
from src.decompiler_data import make_elem_from_addr, make_new_type_without_modifier
from src.opencl_types import make_opencl_type
from src.register import check_and_split_regs, is_vgpr


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
                            self.node.state.registers[self.to_registers].data_type:
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
                    self.output_string = var + " = " + self.node.state.registers[self.from_registers_1].val
                else:
                    self.output_string = var + " = " + self.node.state.registers[self.from_registers].val
            else:
                self.output_string = var + " = " + self.decompiler_data.initial_state.registers[self.from_registers].val
            return self.output_string
        return super().to_print()
