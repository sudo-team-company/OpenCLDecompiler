from src.ir.registers.reg import is_predicate
from src.logical_variable import ExecCondition

from ...base_instruction import BaseInstruction
from ...decompiler_data import compare_values
from ...node import Node


class VCmp(BaseInstruction):
    def __init__(self, node: Node, suffix: str, op: str):
        super().__init__(node, suffix)
        self.op: str = op

    @property
    def d0(self) -> str:
        return self.operand[0]

    @property
    def s0(self) -> str:
        return self.operand[1]

    @property
    def s1(self) -> str:
        return self.operand[2]

    def to_fill_node(self):
        if self.suffix in {"i16", "i32", "i64", "u16", "u32", "u64", "f16", "f32", "f64"}:
            res_node = compare_values(self.node, self.d0, self.s0, self.s1, self.op, self.suffix)
            if is_predicate(self.d0):
                self.decompiler_data.exec_registers[self.d0.name] = ExecCondition(
                    [res_node.get_from_state(self.d0).val]
                )
            return res_node
        return super().to_fill_node()
