from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.expression_manager.expression_node import ExpressionType
from src.types.opencl_types import make_opencl_type as make_opencl_type_new
from src.opencl_types import make_opencl_type
from src.register import check_and_split_regs
from src.register_type import RegisterType


class VCvt(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]

        self.to_registers, _ = check_and_split_regs(self.vdst)
        self.from_registers, _ = check_and_split_regs(self.src0)

    def to_print_unresolved(self):  # noqa: PLR0911
        tab = "    "
        if self.suffix == "f32_u32":
            self.decompiler_data.write(f"{self.vdst} = (float){self.src0} // {self.name}\n")
            return self.node
        if self.suffix == "f64_i32":
            self.decompiler_data.write(f"{self.vdst} = (double)(int){self.src0} // {self.name}\n")
            return self.node
        if self.suffix == "f64_u32":
            self.decompiler_data.write(f"{self.vdst} = (double)(uint){self.src0} // {self.name}\n")
            return self.node
        if self.suffix == "i32_f64":
            self.decompiler_data.write(f"{self.vdst} = (int)(double){self.src0} // {self.name}\n")
            return self.node
        if self.suffix == "u32_f64":
            self.decompiler_data.write(f"{self.vdst} = (uint)(double){self.src0} // {self.name}\n")
            return self.node
        if self.suffix == "u32_f32":
            self.decompiler_data.write(f"{self.instruction[1]} = 0 // {self.name}\n")
            self.decompiler_data.write(f"if (!isnan(as_float({self.src0})))\n")
            self.decompiler_data.write(
                f"{tab}{self.vdst} = (int)min(convert_int_rtz(as_float({self.src0})), 4294967295.0)\n"
            )
            return self.node
        if self.suffix == "i32_f32":
            self.decompiler_data.write(f"{self.vdst} = (int)(float){self.src0} // {self.name}\n")
            return self.node
        if self.suffix == "f32_i32":
            self.decompiler_data.write(f"{self.vdst} = (float)(int){self.src0} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in {"f32_u32", "f64_i32", "f64_u32", "i32_f64", "u32_f64", "u32_f32", "i32_f32", "f32_i32"}:
            if self.src0 in self.node.state and self.node.state[self.src0].type == RegisterType.DIVISION_PT2:
                new_value = self.node.state[self.src0].val
                return set_reg_value(
                    self.node, new_value, self.vdst, [self.src0], self.suffix, reg_type=RegisterType.DIVISION_PT3
                )

            var_node = self.node.get_expression_node(self.from_registers)
            assert(var_node.type == ExpressionType.VAR or var_node.type == ExpressionType.VAR_PTR)
            #todo make cast to
            var_node.value_type_hint = make_opencl_type_new(self.suffix[:3])

            asm_type = self.suffix[4:]
            self.decompiler_data.names_of_vars[self.node.state[self.from_registers].val] = asm_type
            new_value = f"({make_opencl_type(self.suffix[:3])}){self.node.state[self.from_registers].val}"
            reg_type = self.node.state[self.from_registers].type
            return set_reg_value(self.node, new_value, self.to_registers, [], asm_type, reg_type=reg_type, expression_node=var_node)
        return super().to_fill_node()
