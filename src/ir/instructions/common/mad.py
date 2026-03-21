from src.ir.registers.reg import Reg_ty, RegOrVal_ty, Reg32, CompositeReg
from src.ir.instructions.special.generic import GenericInstruction
from src.ir.registers.register_manager import RegisterManager, IDENTITY_MANAGER
from src.ir.TemporaryVariableAllocator import tva

class Mad(GenericInstruction):
    def __init__(self, destination: RegOrVal_ty, operand1: RegOrVal_ty, operand2: RegOrVal_ty, operand3: RegOrVal_ty, signed=True,  is_scalar=False):
        if destination.bit_width == 32:
            dest_name = tva.generate("mad_dest")
            dest_hi = Reg32(tva.generate("dest_hi"))
            destination = CompositeReg(dest_name, [destination, dest_hi])

        name =  "mad_s" if signed else "mad_u"   
        super().__init__(name, destination, operand1, operand2, is_scalar=is_scalar)


        self.destination = destination
        self.operand1 = operand1
        self.operand2 = operand2
        self.operand3 = operand3
        self.signed = signed


    def _is_64bit(self) -> bool:
        return self.destination.bit_width == 64

    def _get_normalize_opcode(self) -> str:
        return "v_mad_i64_i32"  if self.signed else "v_mad_u64_u32" 

    def get_parts(self, manager: RegisterManager = IDENTITY_MANAGER) -> list[list[str]]:
        opcode = self._get_normalize_opcode()
        dest_str = manager.map(self.destination)
        op1_str = manager.map(self.operand1)
        op2_str = manager.map(self.operand2)
        op3_str = manager.map(self.operand3)

        return [[opcode, dest_str, '0', op1_str, op2_str, op3_str]]