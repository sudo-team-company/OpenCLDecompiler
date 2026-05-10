from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.reg import Reg64, Reg_ty, Val, RegOrVal_ty, Reg32
from typing import Optional
from src.ir.TemporaryVariableAllocator import tva


from src.ir.instructions.lowering import NodeLoweringContext
from src.instructions.IRspecial.LocalMem import LocalMemory as DecLocalMemory
from src.instructions.ds.ds_write import DsWrite
from src.instructions.ds.ds_read import DsRead
from src.instructions.ds.ds_add import DsAdd
from src.instructions.sop1.s_mov import SMov


class LocalMemory(GenericInstruction):
    def __init__(self, destination: Reg64, size, is_scalar: bool = True):
        super().__init__("local", destination, size, is_scalar=is_scalar)
    def _get_normalize_opcode(self) -> str:
        return "s_local"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            DecLocalMemory,
            self._get_normalize_opcode(),
            self.operands,
        )
    

class LocalStore(GenericInstruction):
    def __init__(self, destination: Reg_ty, val: Reg_ty, is_scalar: bool = True):
        super().__init__("local_store", destination, val, is_scalar=is_scalar)
    def _get_normalize_opcode(self) -> str:
        return "ds_write_b32"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            DsWrite,
            "ds_write_b32",
            self.operands,
            "b32"
        )


class LocalLoad(GenericInstruction):
    def __init__(self, destination: Reg64, from_mem: Reg_ty, is_scalar: bool = True):
        super().__init__("local_load", destination, from_mem, is_scalar=is_scalar)
    def _get_normalize_opcode(self) -> str:
        return "ds_read_b32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            DsRead,
            self._get_normalize_opcode(),
            self.operands,
            "b32"
        )

class LocalAdd(GenericInstruction):
    def __init__(self, destination: Reg64, val: RegOrVal_ty, is_scalar: bool = True):
        super().__init__("local_add", destination, val, is_scalar=is_scalar)
        self.operand1_val: Optional[Val] = None
        self.operand1_tmp_reg: Optional[Reg32] = None
        
        if isinstance(val, Val):
            tmp_reg_name = tva.generate("ladd")
            self.operand1_tmp_reg = Reg32(tmp_reg_name)
            self.operand1_val = val

        self.destination = destination
        self.operand1 = val


    def _get_normalize_opcode(self) -> str:
        return "ds_add_u32"
    
    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        if self.operand1_val is not None:
            ctx.emit_backend(SMov, "s_mov_b32", [self.operand1_tmp_reg, self.operand1_val], "b32")
            return ctx.emit_backend(DsAdd, "ds_add_u32", [self.destination, self.operand1_tmp_reg], "u32")
        
        return ctx.emit_backend(DsAdd, "ds_add_u32", [self.destination, self.operand1], "u32")