from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.reg import PredReg, Val
from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.sopp.s_cbranch_vccnz import SCbranchVccnz
from src.instructions.sopp.s_cbranch_vccz import SCbranchVccz
from src.instructions.sopp.s_branch import SBranch
from src.instructions.label import Label as backend_Label

class Label(GenericInstruction):
    def __init__(self, name: Val, is_scalar: bool = True):
        super().__init__("label", name, is_scalar=is_scalar)
        self.name = name

    def to_text(self) -> str:
        return f"label {self.name.to_text()}"

    def writes_first_operand(self) -> bool:
        return False

    def is_control_flow(self) -> bool:
        return True

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            backend_Label,
            self.name,
            [],
        )

class Branch(GenericInstruction):
    def __init__(self, predicate: PredReg, target: Val, is_scalar: bool = True):
        super().__init__("bra", predicate, target, is_scalar=is_scalar)
        self.target = target

    def writes_first_operand(self) -> bool:
        return False

    def is_control_flow(self) -> bool:
        return True
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SCbranchVccnz,
            "s_br",
            self.operands,
        )
    

class BranchNot(GenericInstruction):
    def __init__(self, predicate: PredReg, target: Val, is_scalar: bool = True):
        super().__init__("bra_n", predicate, target, is_scalar=is_scalar)
        self.target = target

    def writes_first_operand(self) -> bool:
        return False

    def is_control_flow(self) -> bool:
        return True
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SCbranchVccz,
            "s_nbr",
            self.operands,
        )
class Jump(Branch):
    def __init__(self, target: Val, is_scalar: bool = True):
        super().__init__("jump", target, is_scalar=is_scalar)
        self.target = target

    def writes_first_operand(self) -> bool:
        return False

    def is_control_flow(self) -> bool:
        return True
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            SBranch,
            "s_branch",
            self.operands,
        )