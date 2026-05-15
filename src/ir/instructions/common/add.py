from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.reg import Reg_ty, RegOrVal_ty

from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.instructions.types import IRType
from src.instructions.vop2.v_add import VAdd
from src.instructions.vop2.v_addc import VAddc


class Add(GenericInstruction):
    allowed_types = (IRType.U16, IRType.I16, IRType.U32, IRType.I32, IRType.U64, IRType.I64, IRType.F64)

    def __init__(
        self,
        destination: Reg_ty,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("add", destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        
    def _is_64bit(self) -> bool:
        return self.op_type in (IRType.U64, IRType.I64)
    
    def _get_normalize_opcode(self) -> str:
        if self.op_type == IRType.F64:
            return "v_add_f64"
        return "v_add_u32"
    

    def to_fill_node(self, state, parents):
        ctx = NodeLoweringContext(state, parents)
        if self.op_type == IRType.F64:
            return ctx.emit_backend(
                VAdd,
                self._get_normalize_opcode(),
                self.operands,
                "f64",
            )

        if not self._is_64bit():
            return ctx.emit_backend(
                VAdd,
                self._get_normalize_opcode(),
                self.operands,
                "u32",
            )

        return ctx.emit_backend(
            VAdd,
            self._get_normalize_opcode(),
            self.operands,
            "u64",
        )



class AddC(GenericInstruction):
    allowed_types = (IRType.U32,)

    def __init__(
        self,
        destination: Reg_ty,
        operand1: RegOrVal_ty,
        operand2: RegOrVal_ty,
        op_type: IRType,
    ):
        super().__init__("addc", destination, operand1, operand2, op_type=op_type)
        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        

    def _get_normalize_opcode(self) -> str:
        return "v_addc_u32"
    
    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            VAddc,
            self._get_normalize_opcode(),
            self.operands,
            "u32",
        )
