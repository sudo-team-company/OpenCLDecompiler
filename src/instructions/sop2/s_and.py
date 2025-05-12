from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import ExpressionOperationType
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.register import check_and_split_regs


class SAnd(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]
        self.ssrc1 = self.instruction[3]

    def to_print_unresolved(self):
        if self.suffix in {"b32", "b64"}:
            self.decompiler_data.write(f"{self.sdst} = {self.ssrc0} & {self.ssrc1} // {self.name}\n")
            self.decompiler_data.write(f"scc = {self.sdst} != 0\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in {"b32", "b64"}:
            if "exec" in {self.sdst, self.ssrc0, self.ssrc1}:
                if self.ssrc1 == "exec":
                    self.ssrc1, self.ssrc0 = self.ssrc0, self.ssrc1
                old_exec_condition = self.decompiler_data.exec_registers[self.ssrc0]
                new_cond = self.node.state[self.ssrc1].val

                new_exec_condition = old_exec_condition & new_cond
                self.decompiler_data.exec_registers[self.ssrc0] = new_exec_condition

                new_condition_node = self.get_expression_node(self.ssrc1)
                return set_reg_value(
                    self.node,
                    new_exec_condition.top(),
                    self.sdst,
                    [self.ssrc0, self.ssrc1],
                    None,
                    exec_condition=new_exec_condition,
                    expression_node=new_condition_node,
                )
            if self.ssrc0 in self.node.state and self.ssrc1 in self.node.state:
                ssrc0 = self.node.state[self.ssrc0]

                src0_node = self.get_expression_node(self.ssrc0)
                src1_node = self.get_expression_node(self.ssrc1)
                expr_node = self.expression_manager.add_operation(
                    src0_node, src1_node, ExpressionOperationType.AND, OpenCLTypes.from_string(self.suffix)
                )

                return set_reg_value(
                    node=self.node,
                    new_value=make_op(self.node, self.ssrc0, self.ssrc1, "&&", suffix=self.suffix),
                    to_reg=self.sdst,
                    from_regs=[self.ssrc0, self.ssrc1],
                    data_type=self.suffix,
                    reg_type=ssrc0.type,
                    integrity=ssrc0.integrity,
                    expression_node=expr_node,
                )
            expr_node = None
            if self.ssrc0 in self.node.state:
                reg = self.node.state[self.ssrc0]
                expr_node = self.get_expression_node(self.ssrc0)
            else:
                ssrc0 = check_and_split_regs(self.ssrc0)[0]
                reg = self.node.state[ssrc0]
                expr_node = self.get_expression_node(ssrc0)
            return set_reg_value(
                node=self.node,
                new_value=reg.val,
                to_reg=self.sdst,
                from_regs=[self.ssrc0, self.ssrc1],
                data_type=self.suffix,
                reg_type=reg.type,
                integrity=reg.integrity,
                expression_node=expr_node,
            )
        return super().to_fill_node()

    def to_print(self):
        if self.sdst == "exec":
            self.output_string = ExpressionManager().expression_to_string(self.get_expression_node("exec"))
        return self.output_string
