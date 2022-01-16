from typing import List, Tuple, Optional


def process_dimensions(set_of_config: List[str]) -> Tuple[str, bool]:
    dimensions: str = set_of_config[0][6:]
    use_setup: bool = ".usesetup" in set_of_config
    return dimensions, use_setup


def process_arg_row(row: str) -> Tuple[str, str]:
    _, arg_name, _, arg_type, *other = row.strip().replace(',', ' ').split()
    if len(other) > 0:
        arg_type = "__" + other[0] + " " + arg_type
    if arg_type[-1] == "*":
        return arg_type[:-1], "*" + arg_name
    return arg_type, arg_name


def process_params(set_of_config: List[str]) -> List[Tuple[str, str]]:
    return [process_arg_row(row) for row in set_of_config if ".arg" in row and "_." not in row]


def process_size_of_work_groups(set_of_config: List[str]) -> Optional[List[int]]:
    cws: bool = ".cws" in set_of_config[1]
    return list(map(int, set_of_config[1].replace(',', ' ').split()[1:])) if cws else None


def process_local_size(set_of_config: List[str]) -> Optional[int]:
    local_size: bool = "localsize" in set_of_config[4]
    return int(set_of_config[4][11:]) if local_size else None


def process_config(set_of_config):
    dimensions, use_setup = process_dimensions(set_of_config)
    size_of_work_groups = process_size_of_work_groups(set_of_config)
    local_size = process_local_size(set_of_config)
    params = process_params(set_of_config)
    return dimensions, use_setup, size_of_work_groups, local_size, params
