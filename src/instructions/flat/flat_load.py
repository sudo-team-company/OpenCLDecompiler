from src.base_instruction import BaseInstruction
from src.decompiler_data import make_new_type_without_modifier, set_reg_value
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import ExpressionNode, ExpressionValueTypeHint
from src.ir.registers.reg import get_reg_rang
from src.opencl_types import make_asm_type
from src.register import is_vector_type
from src.register_type import RegisterType


def get_output_for_different_vector_types(
    output: str, variable_type_hint: ExpressionValueTypeHint, output_type_hint: ExpressionValueTypeHint
):
    if output.find(" + ") != -1:
        open_square_bracket_position = output.find("[")
        close_square_bracket_position = output.find("]")
        element_number = output[open_square_bracket_position + 1 : close_square_bracket_position]
        second_term_separator = element_number.find(" + ")
        vector_offset_numerator, vector_offset_denominator = map(
            int, element_number[second_term_separator + 4 : -1].split("/")
        )
        vector_size = output_type_hint.size_bytes()
        one_element_size = variable_type_hint.set_number_of_components(1).size_bytes()
        curr_element = int(vector_offset_numerator / vector_offset_denominator * vector_size / one_element_size)
        output = output[: output.find(" + ")] + "]"
    else:
        curr_element = 0
    output += "___s"
    new_size = curr_element
    if variable_type_hint.is_vector_type():
        new_size += variable_type_hint.number_of_components()
    else:
        new_size += 1
    while curr_element < new_size:
        output += str(curr_element)
        curr_element += 1
    return output


class FlatLoad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.operand[0]
        self.vaddr = self.operand[1]
        self.inst_offset = self.operand[2].value

        self.dest_regs = get_reg_rang(self.vdst)
        self.start_to_registers = self.dest_regs[0]
        self.from_registers = get_reg_rang(self.vaddr)[0]

    def to_fill_node(self):
        if self.suffix in {"dword", "dwordx2", "dwordx4"}:
            variable = f"var{self.decompiler_data.num_of_var}"
            data_type = make_new_type_without_modifier(self.node, self.from_registers)
            self.decompiler_data.var_value[variable] = self.node.get_from_state(self.from_registers).val
            register_type = (
                RegisterType.KERNEL_ARGUMENT_PTR
                if self.node.get_from_state(self.from_registers).type == RegisterType.ADDRESS_KERNEL_ARGUMENT
                else RegisterType.KERNEL_ARGUMENT_ELEMENT
            )
            to_now = 0
            vector_position = 0
            reg_val = variable
            while True:
                node_type_hint: ExpressionValueTypeHint = (
                    self.node.get_from_state(self.from_registers).get_expression_node().value_type_hint
                )
                if node_type_hint.is_pointer and not node_type_hint.is_address:
                    node_type_hint = ExpressionValueTypeHint(node_type_hint.opencl_type)
                if node_type_hint.is_const:
                    node_type_hint = node_type_hint.set_is_const(False)
                if is_vector_type(data_type):
                    data_type = data_type[:-1]
                    if self.suffix[-1].isdigit():
                        reg_val = f"{variable}___s{vector_position}"
                        data_type += self.suffix[-1]
                        node_type_hint = node_type_hint.set_number_of_components(int(self.suffix[-1]))
                    else:
                        data_type = make_asm_type(data_type)
                        node_type_hint = node_type_hint.set_number_of_components(1)

                    vector_position += 1
                expr_node = self.expression_manager.add_variable_node(reg_val, node_type_hint)
                expr_node.value_type_hint = node_type_hint
                self.node = set_reg_value(
                    self.node,
                    reg_val,
                    self.dest_regs[to_now].name,
                    [],
                    data_type,
                    reg_type=register_type,
                    expression_node=expr_node,
                )
                to_now += 1
                if to_now == len(self.dest_regs):
                    break
            self.decompiler_data.make_var(
                self.node.get_from_state(self.start_to_registers).version,
                self.node.get_from_state(self.start_to_registers).val,
                data_type,
            )
            return self.node
        return super().to_fill_node()

    def to_print(self):
        expression_manager = ExpressionManager()
        if self.suffix in {"dword", "dwordx2", "dwordx4"}:
            if self.start_to_registers.name == self.from_registers.name:
                output_node: ExpressionNode = (
                    self.node.parent[0].get_from_state(self.from_registers).get_expression_node()
                )
            else:
                output_node: ExpressionNode = self.node.get_from_state(self.from_registers).get_expression_node()
            output = expression_manager.expression_to_string(output_node)
            if "[" not in output:
                start_to_registers_node: ExpressionNode = self.node.get_from_state(
                    self.start_to_registers
                ).get_expression_node()
                if start_to_registers_node.value_type_hint.opencl_type != output_node.value_type_hint.opencl_type:
                    output = f"*({output_node.value_type_hint!s})({output})"
                else:
                    output = f"*{output}"
            var_node: ExpressionNode = self.node.get_from_state(self.start_to_registers).get_expression_node()
            var_name = expression_manager.expression_to_string(var_node)
            if output_node.value_type_hint.is_vector_type():
                if var_name[-2] == "s" and var_name[-1].isdigit():
                    var_name = var_name[:-5]
                if output_node.value_type_hint.opencl_type != var_node.value_type_hint.opencl_type:
                    output = get_output_for_different_vector_types(
                        output, var_node.value_type_hint, output_node.value_type_hint
                    )
            self.output_string = f"{var_name} = {output}"
            return self.output_string
        return super().to_print()
