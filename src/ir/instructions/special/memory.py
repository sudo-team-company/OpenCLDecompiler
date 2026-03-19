from src.ir.instructions.special.generic import GenericInstruction
from src.ir.registers.reg import Reg64, Reg_ty, Val

class MemoryAllocation(GenericInstruction):
    def __init__(self, destination: Reg64):
        super().__init__("s_alloc", destination)
    

class Store(GenericInstruction):
    def __init__(self, destination: Reg_ty, arg_name: Val, arg_type: Val, offset: Val):
        super().__init__("s_store", destination, arg_type, arg_name, offset)
