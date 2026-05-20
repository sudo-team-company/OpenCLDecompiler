from src.instructions.IRspecial.InitReg import InitReg as decInitReg
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.registers.reg import Reg_ty, Val


class InitReg(GenericInstruction):
    def __init__(self, destination: Reg_ty, value: Val):
        super().__init__("init", destination, value)

    def _get_normalize_opcode(self) -> str:
        return "s_init"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            decInitReg,
            self._get_normalize_opcode(),
            self.operands,
        )
