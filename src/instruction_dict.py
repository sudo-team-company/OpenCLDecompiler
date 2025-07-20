from src.instructions.ds.ds_add import DsAdd
from src.instructions.ds.ds_bpermute import DsBpermute
from src.instructions.ds.ds_read import DsRead
from src.instructions.ds.ds_read2 import DsRead2
from src.instructions.ds.ds_write import DsWrite
from src.instructions.ds.ds_write2 import DsWrite2
from src.instructions.flat.flat_atomic_add import FlatAtomicAdd
from src.instructions.flat.flat_load import FlatLoad
from src.instructions.flat.flat_store import FlatStore
from src.instructions.flat.global_load import GlobalLoad
from src.instructions.flat.global_store import GlobalStore
from src.instructions.smem.s_load import SLoad
from src.instructions.sop1.s_and_saveexec import SAndSaveexec
from src.instructions.sop1.s_getpc import SGetpc
from src.instructions.sop1.s_mov import SMov
from src.instructions.sop1.s_not import SNot
from src.instructions.sop1.s_or_saveexec import SOrSaveexec
from src.instructions.sop1.s_setpc import SSetpc
from src.instructions.sop1.s_sext import SSext
from src.instructions.sop1.s_swappc import SSwappc
from src.instructions.sop2.s_add import SAdd
from src.instructions.sop2.s_addc import SAddc
from src.instructions.sop2.s_and import SAnd
from src.instructions.sop2.s_andn2 import SAndn2
from src.instructions.sop2.s_ashr import SAshr
from src.instructions.sop2.s_bfe import SBfe
from src.instructions.sop2.s_cselect import SCselect
from src.instructions.sop2.s_lshl import SLshl
from src.instructions.sop2.s_lshr import SLshr
from src.instructions.sop2.s_min import SMin
from src.instructions.sop2.s_mul import SMul
from src.instructions.sop2.s_or import SOr
from src.instructions.sop2.s_sub import SSub
from src.instructions.sop2.s_xor import SXor
from src.instructions.sopc import SCmpEq, SCmpGe, SCmpGt, SCmpLe, SCmpLg, SCmpLt
from src.instructions.sopk.s_addk import SAddK
from src.instructions.sopk.s_cmpk_lg import SCmpkLg
from src.instructions.sopk.s_movk import SMovk
from src.instructions.sopk.s_mulk import SMulk
from src.instructions.sopk.s_setreg import SSetreg
from src.instructions.sopp.s_barrier import SBarrier
from src.instructions.sopp.s_branch import SBranch
from src.instructions.sopp.s_cbranch_execz import SCbranchExecz
from src.instructions.sopp.s_cbranch_scc0 import SCbranchScc0
from src.instructions.sopp.s_cbranch_scc1 import SCbranchScc1
from src.instructions.sopp.s_cbranch_vccnz import SCbranchVccnz
from src.instructions.sopp.s_cbranch_vccz import SCbranchVccz
from src.instructions.sopp.s_clause import SClause
from src.instructions.sopp.s_delay_alu import SDelayAlu
from src.instructions.sopp.s_endpgm import SEndpgm
from src.instructions.sopp.s_nop import SNop
from src.instructions.sopp.s_sendmsg import SSendmsg
from src.instructions.sopp.s_waitcnt import SWaitcnt
from src.instructions.vop1.v_cvt import VCvt
from src.instructions.vop1.v_mov import VMov
from src.instructions.vop1.v_rcp_iflag import VRcpIflag
from src.instructions.vop2.v_add import VAdd
from src.instructions.vop2.v_add_nc import VAddNc
from src.instructions.vop2.v_addc import VAddc
from src.instructions.vop2.v_and import VAnd
from src.instructions.vop2.v_ashrrev import VAshrrev
from src.instructions.vop2.v_cndmask import VCndmask
from src.instructions.vop2.v_dual_lshlrev import VDualLshlrev
from src.instructions.vop2.v_lshlrev import VLshlrev
from src.instructions.vop2.v_lshrrev import VLshrrev
from src.instructions.vop2.v_mac import VMac
from src.instructions.vop2.v_min import VMin
from src.instructions.vop2.v_mul_f32 import VMulF32
from src.instructions.vop2.v_or import VOr
from src.instructions.vop2.v_sub import VSub
from src.instructions.vop2.v_sub_nc import VSubNc
from src.instructions.vop2.v_subrev import VSubrev
from src.instructions.vop2.v_xor import VXor
from src.instructions.vop3.v_add3 import VAdd3
from src.instructions.vop3.v_add_lshl import VAddLshl
from src.instructions.vop3.v_alignbit import VAlignbit
from src.instructions.vop3.v_alignbyte import VAlignbyte
from src.instructions.vop3.v_and_or import VAndOr
from src.instructions.vop3.v_bfe import VBfe
from src.instructions.vop3.v_bfi import VBfi
from src.instructions.vop3.v_div_fixup import VDivFixup
from src.instructions.vop3.v_fma import VFma
from src.instructions.vop3.v_ldexp import VLdexp
from src.instructions.vop3.v_lshl_add import VLshlAdd
from src.instructions.vop3.v_lshl_or import VLshlOr
from src.instructions.vop3.v_mad import VMad
from src.instructions.vop3.v_mul_f64 import VMulF64
from src.instructions.vop3.v_mul_lo import VMulLo
from src.instructions.vop3.v_perm import VPerm
from src.instructions.vopc.v_cmp_eq import VCmpEq
from src.instructions.vopc.v_cmp_ge import VCmpGe
from src.instructions.vopc.v_cmp_gt import VCmpGt
from src.instructions.vopc.v_cmp_le import VCmpLe
from src.instructions.vopc.v_cmp_lg import VCmpLg
from src.instructions.vopc.v_cmp_lt import VCmpLt
from src.instructions.vopc.v_cmp_ne import VCmpNe
from src.instructions.vopc.v_cmpx_class import VCmpxClass
from src.instructions.vopc.v_cmpx_eq import VCmpxEq
from src.instructions.vopc.v_cmpx_le import VCmpxLe
from src.instructions.vopd.v_dual_add import VDualAdd
from src.instructions.vopd.v_dual_add_nc import VDualAddNc
from src.instructions.vopd.v_dual_and import VDualAnd
from src.instructions.vopd.v_dual_mov import VDualMov

instruction_dict = {
    "ds_add": DsAdd,
    "ds_bpermute": DsBpermute,
    "ds_read": DsRead,
    "ds_read2": DsRead2,
    "ds_write": DsWrite,
    "ds_write2": DsWrite2,
    "flat_atomic_add": FlatAtomicAdd,
    "flat_load": FlatLoad,
    "flat_store": FlatStore,
    "global_load": GlobalLoad,
    "global_store": GlobalStore,
    "s_add": SAdd,
    "s_addc": SAddc,
    "s_and": SAnd,
    "s_and_saveexec": SAndSaveexec,
    "s_andn2": SAndn2,
    "s_ashr": SAshr,
    "s_barrier": SBarrier,
    "s_bfe": SBfe,
    "s_branch": SBranch,
    "s_cbranch_execz": SCbranchExecz,
    "s_cbranch_scc0": SCbranchScc0,
    "s_cbranch_scc1": SCbranchScc1,
    "s_cbranch_vccnz": SCbranchVccnz,
    "s_cbranch_vccz": SCbranchVccz,
    "s_cmp_eq": SCmpEq,
    "s_cmp_lg": SCmpLg,
    "s_cmp_ge": SCmpGe,
    "s_cmp_gt": SCmpGt,
    "s_cmp_lt": SCmpLt,
    "s_cmp_le": SCmpLe,
    "s_cselect": SCselect,
    "s_endpgm": SEndpgm,
    "s_getpc": SGetpc,
    "s_load": SLoad,
    "s_lshl": SLshl,
    "s_lshr": SLshr,
    "s_min": SMin,
    "s_mov": SMov,
    "s_movk": SMovk,
    "s_mul": SMul,
    "s_mulk": SMulk,
    "s_not": SNot,
    "s_nop": SNop,
    "s_or": SOr,
    "s_setpc": SSetpc,
    "s_setreg": SSetreg,
    "s_sub": SSub,
    "s_subb": SSub,
    "s_swappc": SSwappc,
    "s_waitcnt": SWaitcnt,
    "v_add": VAdd,
    "v_addc": VAddc,
    "v_alignbit": VAlignbit,
    "v_alignbyte": VAlignbyte,
    "v_and": VAnd,
    "v_and_or": VAndOr,
    "v_ashrrev": VAshrrev,
    "v_bfi": VBfi,
    "v_cmp_eq": VCmpEq,
    "v_cmp_ne": VCmpNe,
    "v_cmp_ge": VCmpGe,
    "v_cmp_gt": VCmpGt,
    "v_cmp_lg": VCmpLg,
    "v_cmp_lt": VCmpLt,
    "v_cmpx_class": VCmpxClass,
    "v_cmpx_eq": VCmpxEq,
    "v_cmpx_le": VCmpxLe,
    "v_cndmask": VCndmask,
    "v_cvt": VCvt,
    "v_div_fixup": VDivFixup,
    "v_fma": VFma,
    "v_ldexp": VLdexp,
    "v_lshlrev": VLshlrev,
    "v_dual_lshlrev": VDualLshlrev,
    "v_lshrrev": VLshrrev,
    "v_mac": VMac,
    "v_min": VMin,
    "v_mul_i32_i24": VMulF32,
    "v_mul_f32": VMulF32,
    "v_mul_f64": VMulF64,
    "v_mul_hi": VMulLo,
    "v_mul_lo": VMulLo,
    "v_mov": VMov,
    "v_perm": VPerm,
    "v_readfirstlane": VMov,
    "v_sub": VSub,
    "v_subb": VSub,
    "v_subrev": VSubrev,
    "v_xor": VXor,
    # rocm specific instructions
    "s_addk": SAddK,
    "s_clause": SClause,
    "s_cmpk_lg": SCmpkLg,
    "s_delay_alu": SDelayAlu,
    "s_mul_hi": VMulLo,
    "s_or_saveexec": SOrSaveexec,
    "s_sendmsg": SSendmsg,
    "s_sext": SSext,
    "s_waitcnt_decptr": SWaitcnt,
    "s_waitcnt_depctr": SWaitcnt,
    "s_xor": SXor,
    "v_add3": VAdd3,
    "v_add_co": VAdd,
    "v_add_co_ci": VAddc,
    "v_add_lshl": VAddLshl,
    "v_add_nc": VAddNc,
    "v_bfe": VBfe,
    "v_cmp_le": VCmpLe,
    "v_dual_add": VDualAdd,
    "v_dual_add_nc": VDualAddNc,
    "v_dual_and": VDualAnd,
    "v_dual_mov": VDualMov,
    "v_lshl_or": VLshlOr,
    "v_lshl_add": VLshlAdd,
    "v_or": VOr,
    "v_mad": VMad,
    "v_mul_u32_u24": VMulF32,
    "v_subrev_nc": VSubNc,
    "v_sub_nc": VSubNc,
    "v_subrev_co_ci": VSubrev,
    "v_sub_co": VSub,
    "v_sub_co_ci": VSub,
    "v_rcp_iflag": VRcpIflag,
}
