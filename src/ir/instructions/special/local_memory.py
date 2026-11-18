from src.instructions.ds.ds_add import DsAdd
from src.instructions.ds.ds_read import DsRead
from src.instructions.ds.ds_write import DsWrite
from src.instructions.ir_special.local_mem import LocalMemory as DecLocalMemory
from src.instructions.sop1.s_mov import SMov
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.ir.registers.reg import Reg32, Reg64, Reg_ty, RegOrVal_ty, Val
from src.ir.temporary_variable_allocator import TemporaryVariableAllocator
from src.node_effects import NodeEffects


class LocalMemory(GenericInstruction):
    def __init__(self, destination: Reg64, size):
        super().__init__("local", destination, size)

    def _get_normalize_opcode(self) -> str:
        return "s_local"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents, self).emit_backend(
            DecLocalMemory,
            self._get_normalize_opcode(),
            self.operands,
        )


class LocalStore(GenericInstruction):
    allowed_types = (IRType.B32,)

    def __init__(self, destination: Reg_ty, val: Reg_ty, op_type: IRType):
        super().__init__("local_store", destination, val, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        return "ds_write_b32"

    def writes_first_operand(self) -> bool:
        return False  # the first operand is the address

    def has_side_effects(self) -> bool:
        return True

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents, self).emit_backend(DsWrite, "ds_write_b32", self.operands, "b32")


class LocalLoad(GenericInstruction):
    allowed_types = (IRType.B32,)

    def __init__(self, destination: Reg64, from_mem: Reg_ty, op_type: IRType):
        super().__init__("local_load", destination, from_mem, op_type=op_type)

    def _get_normalize_opcode(self) -> str:
        return "ds_read_b32"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents, self).emit_backend(
            DsRead, self._get_normalize_opcode(), self.operands, "b32"
        )


class LocalAdd(GenericInstruction):
    allowed_types = (IRType.U32, IRType.I32)

    def __init__(self, destination: Reg64, val: RegOrVal_ty, op_type: IRType):
        super().__init__("local_add", destination, val, op_type=op_type)
        self.operand1_val: Val | None = None
        self.operand1_tmp_reg: Reg32 | None = None

        if isinstance(val, Val):
            tmp_reg_name = TemporaryVariableAllocator.generate("ladd")
            self.operand1_tmp_reg = Reg32(tmp_reg_name)
            self.operand1_val = val

        self.destination = destination
        self.operand1 = val

    def _get_normalize_opcode(self) -> str:
        return "ds_add_u32"

    def writes_first_operand(self) -> bool:
        return False  # the first operand is the address, the result is not returned

    def has_side_effects(self) -> bool:
        return True

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents, self)
        if self.operand1_val is not None:
            ctx.emit_backend(SMov, "s_mov_b32", [self.operand1_tmp_reg, self.operand1_val], "b32")
            add_operands = [self.destination, self.operand1_tmp_reg]
            return ctx.emit_backend(
                DsAdd,
                "ds_add_u32",
                add_operands,
                "u32",
                effects=NodeEffects.from_operands(add_operands, writes_first_operand=False, has_side_effects=True),
            )

        return ctx.emit_backend(DsAdd, "ds_add_u32", [self.destination, self.operand1], "u32")
