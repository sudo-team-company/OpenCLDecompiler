import re

from src.model.config_data import ConfigData
from src.model.kernel_argument import KernelArgument

from ..opencl_types import evaluate_size, make_asm_type


def process_size_of_work_groups(set_of_config: list[str]) -> list[int] | None:
    cws: bool = ".cws" in set_of_config[1]
    return list(map(int, set_of_config[1].replace(",", " ").split()[1:])) if cws else None


def process_local_size(set_of_config: list[str]) -> int | None:
    localsize: bool = "localsize" in set_of_config[4]
    return int(set_of_config[4][11:]) if localsize else None


def process_params(set_of_config: list[str]) -> list[KernelArgument]:
    args = []
    offset = 0
    for row in set_of_config:
        if not row.startswith(".arg "):
            continue
        row = row.removeprefix(".arg ").removesuffix(",")  # noqa: PLW2901
        name, _, type_name, *other = row.split(", ")
        if len(other) > 0:
            type_name = "__" + other[0] + " " + type_name
        const = row.find("const ") != -1
        hidden = name.startswith("_.")
        if type_name[-1] == "*":
            type_name = type_name[:-1]
            name = "*" + name
        size = 8 if name.startswith("*") else evaluate_size(make_asm_type(type_name))[0]
        if offset % size != 0 and size <= 8:  # noqa: PLR2004
            offset += size - offset % size
        for i in range(3):
            if name == f"_.global_offset_{i}":
                name = f"get_global_offset({i})"
        args.append(
            KernelArgument(type_name=type_name, name=name, offset=offset, size=size, hidden=hidden, const=const)
        )
        offset += size
    return args


def process_config(set_of_config: list[str]) -> ConfigData:
    return ConfigData(
        dimensions=set_of_config[0][6:],
        usesetup=".usesetup" in set_of_config,
        size_of_work_groups=process_size_of_work_groups(set_of_config),
        local_size=process_local_size(set_of_config),
        arguments=process_params(set_of_config),
    )


def get_global_data_bytes(row, set_of_global_data_bytes):
    line_of_bytes = row.split()
    if line_of_bytes.pop(0) == ".fill":
        amount = line_of_bytes[0][:-1]
        value = line_of_bytes[2]
        expand_list = [value for _ in range(int(amount))]
        set_of_global_data_bytes += expand_list
    else:
        for i, elem in enumerate(line_of_bytes):
            line_of_bytes[i] = elem.replace(",", "")
        set_of_global_data_bytes += line_of_bytes
    return set_of_global_data_bytes


def parse_kernel(text):
    status_of_parse = "start"
    set_of_instructions = []
    set_of_global_data_instruction = []
    set_of_config = []
    set_of_global_data_bytes = []
    name_of_program = ""
    for row in text:
        row = re.sub(r"/\*(.*?)\*/", "", row)  # noqa: PLW2901
        row = row.strip()  # noqa: PLW2901
        if ".kernel " in row:
            if status_of_parse == "instruction":
                status_of_parse = "kernel"
                yield (
                    name_of_program,
                    process_config(set_of_config),
                    set_of_instructions,
                    set_of_global_data_bytes,
                    set_of_global_data_instruction,
                )
                set_of_instructions = []
                set_of_config = []
            name_of_program = row.split()[1]
        if row == ".config":
            status_of_parse = "config"
        elif row == ".text":
            status_of_parse = "instruction"
        elif row == ".gdata:":
            status_of_parse = "global_data"
        elif status_of_parse == "instruction":
            if ".gdata" in row:
                set_of_global_data_instruction.append(row)
            set_of_instructions.append(row)
        elif status_of_parse == "config":
            set_of_config.append(row)
        elif status_of_parse == "global_data":
            set_of_global_data_bytes = get_global_data_bytes(row, set_of_global_data_bytes)
    yield (
        name_of_program,
        process_config(set_of_config),
        set_of_instructions,
        set_of_global_data_bytes,
        set_of_global_data_instruction,
    )
