from itertools import starmap

import yaml
import re

from src.expression_manager.expression_manager import ExpressionManager
from src.model.config_data import ConfigData
from src.model.kernel_argument import KernelArgument
from src.model.gfx10.gfx10_KDescriptor import gfx10_KDescriptor
from src.model.gfx10.gfx10_ROData import gfx10_ROData
from src.model.global_data import GlobalData

from ..decompiler_data import DecompilerData
from ..opencl_types import make_asm_type
from ..register_content import RegisterContent
from ..register_type import RegisterType

_ARG_KIND_TO_REGISTER_TYPE = {
    "by_value": RegisterType.KERNEL_ARGUMENT_VALUE,
    "global_buffer": RegisterType.ADDRESS_KERNEL_ARGUMENT,
    "hidden_block_count_x": RegisterType.NUM_GROUPS_X,
    "hidden_block_count_y": RegisterType.NUM_GROUPS_Y,
    "hidden_block_count_z": RegisterType.NUM_GROUPS_Z,
    "hidden_group_size_x": RegisterType.LOCAL_SIZE_X,
    "hidden_group_size_y": RegisterType.LOCAL_SIZE_Y,
    "hidden_group_size_z": RegisterType.LOCAL_SIZE_Z,
    "hidden_remainder_x": RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE,
    "hidden_remainder_y": RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE,
    "hidden_remainder_z": RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE,
    "hidden_global_offset_x": RegisterType.GLOBAL_OFFSET_X,
    "hidden_global_offset_y": RegisterType.GLOBAL_OFFSET_Y,
    "hidden_global_offset_z": RegisterType.GLOBAL_OFFSET_Z,
    "hidden_grid_dims": RegisterType.WORK_DIM,
}

_ARG_KIND_TO_VALUE = {
    "hidden_block_count_x": "get_num_groups(0)",
    "hidden_block_count_y": "get_num_groups(1)",
    "hidden_block_count_z": "get_num_groups(2)",
    "hidden_group_size_x": "get_local_size(0)",
    "hidden_group_size_y": "get_local_size(1)",
    "hidden_group_size_z": "get_local_size(2)",
    "hidden_remainder_x": "get_group_id(0) * get_local_size(0)",
    "hidden_remainder_y": "get_group_id(1) * get_local_size(1)",
    "hidden_remainder_z": "get_group_id(2) * get_local_size(2)",
    "hidden_global_offset_x": "get_global_offset(0)",
    "hidden_global_offset_y": "get_global_offset(1)",
    "hidden_global_offset_z": "get_global_offset(2)",
    "hidden_grid_dims": "get_work_dim()",
}


def _extract_beginning_comment(text: list[str]) -> tuple[list[str], list[str]]:
    if text[0].startswith("//"):
        return [text[0]], text[1:]
    return [], text


def _extract_amdgpu_pal_metadata(text: list[str]) -> tuple[list[str], list[str]]:
    idx_from: int = text.index("\t.amdgpu_pal_metadata")
    idx_to: int = text.index("\t.end_amdgpu_pal_metadata") + 1

    assert text[idx_from] == "\t.amdgpu_pal_metadata"
    assert text[idx_from + 1] == "---"
    assert text[idx_to - 2] == "..."
    assert text[idx_to - 1] == "\t.end_amdgpu_pal_metadata"

    return text[idx_from + 2 : idx_to - 2], text[:idx_from] + text[idx_to:]


def _make_argument(idx: int, arg: dict) -> KernelArgument:
    address_space: str | None = arg.get(".address_space")
    address_space: str = f"__{address_space} " if address_space else ""
    type_name: str = arg.get(".type_name", "ulong").strip("'")
    return KernelArgument(
        type_name=address_space + type_name.strip("*"),
        name=("*" if type_name.endswith("*") else "") + f"arg{idx}",
        offset=arg[".offset"],
        size=arg[".size"],
        hidden=arg[".value_kind"].startswith("hidden_"),
    )


def _convert_args_to_offset_to_content(args: list) -> dict[str, RegisterContent]:
    offset_to_content: dict[str, RegisterContent] = {}

    for idx, arg in enumerate(args):
        offset = hex(arg[".offset"])
        size = arg[".size"] * 8
        value_kind = arg[".value_kind"]
        type_name = arg.get(".type_name")
        value = _ARG_KIND_TO_VALUE.get(value_kind)

        data_type = None

        expr_node = None

        if type_name is not None:
            type_name = type_name.strip("'")
            value = f"arg{idx}"
            data_type = make_asm_type(type_name)

            if type_name.endswith("*"):
                data_type = make_asm_type(type_name[:-1])

            int_offset = int(offset, base=16)

            expr_node = ExpressionManager().add_kernel_argument(_make_argument(idx, arg), int_offset)
        elif _ARG_KIND_TO_REGISTER_TYPE.get(value_kind) is not None:
            reg_type = _ARG_KIND_TO_REGISTER_TYPE[value_kind]
            expr_node = ExpressionManager().add_register_node(reg_type, _ARG_KIND_TO_VALUE[value_kind])

        register_content = RegisterContent(
            value=value,
            type_=_ARG_KIND_TO_REGISTER_TYPE[value_kind],
            size=size,
            data_type=data_type,
            expression_node=expr_node,
        )

        offset_to_content[offset] = register_content

    return offset_to_content


def _parse_amdgpu_pal_metadata(amdgpu_pal_metadata: list[str]) -> dict[str, ConfigData]:
    metadata: dict = yaml.safe_load("\n".join(amdgpu_pal_metadata))
    DecompilerData().gpu = metadata["amdhsa.target"].split("-")[-1] 
    result: dict[str, ConfigData] = {}
    for km in metadata["amdhsa.kernels"]:
        ExpressionManager().set_name_of_program(km[".name"])
        result[km[".name"]] = ConfigData(
            dimensions="xyz"[: list(filter(lambda x: x[1] != 1, enumerate(km[".reqd_workgroup_size"])))[-1][0] + 1],
            usesetup=False,
            size_of_work_groups=km[".reqd_workgroup_size"],
            local_size=None,
            arguments=list(starmap(_make_argument, enumerate(list(km[".args"])))),
            offset_to_content=_convert_args_to_offset_to_content(km[".args"]),
        )
    return result


def _parse_sections(text: list[str]) -> dict[str, list[str]]:
    result: dict[str, list[str]] = {}
    name: str = ""
    for line in text:
        line: str = line.rstrip()  # noqa: PLW2901
        if not line:
            continue
        if line.startswith("\t.section") or line == "\t.text":
            name = line.removeprefix("\t.section").strip()
            name = name.removesuffix(",#alloc").strip()
            assert name not in result
            result[name] = []
            continue
        result[name].append(line)
    return result


def _parse_rodata_sections(text: list[str]) -> dict[str, gfx10_ROData]:
    result = {}
    
    current_name: str | None = None
    current_rodata: gfx10_ROData | None = None
    
    type_pattern = re.compile(r'^\s*\.type\s+([^,]+),@object')
    for row in text:
        line = row.strip()
        if not line:
            continue
        
        type_match = type_pattern.match(line)
        if type_match:
            if current_name is not None:
                result[current_name] = current_rodata
            
            current_name = type_match.group(1)
            current_rodata = gfx10_ROData()
            continue
            
        if current_name is None or current_rodata is None:
            continue
            
        if line == f"{current_name}:":
            continue
            
        current_rodata.text.append(row)

    if current_name:
        result[current_name] = current_rodata
        
    return result


def _extract_kd(data: dict[str, gfx10_ROData]) -> tuple[dict[str, gfx10_ROData], dict[str, gfx10_ROData]]:
    kd : dict[str, gfx10_ROData] = {}
    global_data : dict[str, gfx10_ROData] = {}

    for name, rodata in data.items():
        if name.endswith(".kd"):
            kd[name] = rodata
        else:
            global_data[name] = rodata

    return kd, global_data


def get_global_data_instruction(lines: list[str]) -> list[tuple[str, int]]:
    target_opcodes: set[str] = {
        "s_getpc_b64"
    }
    
    result: list[tuple[str, int]] = []

    for line in lines:            
        code_part, comment_part = line.split("//", 1)

        clean_code = code_part.strip()
        if not clean_code:
            continue
        
        opcode = clean_code.split()[0]

        if opcode in target_opcodes:
            if ":" in comment_part:
                addr_str = comment_part.split(":", 1)[0].strip()
                addr = int(addr_str, 16)
                result.append((clean_code, addr))

    return result


def parse_kernel(text: list[str]):
    _, text = _extract_beginning_comment(text)
    amdgpu_pal_metadata, sections_text = _extract_amdgpu_pal_metadata(text)

    metadata: dict[str, ConfigData] = _parse_amdgpu_pal_metadata(amdgpu_pal_metadata)
    sections: dict[str, list[str]] = _parse_sections(sections_text)

    text_section: list[str] = sections[".text"]

    rodata_sections = _parse_rodata_sections(sections[".rodata"])
    raw_kernel_desc, raw_global_data = _extract_kd(rodata_sections)

    global_data: dict[str, GlobalData] = {}
    for gdata_name, rodata in raw_global_data.items():
        gdata, start_addr = gfx10_ROData.parse_lines(rodata.text)
        global_data[gdata_name] = GlobalData(gdata, start_addr)

    for name, md in metadata.items():
        from_idx: int = text_section.index(f"{name}:") + 1
        to_idx: int = text_section.index(f"{name}_symend:")
        global_data_instruction = get_global_data_instruction(text_section[from_idx:to_idx])
        md.preloaded_reg = gfx10_KDescriptor(gfx10_ROData.parse_lines(raw_kernel_desc[f"{name}.kd"].text)[0])
        
        yield (
            name,
            md,
            [instr.split("//")[0].strip() for instr in text_section[from_idx:to_idx]],
            [],
            [],
            global_data,
            global_data_instruction,
        )


#('test',
# ConfigData(dimensions='x',
#            usesetup=False,
#            size_of_work_groups=[64, 1, 1], 
#            local_size=None, 
#            arguments=[KernelArgument(type_name='__global int', name='*arg0', offset=0, size=8, hidden=False, const=False),
#                       KernelArgument(type_name='__global uint', name='*arg1', offset=8, size=8, hidden=False, const=False), 
#                       KernelArgument(type_name='int', name='arg2', offset=16, size=4, hidden=False, const=False), 
#                       KernelArgument(type_name='ulong', name='arg4', offset=28, size=4, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg3', offset=24, size=4, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg5', offset=32, size=4, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg6', offset=36, size=2, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg7', offset=38, size=2, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg8', offset=40, size=2, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg9', offset=42, size=2, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg10', offset=44, size=2, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg11', offset=46, size=2, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg12', offset=64, size=8, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg13', offset=72, size=8, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg14', offset=80, size=8, hidden=True, const=False), 
#                       KernelArgument(type_name='ulong', name='arg15', offset=88, size=2, hidden=True, const=False)], 
#            offset_to_content={'0x0': <src.register_content.RegisterContent object at 0x000001EAEED2D590>, 
#                               '0x8': <src.register_content.RegisterContent object at 0x000001EAEEA68C50>, 
#                               '0x10': <src.register_content.RegisterContent object at 0x000001EAEEA68D50>, 
#                               '0x18': <src.register_content.RegisterContent object at 0x000001EAEED41130>, 
#                               '0x1c': <src.register_content.RegisterContent object at 0x000001EAEED41220>, 
#                               '0x20': <src.register_content.RegisterContent object at 0x000001EAEED28C90>, 
#                               '0x24': <src.register_content.RegisterContent object at 0x000001EAEED28750>, 
#                               '0x26': <src.register_content.RegisterContent object at 0x000001EAEED76B60>, 
#                               '0x28': <src.register_content.RegisterContent object at 0x000001EAEE98E810>, 
#                               '0x2a': <src.register_content.RegisterContent object at 0x000001EAEE98F050>, 
#                               '0x2c': <src.register_content.RegisterContent object at 0x000001EAEEA5D390>, 
#                               '0x2e': <src.register_content.RegisterContent object at 0x000001EAEEA5D5A0>, 
#                               '0x40': <src.register_content.RegisterContent object at 0x000001EAEED6EE90>, 
#                               '0x48': <src.register_content.RegisterContent object at 0x000001EAEED6ED50>, 
#                               '0x50': <src.register_content.RegisterContent object at 0x000001EAEEA3FEC0>, 
#                               '0x58': <src.register_content.RegisterContent object at 0x000001EAEED814D0>}),
#    ['s_load_dword s0, s[6:7], 0x10',
#     's_load_dword s9, s[4:5], 0x4', 
#     's_load_dword s10, s[6:7], 0x18', 
#     's_getpc_b64 s[2:3]', 
#     's_add_u32 s2, s2, 0xffffef24', 
#     's_addc_u32 s3, s3, -1', 
#     's_load_dwordx2 s[4:5], s[6:7], null', 
#     's_waitcnt lgkmcnt(0)', 
#     's_ashr_i32 s1, s0, 31', 
#     's_and_b32 s6, s9, 0xffff', 
#     's_lshl_b64 s[0:1], s[0:1], 2', 
#     's_mul_i32 s8, s8, s6', 
#     's_add_u32 s0, s0, s2', 
#     's_addc_u32 s1, s1, s3', 
#     'v_add3_u32 v1, s10, s8, v0', 
#     's_load_dword s0, s[0:1], null', 
#     'v_mov_b32_e32 v0, 0', 
#     'v_ashrrev_i64 v[0:1], 30, v[0:1]', 
#     'v_add_co_u32 v0, vcc_lo, s4, v0', 
#     'v_add_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo', 
#     's_waitcnt lgkmcnt(0)', 
#     'v_mov_b32_e32 v2, s0', 
#     'global_store_dword v[0:1], v2, off', 
#     's_endpgm'], 
#    [], 
#    [])
  
#('some_array_test',
#  ConfigData(dimensions='xy', 
#             usesetup=False, 
#             size_of_work_groups=[8, 8, 1], 
#             local_size=None, 
#             arguments=[KernelArgument(type_name='__global long', name='*arg0', offset=0, size=8, hidden=False, const=False),
#                        KernelArgument(type_name='__global int', name='*arg1', offset=8, size=8, hidden=False, const=False), 
#                        KernelArgument(type_name='int', name='arg2', offset=16, size=4, hidden=False, const=False), 
#                        KernelArgument(type_name='ulong', name='arg3', offset=24, size=4, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg4', offset=28, size=4, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg5', offset=32, size=4, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg6', offset=36, size=2, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg7', offset=38, size=2, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg8', offset=40, size=2, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg9', offset=42, size=2, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg10', offset=44, size=2, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg11', offset=46, size=2, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg12', offset=64, size=8, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg13', offset=72, size=8, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg14', offset=80, size=8, hidden=True, const=False), 
#                        KernelArgument(type_name='ulong', name='arg15', offset=88, size=2, hidden=True, const=False)], 
#             offset_to_content={'0x0': <src.register_content.RegisterContent object at 0x000001E66CDD1590>, 
#                               '0x8': <src.register_content.RegisterContent object at 0x000001E66CDB4B50>, 
#                               '0x10': <src.register_content.RegisterContent object at 0x000001E66CDB4C50>, 
#                               '0x18': <src.register_content.RegisterContent object at 0x000001E66CDE9040>, 
#                               '0x1c': <src.register_content.RegisterContent object at 0x000001E66CDE9130>, 
#                               '0x20': <src.register_content.RegisterContent object at 0x000001E66CDCD0F0>, 
#                               '0x24': <src.register_content.RegisterContent object at 0x000001E66CDCC4B0>, 
#                               '0x26': <src.register_content.RegisterContent object at 0x000001E66CE1B2B0>, 
#                               '0x28': <src.register_content.RegisterContent object at 0x000001E66CA82750>, 
#                               '0x2a': <src.register_content.RegisterContent object at 0x000001E66CA83050>, 
#                               '0x2c': <src.register_content.RegisterContent object at 0x000001E66CB592E0>, 
#                               '0x2e': <src.register_content.RegisterContent object at 0x000001E66CB594F0>, 
#                               '0x40': <src.register_content.RegisterContent object at 0x000001E66CE17890>, 
#                               '0x48': <src.register_content.RegisterContent object at 0x000001E66CE17750>, 
#                               '0x50': <src.register_content.RegisterContent object at 0x000001E66CE28830>, 
#                               '0x58': <src.register_content.RegisterContent object at 0x000001E66CE2E1D0>}, 
#             input_reg=KDescriptor(
#                        group_segment_fixed_size=0
#                        private_segment_fixed_size=0
#                        kernarg_size=280
#                        kernel_code_entry_byte_offset=0x000010C0
#                        compute_pgm_rsrc1=0x60AF0041
#                          vgpr_count=1
#                          sgpr_count=1
#                          priority=0
#                          float_mode_round_32=0
#                          float_mode_round_16_64=0
#                          float_mode_denorm_32=3
#                          float_mode_denorm_16_64=3
#                          priv=0
#                          enable_dx10_clamp=1
#                          debug_mode=0
#                          enable_ieee_mode=1
#                          bulky=0
#                          cdbg_user=0
#                          wgp_mode=1
#                          mem_ordered=1
#                          fwd_progress=0
#                        compute_pgm_rsrc2=0x00000990
#                          enable_private_segment=0
#                          user_sgpr_count=8
#                          enable_trap_handler=0
#                          enable_sgpr_workgroup_id_x=1
#                          enable_sgpr_workgroup_id_y=1
#                          penable_sgpr_workgroup_id_zriv=0
#                          enable_sgpr_workgroup_info=0
#                          enable_vgpr_workitem_id=1
#                          enable_exception_address_warch=0
#                          enable_exception_memory=0
#                          granulated_lds_size=0
#                          enable_exception=0
#                        compute_pgm_rsrc3=0x00000000
#                          shared_vgpr_count=0
#                        code_props=0x0000040B
#                          sgpr_private_segment_buffer=1
#                          sgpr_dispatch_ptr=1
#                          sgpr_queue_ptr=0
#                          sgpr_kernarg_segment_ptr=1
#                          sgpr_dispatch_id=0
#                          sgpr_flat_scratch_init=0
#                          sgpr_private_segment_size=0
#                          wavefront_size32=0)),
#  ['s_load_dword s10, s[4:5], 0x4',
#   's_load_dwordx4 s[0:3], s[6:7], 0x18', 
#   'v_mov_b32_e32 v3, 0', 
#   's_waitcnt lgkmcnt(0)', 
#   's_and_b32 s1, s10, 0xffff', 
#   's_mul_i32 s8, s8, s1', 
#   'v_add3_u32 v2, s0, s8, v0', 
#   's_getpc_b64 s[0:1]', 
#   's_add_u32 s0, s0, 0xffffef50', 
#   's_addc_u32 s1, s1, -1', 
#   's_getpc_b64 s[4:5]', 
#   's_add_u32 s4, s4, 0xffffef5c', 
#   's_addc_u32 s5, s5, -1', 
#   'v_lshlrev_b64 v[4:5], 2, v[2:3]', 
#   'v_lshlrev_b64 v[6:7], 3, v[2:3]', 
#   'v_add_co_u32 v8, vcc_lo, v4, s0', 
#   'v_add_co_ci_u32_e32 v9, vcc_lo, s1, v5, vcc_lo', 
#   'v_add_co_u32 v6, vcc_lo, v6, s4', 
#   'v_add_co_ci_u32_e32 v7, vcc_lo, s5, v7, vcc_lo', 
#   's_load_dwordx4 s[4:7], s[6:7], null', 
#   'global_load_dword v8, v[8:9], off', 
#   'global_load_dwordx2 v[6:7], v[6:7], off', 
#   's_lshr_b32 s0, s10, 16', 
#   's_mul_i32 s9, s9, s0', 
#   'v_add3_u32 v2, s2, s9, v1', 
#   'v_lshlrev_b64 v[0:1], 3, v[2:3]', 
#   's_waitcnt lgkmcnt(0)', 
#   'v_add_co_u32 v2, vcc_lo, s6, v4', 
#   'v_add_co_ci_u32_e32 v3, vcc_lo, s7, v5, vcc_lo', 
#   'v_add_co_u32 v0, vcc_lo, s4, v0', 
#   'v_add_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo', 
#   's_waitcnt vmcnt(1)', 
#   'global_store_dword v[2:3], v8, off', 
#   's_waitcnt vmcnt(0)', 
#   'global_store_dwordx2 v[0:1], v[6:7], off', 
#   's_endpgm'], 
#   [], 
#   [], 
#   {'fst_arr': raw_bytes=bytearray(b'0100000002000000030000000400000005000000060000000700000000000000'), addr=2176, 
#    'snd_arr': raw_bytes=bytearray(b'080000000000000009000000000000005c000000000000000b00000000000000'), addr=2208},
#   [('s_getpc_b64 s[0:1]', 6444), ('s_getpc_b64 s[4:5]', 6464)])