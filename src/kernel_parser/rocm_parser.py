import re

from ..model import ConfigData, KernelArgument


def get_dimensions(set_of_config: list[str]) -> str:
    for row in set_of_config:
        if row.startswith(".dims "):
            return row.removeprefix(".dims ")
    return ""


def get_size_of_work_groups(set_of_config: list[str]) -> list[int] | None:
    for row in set_of_config:
        if row.startswith(".reqd_work_group_size "):
            return [int(it.strip()) for it in row.removeprefix(".reqd_work_group_size ").split(",")]
    return None


# TODO: implement local_size parsing for rocm
def get_local_size(*_) -> int | None:
    return None


def get_params(set_of_config: list[str]) -> list[KernelArgument]:
    args = []
    offset = 0
    for row in set_of_config:
        if not row.startswith(".arg "):
            continue
        row = row.removeprefix(".arg ")
        name, type_name, size, align, *other = row.split(", ")
        type_name = type_name[1:-1]
        if "global" in other:
            type_name = "__global " + type_name
        if type_name.endswith("*"):
            type_name = type_name[:-1]
            name = "*" + name
        size = int(size)
        align = int(align)
        if offset % align != 0:
            offset += align - offset % align
        hidden = name == ""
        value_kind = other[0]
        for i, global_offset_kind in enumerate(["gox", "goy", "goz"]):
            if value_kind == global_offset_kind:
                name = f"get_global_offset({i})"
                type_name = "long"
        args.append(
            KernelArgument(
                type_name=type_name,
                name=name,
                offset=offset,
                size=size,
                hidden=hidden,
            )
        )
        offset += size
    return args


def process_config(set_of_config: list[str]) -> ConfigData:
    return ConfigData(
        dimensions=get_dimensions(set_of_config),
        usesetup=".use_dispatch_ptr" in set_of_config,
        size_of_work_groups=get_size_of_work_groups(set_of_config),
        local_size=get_local_size(set_of_config),
        arguments=get_params(set_of_config),
    )


def parse_common_configuration(lines: list[str]) -> list[str]:
    res: list[str] = []
    for line in lines:
        if line.startswith(".kernel "):
            break
        res.append(line)
    return res


def split_configurations_and_text(lines: list[str]) -> tuple[list[str], list[str]]:
    index: int = lines.index(".text")
    return lines[:index], lines[index + 1 :]


def split_kernels_configurations(lines: list[str]) -> dict[str, list[str]]:
    result: dict[str, list[str]] = {}
    current_kernel: str = ""

    for line in lines:
        if line.startswith(".kernel "):
            current_kernel = line.split()[1]
            result[current_kernel] = []
        else:
            result[current_kernel].append(line)

    return result


def split_kernels_texts(lines: list[str], names: set[str]) -> dict[str, list[str]]:
    result: dict[str, list[str]] = {}
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
        while re.match("\\s*s_nop\\s+0x0\\s*", text[-1]):
            text = text[:-1]
    return result


def parse_kernel(text: list[str]):
    lines: list[str] = [line.strip() for line in text]

    common_configuration: list[str] = parse_common_configuration(lines)
    configurations, text = split_configurations_and_text(lines[len(common_configuration) :])

    kernels_configurations: dict[str, list[str]] = split_kernels_configurations(configurations)
    kernels_texts = split_kernels_texts(text, set(kernels_configurations.keys()))

    set_of_global_data_bytes = []
    set_of_global_data_instruction = []

    for name_of_program, set_of_instructions in kernels_texts.items():
        config_data = process_config(kernels_configurations[name_of_program])
        yield (
            name_of_program,
            config_data,
            set_of_instructions,
            set_of_global_data_bytes,
            set_of_global_data_instruction,
        )
