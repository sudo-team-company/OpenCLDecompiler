from src.ir.instructions.common.add import Add
from src.ir.instructions.common.logical import And
from src.ir.instructions.common.sub import Sub
from src.ir.instructions.common.mul import MulHi, MulLo, MulHi_s, MulLo_s, MulWide, MulWide_s
from src.ir.instructions.common.mad import Mad
from src.ir.instructions.common.lshl import LShl
from src.ir.instructions.common.mov import Mov
from src.ir.instructions.common.load import  Load32, Load64
from src.ir.instructions.common.store import Store8, Store32, Store64
from src.ir.instructions.common.bfe import bfe, bfe_s
from src.ir.instructions.common.endpgm import EndPgm
from src.ir.instructions.common.cvt import Cvt64_32, Cvt32_16, Cvt64_32_s
from src.ir.instructions.common.barrier import Barrier
from src.ir.instructions.special.local_memory import LocalAdd, LocalStore, LocalLoad

instruction_dict = {
        'add.s32': Add,
        'add.s64': Add,
        'add.s16': Add,

        'sub.s32': Sub,
        'sub.s64': Sub,
        'sub.s16': Sub,


        'mul.lo.s16': MulLo_s,
        'mul.lo.s32': MulLo_s,
        'mul.hi.s32': MulHi_s,
        'mul.lo.u32': MulLo,
        'mul.hi.u32': MulHi,
        'mul.wide.s32': MulWide_s,
        'mul.wide.u32': MulWide, 
        'mul.lo.s64': MulLo,
        
        'mad.lo.s32': Mad,

        'mov.u16': Mov,
        'mov.b32': Mov,
        'mov.u32': Mov,
        'mov.b64': Mov,
        'mov.u64': Mov,

        'cvt.s64.s32': Cvt64_32_s,
        'cvt.u64.u32': Cvt64_32,
        'cvt.u16.u32': Cvt32_16,

        'shl.b16': LShl,
        'shl.b32': LShl,
        'shl.b64': LShl,

        'and.b64': And,


        'ld.param.u8': Load32,
        'ld.param.s32': Load32,
        'ld.param.u32': Load32,
        'ld.param.s64': Load64,
        'ld.param.u64': Load64,
        
        'st.global.u8': Store8,
        'st.global.u32': Store32,
        'st.global.u64': Store64,

        'st.shared.u32': LocalStore,
        'atom.shared.add.u32': LocalAdd,
        'ld.shared.u32': LocalLoad,
        
        's_bfe_u32': bfe,
        'v_bfe_u32': bfe,
        's_bfe_i32': bfe_s,
        'v_bfe_i32': bfe_s,
        
        'bar.sync': Barrier,

        'ret': EndPgm,
}