from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.instructions.vop2.v_lshlrev import VLshlrev
from src.integrity import Integrity
from src.register import check_and_split_regs, is_reg, Register
from src.register_type import RegisterType
from src.sum_register import SumRegister


class VDualLshlrev(VLshlrev):
    pass