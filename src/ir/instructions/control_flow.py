from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.reg import PredReg, Val
from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.sopp.s_cbranch_vccnz import SCbranchVccnz
from src.instructions.sopp.s_cbranch_vccz import SCbranchVccz
from src.instructions.sopp.s_branch import SBranch
from src.instructions.label import Label as backend_Label

class Label(GenericInstruction):
    def __init__(self, label: Val):
        super().__init__("label", label)
        self.label = label

    def writes_first_operand(self) -> bool:
        return False

    def is_control_flow(self) -> bool:
        return True

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            backend_Label,
            self.label.name,
            [],
        )

class Branch(GenericInstruction):
    def __init__(self, predicate: PredReg, target: Val):
        super().__init__("bra", predicate, target)
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
    def __init__(self, predicate: PredReg, target: Val):
        super().__init__("bra_n", predicate, target)
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
    

class Jump(GenericInstruction):
    def __init__(self, target: Val):
        super().__init__("jump", target)
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
