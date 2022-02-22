import re
from typing import Dict, Set, List, Optional, Tuple

from ..utils import ConfigData


def get_dimensions(set_of_config: List[str]) -> str:
    for row in set_of_config:
        if row.startswith(".dims "):
            return row.removeprefix(".dims ")
    return ""


def get_size_of_work_groups(set_of_config: List[str]) -> Optional[List[int]]:
    for row in set_of_config:
        if row.startswith(".reqd_work_group_size "):
            return [int(it.strip()) for it in row.removeprefix(".reqd_work_group_size ").split(',')]
    return None


# TODO: implement local_size parsing for rocm
def get_local_size(*_) -> Optional[int]:
    return None


def process_arg_row(row: str) -> Tuple[str, str]:
    _, arg_name, arg_type, *other = row.strip().replace(',', ' ').split()
    arg_type = arg_type[1:-1]
    if "global" in other:
        arg_type = "__global " + arg_type
    if arg_type[-1] == "*":
        return arg_type[:-1], "*" + arg_name
    return arg_type, arg_name


def get_params(set_of_config: List[str]) -> List[Tuple[str, str]]:
    return [process_arg_row(row) for row in set_of_config if ".arg" in row and not row.startswith('.arg , "",')]


def get_params_offsets_for_global_offsets(set_of_config: List[str]) -> List[str]:
    return [
        hex(i * 8) for i, row in
        enumerate(row for row in set_of_config if ".arg" in row)
        if re.match(r"go[xyz]", row.strip().replace(',', ' ').split()[4])
    ]


def process_config(set_of_config: List[str]) -> ConfigData:
    return ConfigData(
        dimensions=get_dimensions(set_of_config),
        usesetup=".use_dispatch_ptr" in set_of_config,
        size_of_work_groups=get_size_of_work_groups(set_of_config),
        local_size=get_local_size(set_of_config),
        params=get_params(set_of_config),
        params_offsets_for_global_offsets=get_params_offsets_for_global_offsets(set_of_config),
    )


def parse_common_configuration(lines: List[str]) -> List[str]:
    res: List[str] = []
    for line in lines:
        if line.startswith(".kernel "):
            break
        res.append(line)
    return res


def split_configurations_and_text(lines: List[str]) -> Tuple[List[str], List[str]]:
    index: int = lines.index(".text")
    return lines[:index], lines[index + 1:]


def split_kernels_configurations(lines: List[str]) -> Dict[str, List[str]]:
    result: Dict[str, List[str]] = {}
    current_kernel: str = ""

    for line in lines:
        if line.startswith(".kernel "):
            current_kernel = line.split()[1]
            result[current_kernel] = []
        else:
            result[current_kernel].append(line)

    return result


def split_kernels_texts(lines: List[str], names: Set[str]) -> Dict[str, List[str]]:
    result: Dict[str, List[str]] = {}
    current_kernel: str = ""

    for line in lines:
        line = re.sub("^\\s*/\\*\\w+\\*/", "", line).strip()
        if line.endswith("s_code_end"):
            break

        if line[:-1] in names:
            current_kernel = line[:-1]
            result[current_kernel] = []
        elif line.startswith(".skip "):
            continue
        else:
            result[current_kernel].append(line)

    for _, text in result.items():
        while re.match('\\s*s_nop\\s+0x0\\s*', text[-1]):
            text = text[:-1]
    return result


def parse_kernel(text: List[str]):
    lines: List[str] = [line.strip() for line in text]

    common_configuration: List[str] = parse_common_configuration(lines)
    configurations, text = split_configurations_and_text(lines[len(common_configuration):])

    kernels_configurations: Dict[str, List[str]] = split_kernels_configurations(configurations)
    kernels_texts = split_kernels_texts(text, set(kernels_configurations.keys()))

    set_of_global_data_bytes = []
    set_of_global_data_instruction = []

    for name_of_program, set_of_instructions in kernels_texts.items():
        config_data = process_config(kernels_configurations[name_of_program])
        yield name_of_program, config_data, set_of_instructions, \
              set_of_global_data_bytes, set_of_global_data_instruction
