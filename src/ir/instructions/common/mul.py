from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Reg32, get_reg_rang, Val
from src.ir.instructions.generic import GenericInstruction

from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.vop2.v_mul_f32 import VMulF32
from src.instructions.vop3.v_mul_lo import VMulLo, VMulHi
from src.instructions.vop2.v_add import VAdd
from src.instructions.vop3.v_mad import VMad
from src.instructions.vop2.v_mac import VMac

class Mul24(GenericInstruction):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "mul_s" if signed else "mul_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.signed = signed


    def _get_normalize_opcode(self) -> str:
        return "v_mul_i32_i24"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VMulF32,
            "v_mul_i32_i24",
            self.operands,
            "i32_i24",
        )
    
class Mul_f(GenericInstruction):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        super().__init__("mul_f", destination, operand1, operand2, is_scalar=is_scalar)
        self.signed = signed


    def _get_normalize_opcode(self) -> str:
        return "v_mul_f32"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VMulF32,
            self._get_normalize_opcode(),
            self.operands,
            "f32",
        )
    
class Mac_f32(GenericInstruction):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        super().__init__("mac_f", destination, operand1, operand2, is_scalar=is_scalar)
        self.signed = signed


    def _get_normalize_opcode(self) -> str:
        return "v_mac_f32"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VMac,
            self._get_normalize_opcode(),
            self.operands,
            "f32",
        )


class MulLo(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "mul_s" if signed else "mul_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        self.signed = signed

    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64
    
    def _get_normalize_opcode(self) -> str:
        return "v_mul_lo_i32"
    

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        if not self._is_64bit():
            return ctx.emit_backend(
                VMulLo,
                self._get_normalize_opcode(),
                self.operands,
                "u32",
            )
        
        dest_lo, dest_hi = get_reg_rang(self.destination)
        op1_lo, op1_hi = get_reg_rang(self.operand1)
        op2_lo, op2_hi = get_reg_rang(self.operand2)
        ctx.emit_backend(VMulHi, "v_mul_hi_u32", [dest_lo, op1_lo, op2_lo],   "u32")
        ctx.emit_backend(VMulLo, "v_mul_lo_u32", [dest_hi, op1_lo, op2_hi],   "u32")
        ctx.emit_backend(VAdd,   "v_add_u32",    [dest_hi, dest_hi, dest_lo], "u32")
        ctx.emit_backend(VMulLo, "v_mul_lo_u32", [dest_lo, op1_hi, op2_lo],   "u32") 
        ctx.emit_backend(VAdd,   "v_add_u32",    [dest_hi, dest_hi, dest_lo], "u32")
        return ctx.emit_backend(VMulLo, "v_mul_lo_u32", [dest_lo, op1_lo, op2_lo], "u32")


class MulLo_s(MulLo):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, operand2, signed=True, is_scalar=is_scalar)




class MulHi(GenericInstruction):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "mul_hi_s" if signed else "mul_hi_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.signed = signed

    def _get_normalize_opcode(self) -> str:
        return "v_mul_hi_i32" if self.signed else "s_mul_hi_u32"
    
    def get_suffix(self):
        return "i32" if self.signed else "u32"

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VMulHi,
            self._get_normalize_opcode(),
            self.operands,
            self.get_suffix(),
        )


class MulHi_s(MulHi):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, operand2, signed=True, is_scalar=is_scalar)    


class MulWide(GenericInstruction):
    def __init__(self, destination: Reg_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, signed=False,  is_scalar=False):
        name =  "mul64_s" if signed else "mul64_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        self.signed = signed

    def _is_64bit(self) -> bool:
        return True

    def _get_normalize_opcode(self) -> str:
        return "v_mad_i64_i32"  if self.signed else "v_mad_u64_u32" 
    
    def get_suffix(self):
        return "i64_i32" if self.signed else "u64_u32"
    
    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        return ctx.emit_backend(
            VMad,
            self._get_normalize_opcode(),
            [self.destination, Val('0'), self.operand1, self.operand2, Val('0')],
            self.get_suffix(),
        )    
    
class MulWide_s(MulWide):
    def __init__(self, destination: Reg32, operand1: RegOrVal_ty, operand2: RegOrVal_ty, is_scalar=False):
        super().__init__(destination, operand1, operand2, signed=True, is_scalar=is_scalar)    

