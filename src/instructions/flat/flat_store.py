from src.base_instruction import BaseInstruction
from src.decompiler_data import make_new_type_without_modifier
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import (
    ExpressionNode,
    ExpressionType,
    ExpressionValueTypeHint,
)
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import get_reg_rang, is_reg
from src.register import is_vector_type


def get_vector_name(vector_element):
    if vector_element.find("__") != -1:
        separator = vector_element.find("__")
        vector_name = vector_element[:separator]
    else:
        vector_name = vector_element
    return vector_name


def get_vector_element_number(vector_element):
    separator = vector_element.find("__")
    return int(vector_element[separator + 4 :])


def is_same_name(src_registers):
    element_name = get_vector_name(src_registers[0])
    for element in src_registers[1:]:
        new_element_name = get_vector_name(element)
        if element_name != new_element_name:
            return False
    return True


def is_right_order(src_registers):
    element_number = get_vector_element_number(src_registers[0])
    for element in src_registers[1:]:
        new_element_number = get_vector_element_number(element)
        if element_number + 1 != new_element_number:
            return False
        element_number = new_element_number
    return True


class FlatStore(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vaddr = self.operand[0]
        self.vdata = self.operand[1]
        self.inst_offset = "0"

        self.to_registers, _ = get_reg_rang(self.vaddr)
        self.from_registers, self.from_registers_1 = get_reg_rang(self.vdata)[0], get_reg_rang(self.vdata)[-1]

    def to_fill_node(self):
        if self.suffix in {"dword", "dwordx2", "dwordx4", "byte", "short", "b32", "b64", "b8", "u8"}:
            suffix_size = 1
            if self.suffix[-1].isdigit():
                suffix_size = int(self.suffix[-1])
            for from_reg in get_reg_rang(self.vdata)[:suffix_size]:
                if is_reg(self.vaddr):
                    self.node.get_from_state(self.to_registers).copy_version_from(
                        self.node.parent[0].get_from_state(self.to_registers)
                    )
                    self.node.get_from_state(self.to_registers).cast_to(self.suffix)
                    self.node.get_from_state(self.to_registers).set_expression_node(
                        self.node.get_from_state(self.to_registers)
                        .get_expression_node()
                        .cast_to(OpenCLTypes.from_string(self.suffix))
                    )
                elif (
                    self.node.get_from_state(from_reg).data_type is not None
                    and "bytes" in self.node.get_from_state(from_reg).data_type
                ):
                    self.node.get_from_state(from_reg).cast_to(self.node.get_from_state(self.to_registers).data_type)
                    var_name = self.node.get_from_state(from_reg).val
                    self.decompiler_data.names_of_vars[var_name] = self.node.get_from_state(self.to_registers).data_type

                    expr_node: ExpressionNode = self.node.get_from_state(from_reg).get_expression_node()
                    while expr_node.type == ExpressionType.OP:
                        expr_node = expr_node.left
                    self.expression_manager.update_variable_type(
                        expr_node.value, self.get_expression_node(self.to_registers).value_type_hint
                    )
                elif not is_vector_type(self.node.get_from_state(from_reg).data_type) and not is_vector_type(
                    self.node.get_from_state(self.to_registers).data_type
                ):
                    val = self.node.get_from_state(from_reg).get_value()
                    if val[0] == "(":
                        val = val[val.find(")") + 1 :]
                    if val not in self.decompiler_data.names_of_vars:
                        self.node.get_from_state(from_reg).cast_to(
                            make_new_type_without_modifier(self.node, self.to_registers),
                        )
                        self.decompiler_data.names_of_vars[val] = self.node.get_from_state(from_reg).data_type
                        self.expression_manager.update_variable_type(
                            val, self.get_expression_node(self.to_registers).value_type_hint
                        )
                    else:
                        # init var - i32, gdata - i64. var = gdata -> var - i64
                        self.decompiler_data.names_of_vars[val] = self.node.get_from_state(from_reg).data_type
                        self.expression_manager.update_variable_type(
                            val, self.get_expression_node(from_reg).value_type_hint
                        )
            return self.node
        return super().to_fill_node()

    def to_print(self):
        if self.suffix in {"dword", "dwordx2", "dwordx4", "byte", "short", "b32", "b64", "b8"}:
            var_node = self.get_expression_node(self.to_registers)
            var = self.expression_manager.expression_to_string(var_node)
            if self.inst_offset == "inst_offset:4":
                var = f"{var}[get_global_id(0)]"
            elif "[" in var:
                var_node.value_type_hint.is_address = False
                var = ExpressionManager().expression_to_string(var_node)
            elif (
                var in self.decompiler_data.names_of_vars
                and ExpressionValueTypeHint.from_string(self.decompiler_data.names_of_vars[var]).opencl_type
                != var_node.value_type_hint.opencl_type
            ):
                var = f"*({var_node.value_type_hint!s})({var})"
            else:
                var = f"*{var}"
            if self.node.get_from_state(self.from_registers):
                if self.node.get_from_state(self.from_registers).val == "0" and self.node.get_from_state(
                    self.from_registers_1
                ):
                    self.output_string = ExpressionManager().expression_to_string(
                        self.node.get_from_state(self.from_registers_1).get_expression_node()
                    )
                elif var_node.value_type_hint.is_vector_type():
                    permute_node = ExpressionManager().add_permute_node_from_list(
                        [self.node.get_from_state(reg).get_expression_node() for reg in get_reg_rang(self.vdata)]
                    )
                    to_type = self.node.get_from_state(self.to_registers).get_expression_node().value_type_hint
                    self.output_string = ExpressionManager().expression_to_string(permute_node, to_type.opencl_type)
                else:
                    self.output_string = ExpressionManager().expression_to_string(
                        self.node.get_from_state(self.from_registers).get_expression_node()
                    )
            else:
                self.output_string = self.decompiler_data.initial_state[self.from_registers.name].val
            return f"{var} = {self.output_string}"

        return super().to_print()
