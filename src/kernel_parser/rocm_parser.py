import re
from typing import Dict, List, Set, Tuple


def process_config(*_):
    raise NotImplementedError("ROCM format is not implemented yet.")


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
