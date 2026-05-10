from src.ir.registers.reg import RegOrVal_ty, Reg32, CompositeReg, Val, Reg64, get_reg_rang
from src.ir.instructions.generic import GenericInstruction
from src.ir.TemporaryVariableAllocator import tva
from typing import Optional
from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.vop3.v_mad import VMad
from src.instructions.sop1.s_mov import SMov


class Mad(GenericInstruction):
    def __init__(self, destination: RegOrVal_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, operand3: RegOrVal_ty, signed=True,  is_scalar=False):
        self.operand3_val: Optional[Val] = None
        self.operand3_tmp_reg: Optional[Reg64] = None
        
        if isinstance(operand3, Val):
            tmp_reg_name = tva.generate("mad")
            self.operand3_tmp_reg = Reg64(tmp_reg_name)
            self.operand3_val = operand3

        if destination.bit_width == 32:
            dest_name = tva.generate("mad_dest")
            dest_hi = Reg32(tva.generate("dest_hi"))
            destination = CompositeReg(dest_name, [destination, dest_hi])

        name =  "mad_s" if signed else "mad_u"   
        super().__init__(name, destination, operand1, operand2, operand3, is_scalar=is_scalar)


        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        self.operand3 = operand3
        self.signed = signed

    def _get_normalize_opcode(self) -> str:
        return "v_mad_i64_i32"  if self.signed else "v_mad_u64_u32" 
    
    def get_suffix(self) -> str:
        return "i64_i32"  if self.signed else "u64_u32" 
    
    
    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        if self.operand3_val is not None:
            tmp_lo, tmp_hi = get_reg_rang(self.operand3_tmp_reg)
            ctx.emit_backend(SMov, "s_mov_b32", [tmp_lo, self.operand3_val], "b32")
            ctx.emit_backend(SMov, "s_mov_b32", [tmp_hi, Val('0')], "b32")
            return ctx.emit_backend(
                VMad,
                self._get_normalize_opcode(),
                [self.destination, Val('0'), self.operand1, self.operand2, self.operand3_tmp_reg],
                self.get_suffix(),
            )
        return ctx.emit_backend(
            VMad,
            self._get_normalize_opcode(),
            [self.destination, Val('0'), self.operand1, self.operand2, self.operand3],
            self.get_suffix(),
        )  