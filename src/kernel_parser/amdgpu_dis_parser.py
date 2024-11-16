import yaml

from ..decompiler_data import DecompilerData
from ..model import KernelArgument
from ..opencl_types import make_asm_type
from ..register_content import RegisterContent
from ..register_type import RegisterType
from ..utils import ConfigData

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


def _extract_beginning_comment(text: list[str]) -> (list[str], list[str]):
    if text[0].startswith('//'):
        return [text[0]], text[1:]
    return [], text


def _extract_amdgpu_pal_metadata(text: list[str]) -> (list[str], list[str]):
    idx_from: int = text.index('\t.amdgpu_pal_metadata')
    idx_to: int = text.index('\t.end_amdgpu_pal_metadata') + 1

    assert text[idx_from] == '\t.amdgpu_pal_metadata'
    assert text[idx_from + 1] == '---'
    assert text[idx_to - 2] == '...'
    assert text[idx_to - 1] == '\t.end_amdgpu_pal_metadata'

    return text[idx_from + 2:idx_to - 2], text[:idx_from] + text[idx_to:]


def _make_argument(idx: int, arg: dict) -> KernelArgument:
    address_space: str | None = arg.get('.address_space')
    address_space: str = f"__{address_space} " if address_space else ""
    type_name: str = arg.get('.type_name', 'ulong').strip("\'")
    return KernelArgument(
        type_name=address_space + type_name.strip("*"),
        name=('*' if type_name.endswith('*') else '') + f"arg{idx}",
        offset=arg['.offset'],
        size=arg['.size'],
        hidden=arg['.value_kind'].startswith('hidden_'),
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

        if type_name is not None:
            type_name = type_name.strip("'")
            value = f"arg{idx}"
            data_type = make_asm_type(type_name)

            if type_name.endswith("*"):
                data_type = make_asm_type(type_name[:-1])

        register_content = RegisterContent(
            value=value,
            type_=_ARG_KIND_TO_REGISTER_TYPE[value_kind],
            size=size,
            data_type=data_type,
        )

        offset_to_content[offset] = register_content

    return offset_to_content


def _parse_amdgpu_pal_metadata(amdgpu_pal_metadata: list[str]) -> dict[str, ConfigData]:
    metadata: dict = yaml.load('\n'.join(amdgpu_pal_metadata), Loader=yaml.CLoader)
    DecompilerData().gpu = metadata['amdhsa.target'].split('-')[-1]
    result: dict[str, ConfigData] = {}
    for km in metadata['amdhsa.kernels']:
        result[km['.name']] = ConfigData(
            dimensions="xyz"[:list(filter(lambda x: x[1] != 1, enumerate(km[".reqd_workgroup_size"])))[-1][0] + 1],
            usesetup=False,
            size_of_work_groups=km[".reqd_workgroup_size"],
            local_size=None,
            arguments=[_make_argument(idx, arg) for idx, arg in enumerate(list(km[".args"]))],
            offset_to_content=_convert_args_to_offset_to_content(km[".args"]),
        )
    return result


def _parse_sections(text: list[str]) -> dict[str, list[str]]:
    result: dict[str, list[str]] = {}
    name: str = ''
    for line in text:
        line: str = line.rstrip()
        if line == '':
            continue
        if line.startswith('\t.section') or line == '\t.text':
            name = line.removeprefix('\t.section').strip()
            assert name not in result
            result[name] = []
            continue
        result[name].append(line)
    return result


def parse_kernel(text: list[str]):
    _, text = _extract_beginning_comment(text)
    amdgpu_pal_metadata, sections_text = _extract_amdgpu_pal_metadata(text)

    metadata: dict[str, ConfigData] = _parse_amdgpu_pal_metadata(amdgpu_pal_metadata)
    sections: dict[str, list[str]] = _parse_sections(sections_text)

    text_section: list[str] = sections['.text']

    for name, md in metadata.items():
        from_idx: int = text_section.index(f'{name}:') + 1
        to_idx: int = text_section.index(f'{name}_symend:')
        yield (
            name,
            md,
            [instr.split("//")[0].strip() for instr in text_section[from_idx:to_idx]],
            [],
            [],
        )
