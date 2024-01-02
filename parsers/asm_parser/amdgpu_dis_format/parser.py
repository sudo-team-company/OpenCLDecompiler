from typing import Optional

from parsers.asm_parser.amdgpu_dis_format.blocks.block_parser import AmdGpuDisBlockParser
from parsers.asm_parser.amdgpu_dis_format.config.config_parser import AmdGpuDisConfigsParser
from parsers.base.any_parser import AnyParser
from parsers.base.ignore_parser import IgnoreParser
from parsers.base.line_parser import LineParser
from parsers.base.one_or_more_parser import OneOrMoreParser
from parsers.parse_objects.base import ParseObject
from src.opencl_types import make_asm_type
from src.register_content import RegisterContent
from src.register_type import RegisterType
from src.utils import ConfigData

ARG_KIND_TO_REGISTER_TYPE = {
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

ARG_KIND_TO_VALUE = {
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


class AmdGpuDisParser:
    def __init__(self):
        self._function_names = []
        self._config = {}

    @staticmethod
    def _convert_args_to_offset_to_content(args: list) -> dict[str, RegisterContent]:
        offset_to_content = {}

        for idx, arg in enumerate(args):
            offset = hex(int(arg[".offset"], 16))
            size = int(arg[".size"], 16) * 8
            value_kind = arg[".value_kind"]
            type_name = arg.get(".type_name")
            content = ARG_KIND_TO_VALUE.get(value_kind)

            data_type = None

            if type_name is not None:
                type_name = type_name.strip("'")
                content = f"arg{idx}"
                data_type = make_asm_type(type_name)

                if type_name.endswith("*"):
                    data_type = make_asm_type(type_name[:-1])

            register_content = RegisterContent(
                content=content,
                type_=ARG_KIND_TO_REGISTER_TYPE[value_kind],
                size=size,
                data_type=data_type,
            )

            offset_to_content[offset] = register_content

        return offset_to_content

    @staticmethod
    def _remove_redundant_lines(text: str) -> str:
        new_text = ""

        for line in text.splitlines(keepends=True):
            if line.strip().startswith(".long") \
                    or line.strip().startswith(".short") \
                    or line.strip().startswith(".byte") \
                    or line.strip().startswith(".ascii"):
                continue
            else:
                new_text += line

        return new_text

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        text = self._remove_redundant_lines(text)

        config_text = text[text.find("amdhsa.kernels:"):]
        config_parser = OneOrMoreParser(
            AmdGpuDisConfigsParser() |
            IgnoreParser(LineParser(AnyParser()))
        )

        parse_result = config_parser.parse(config_text)
        if parse_result is None:
            return None
        result, _ = parse_result
        for obj in result.obj:
            for config in obj.config:
                self._config[config[".name"]] = config

        block_parser = AmdGpuDisBlockParser()
        self._function_names = list(self._config.keys())
        pos = 0
        for line in text.splitlines():
            if line.endswith(":"):
                if line[:-1] in self._function_names:
                    parse_result = block_parser.parse(text[pos:])
                    if parse_result is None:
                        raise Exception(f"Unable to parse block '{line[:-1]}'")

                    result, _ = parse_result
                    for obj in result.obj:
                        yield (
                            obj.name,
                            ConfigData(
                                dimensions="xyz"[:list(
                                    filter(
                                        lambda x: x[1] != '0x1',
                                        enumerate(self._config[obj.name][".reqd_workgroup_size"])
                                    )
                                )[-1][0] + 1],
                                usesetup=False,
                                size_of_work_groups=[
                                    int(wg_item_size, 16)
                                    for wg_item_size
                                    in self._config[obj.name][".reqd_workgroup_size"]
                                ],
                                local_size=None,
                                params=[
                                    (
                                        (
                                            f"__{arg['.address_space']} "
                                            if ".address_space" in arg
                                            else ""
                                        ) + arg['.type_name'].strip("\'").strip("*"),
                                        ('*' if arg['.type_name'].strip("\'").endswith('*') else '') + f"arg{idx}"
                                    )
                                    for idx, arg
                                    in enumerate(
                                        list(filter(lambda arg: ".type_name" in arg, self._config[obj.name][".args"])))
                                ],
                                setup_params_offsets=[
                                    str(hex(int(arg[".offset"], 16)))
                                    for arg
                                    in
                                    list(filter(lambda arg: ".type_name" not in arg, self._config[obj.name][".args"]))
                                ],
                                offset_to_content=self._convert_args_to_offset_to_content(
                                    self._config[obj.name][".args"],
                                ),
                            ),
                            [instr.split("//")[0].strip() for instr in obj.args],
                            [],
                            [],
                        )

            pos += 1 + len(line)
