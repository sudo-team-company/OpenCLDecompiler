from src.instructions.IRspecial.ChangeMask import Unmask as be_Unmask
from src.instructions.IRspecial.ChangeMask import UseMask
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.registers.reg import PredReg


class ChangeMask(GenericInstruction):
    def __init__(self, predicate: PredReg):
        super().__init__("change_mask", predicate)
        self.predicate = predicate

    def _get_normalize_opcode(self):
        return "change_mask"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            UseMask,
            self._get_normalize_opcode(),
            self.operands,
        )

    def writes_first_operand(self) -> bool:
        return False

    def has_side_effects(self) -> bool:
        return True


class Unmask(GenericInstruction):
    def __init__(self):
        super().__init__("unmask")

    def _get_normalize_opcode(self):
        return "unmask"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            be_Unmask,
            self._get_normalize_opcode(),
            [],
        )

    def writes_first_operand(self) -> bool:
        return False

    def has_side_effects(self) -> bool:
        return True
