from src.ir.registers.reg import Reg_ty, RegOrVal_ty
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.vop2.v_lshlrev import VLshlrev
from src.instructions.vop2.v_lshrrev import VLshrrev
from src.instructions.vop2.v_ashrrev import VAshrrev


class ShiftInstruction(GenericInstruction):
    def __init__(self, name: str, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64
    
    def get_suffix(self):
        if self._is_64bit():
            return "b64"
        return "b32"


class LShl_Rev(ShiftInstruction):
    def __init__(self, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__("lshl", destination, operand1, operand2, is_scalar=is_scalar)

    def _get_normalize_opcode(self) -> str:
        if self._is_64bit():
            return "v_lshlrev_b64"
        return "v_lshlrev_b32"
    
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VLshlrev,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )


class LShr_Rev(ShiftInstruction):
    def __init__(self, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__("rshl", destination, operand1, operand2, is_scalar=is_scalar)


    def _get_normalize_opcode(self) -> str:
        if self._is_64bit():
            return "v_lshrrev_b64"
        return "v_lshrrev_b32"
        
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VLshrrev,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )

class AShr_Rev(ShiftInstruction):
    def __init__(self, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__("rshl", destination, operand1, operand2, is_scalar=is_scalar)

    def _get_normalize_opcode(self) -> str:
        if self._is_64bit():
            return "v_ashrrev_i64"
        return "v_ashrrev_i32"
 
    def get_suffix(self):
        if self._is_64bit():
            return "i64"
        return "i32"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VAshrrev,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )
    
class LShl(LShl_Rev):
    def __init__(self, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__(destination, operand2, operand1, is_scalar=is_scalar)

class LShr(LShr_Rev):
    def __init__(self, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__(destination, operand2, operand1, is_scalar=is_scalar)

class AShr(AShr_Rev):
    def __init__(self, destination: Reg_ty, operand1: Reg_ty, operand2: RegOrVal_ty, is_scalar):
        super().__init__(destination, operand2, operand1, is_scalar=is_scalar)