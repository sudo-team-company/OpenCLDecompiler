from src.ir.instructions.common.add import Add, AddC
from src.ir.instructions.common.logical import And
from src.ir.instructions.common.sub import Sub, SubRev
from src.ir.instructions.common.mul import MulHi, MulLo, MulHi_s, MulLo_s, Mul24
from src.ir.instructions.common.mad import Mad
from src.ir.instructions.common.lshl import LShl, LShl_Rev, LShr, LShr_Rev, AShr, AShr_Rev
from src.ir.instructions.common.mov import Mov
from src.ir.instructions.common.load import Load32, Load64, Load128
from src.ir.instructions.common.store import Store8, Store32, Store64, Store128
from src.ir.instructions.common.bfe import bfe, bfe_s
from src.ir.instructions.common.endpgm import EndPgm
from src.ir.instructions.ignore import Ignore

instruction_dict = {
        'v_add_u32': Add,
        's_add_u32': Add,
        'v_addc_u32': AddC,
        's_addc_u32': AddC,
        
        's_sub_u32': Sub,
        'v_subrev_u32': SubRev,
        'v_sub_u32': Sub, 
        's_subb_u32': Sub,
        'v_subb_u32': Sub,
        
        'v_mul_u32': MulLo,
        's_mul_u32': MulLo,
        'v_mul_hi_u32': MulHi,
        's_mul_hi_u32': MulHi,
        'v_mul_lo_u32': MulLo,
        's_mul_lo_u32': MulLo,
        'v_mul_i32': MulLo_s,
        's_mul_i32': MulLo_s,
        'v_mul_hi_i32': MulHi_s,
        's_mul_hi_i32': MulHi_s,
        'v_mul_i32_i24': Mul24,
        
        'v_mad_u32': Mad,
        's_mad_u32': Mad,
        
        'v_lshl_b32': LShl,
        's_lshl_b32': LShl,
        's_lshl_b64': LShl,
        'v_lshlrev_b32': LShl_Rev,
        's_lshlrev_b32': LShl_Rev,
        'v_lshlrev_b64': LShl_Rev,
        'v_lshr_b32': LShr,
        's_lshr_b32': LShr,
        'v_lshrrev_b32': LShr_Rev,
        's_lshrrev_b32': LShr_Rev,
        'v_lshrrev_b64': LShr_Rev,
        's_ashr_i32': AShr,
        
        's_and_b32': And,
        'v_and_b32': And,
        
        'v_mov_b32': Mov,
        's_mov_b32': Mov,
        's_mov_b64': Mov,
        's_movk_i32': Mov,

        's_load_dword': Load32,
        's_load_dwordx2': Load64,
        's_load_dwordx4': Load128,
        'flat_load_dword': Load32,
        'flat_load_dwordx2': Load64,
        'flat_load_dwordx4': Load128,
        
        'flat_store_byte': Store8,
        'flat_store_dword': Store32,
        'flat_store_dwordx2': Store64,
        'flat_store_dwordx4': Store128,
        's_store_dword': Store32,
        's_store_dwordx2': Store64,

        's_bfe_u32': bfe,
        'v_bfe_u32': bfe,
        's_bfe_i32': bfe_s,
        'v_bfe_i32': bfe_s,

        's_endpgm': EndPgm,

        's_waitcnt': Ignore,
}