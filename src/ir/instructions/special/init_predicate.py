from src.instructions.ir_special.init_pred import InitPred
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.registers.reg import PredReg


class InitPredicate(GenericInstruction):
    def __init__(self, predicate: PredReg):
        super().__init__("init_pred", predicate)
        self.predicate = predicate

    def _get_normalize_opcode(self):
        return "s_ipred"

    def get_written_registers(self) -> tuple[PredReg, ...]:
        return ()

    def writes_first_operand(self) -> bool:
        return False

    def has_side_effects(self) -> bool:
        return True

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            InitPred,
            self._get_normalize_opcode(),
            self.operands,
        )
