from src.instructions.ds.ds_add import DsAdd
from src.instructions.ds.ds_read import DsRead
from src.instructions.ds.ds_write import DsWrite
from src.instructions.flat.flat_load import FlatLoad
from src.instructions.flat.flat_store import FlatStore
from src.instructions.ir_special.change_mask import Unmask, UseMask
from src.instructions.ir_special.global_mem import GlobalMemory
from src.instructions.ir_special.init_pred import InitPred
from src.instructions.ir_special.init_reg import InitReg
from src.instructions.ir_special.local_mem import LocalMemory
from src.instructions.ir_special.memory import MemoryAllocation, StoreInMem
from src.instructions.smem.s_load import SLoad
from src.instructions.sop1.s_mov import SMov
from src.instructions.sop1.s_not import SNot
from src.instructions.sop2.s_add import SAdd
from src.instructions.sop2.s_addc import SAddc
from src.instructions.sop2.s_and import SAnd
from src.instructions.sop2.s_bfe import SBfe
from src.instructions.sop2.s_min import SMin
from src.instructions.sop2.s_mul import SMul
from src.instructions.sop2.s_or import SOr
from src.instructions.sop2.s_xor import SXor
from src.instructions.sopp.s_branch import SBranch
from src.instructions.sopp.s_cbranch_vccnz import SCbranchVccnz
from src.instructions.sopp.s_cbranch_vccz import SCbranchVccz
from src.instructions.sopp.s_endpgm import SEndpgm
from src.instructions.sopp.s_nop import SNop
from src.instructions.sopp.s_waitcnt import SWaitcnt
from src.instructions.vop1.v_cvt import VCvt
from src.instructions.vop1.v_mov import VMov
from src.instructions.vop2.v_add import VAdd
from src.instructions.vop2.v_addc import VAddc
from src.instructions.vop2.v_ashrrev import VAshrrev
from src.instructions.vop2.v_cndmask import VCndmask
from src.instructions.vop2.v_lshlrev import VLshlrev
from src.instructions.vop2.v_lshrrev import VLshrrev
from src.instructions.vop2.v_mac import VMac
from src.instructions.vop2.v_mul_f32 import VMulF32
from src.instructions.vop2.v_sub import VSub
from src.instructions.vop3.v_mad import VMad
from src.instructions.vop3.v_mul_lo import VMulLo
from src.instructions.vop3.v_perm import VPerm
from src.instructions.vopc.v_cmp_eq import VCmpEq
from src.instructions.vopc.v_cmp_ge import VCmpGe
from src.instructions.vopc.v_cmp_gt import VCmpGt
from src.instructions.vopc.v_cmp_le import VCmpLe
from src.instructions.vopc.v_cmp_lg import VCmpLg
from src.instructions.vopc.v_cmp_lt import VCmpLt
from src.instructions.vopc.v_cmp_ne import VCmpNe

instruction_dict = {
    "s_alloc": MemoryAllocation,
    "s_store": StoreInMem,
    "s_init": InitReg,
    "s_init_global": GlobalMemory,
    "s_ipred": InitPred,
    "ds_add": DsAdd,
    "ds_read": DsRead,
    "ds_write": DsWrite,
    "s_local": LocalMemory,
    "change_mask": UseMask,
    "unmask": Unmask,
    "flat_load": FlatLoad,
    "flat_store": FlatStore,
    "s_add": SAdd,
    "s_addc": SAddc,
    "s_and": SAnd,
    "s_bfe": SBfe,
    "s_branch": SBranch,
    "s_br": SCbranchVccnz,
    "s_nbr": SCbranchVccz,
    "s_endpgm": SEndpgm,
    "s_load": SLoad,
    "s_min": SMin,
    "s_mov": SMov,
    "s_mul": SMul,
    "s_not": SNot,
    "s_nop": SNop,
    "s_or": SOr,
    "s_waitcnt": SWaitcnt,
    "v_add": VAdd,
    "v_addc": VAddc,
    "v_ashrrev": VAshrrev,
    "v_cmp_eq": VCmpEq,
    "v_cmp_ne": VCmpNe,
    "v_cmp_ge": VCmpGe,
    "v_cmp_gt": VCmpGt,
    "v_cmp_lg": VCmpLg,
    "v_cmp_lt": VCmpLt,
    "v_cndmask": VCndmask,
    "v_cvt": VCvt,
    "v_lshlrev": VLshlrev,
    "v_lshrrev": VLshrrev,
    "v_mac": VMac,
    "v_mul_i32_i24": VMulF32,
    "v_mul_f32": VMulF32,
    "v_mul_hi": VMulLo,
    "v_mul_lo": VMulLo,
    "v_mov": VMov,
    "v_perm": VPerm,
    "v_readfirstlane": VMov,
    "v_sub": VSub,
    "v_subb": VSub,
    "s_mul_hi": VMulLo,
    "s_waitcnt_decptr": SWaitcnt,
    "s_waitcnt_depctr": SWaitcnt,
    "s_xor": SXor,
    "v_add_co": VAdd,
    "v_add_co_ci": VAddc,
    "v_cmp_le": VCmpLe,
    "v_mad": VMad,
    "v_mul_u32_u24": VMulF32,
    "v_sub_co": VSub,
    "v_sub_co_ci": VSub,
}
