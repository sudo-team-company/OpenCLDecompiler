from typing import Optional

from base.models.functions.block import Block
from base.models.functions.config import Config
from parsers.asm_parser.amdgpu_dis_format.blocks.block_parser import AmdGpuDisBlockParser
from parsers.asm_parser.amdgpu_dis_format.config.config_parser import AmdGpuDisConfigsParser
from parsers.base.any_parser import AnyParser
from parsers.base.base_parser import BaseParser
from parsers.base.ignore_parser import IgnoreParser
from parsers.base.line_parser import LineParser
from parsers.base.one_or_more_parser import OneOrMoreParser
from parsers.parse_objects.base.list_parse_object import ListParseObject
from parsers.parse_objects.base import ParseObject


class AmdGpuDisParser(BaseParser):
    def __init__(self):
        self._function_names = []
        self._function_commands = {}
        self._config = {}

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = OneOrMoreParser(
            AmdGpuDisConfigsParser() |
            AmdGpuDisBlockParser() |
            IgnoreParser(LineParser(AnyParser()))
        )

        parse_result = parser.parse(text)

        if parse_result is None:
            return None

        result, _ = parse_result
        for obj in result.obj:
            if isinstance(obj, Block):
                if obj.name in self._function_names:
                    self._function_commands[obj.name] = obj.args
                    continue

                if len(obj.args) >= 2 and ".type" in obj.args[-2].obj and obj.args[-2].obj.endswith("@function"):
                    self._function_names.append(obj.args[-2].obj.replace(".type", "").replace(",@function", "").strip())
                    continue

            if isinstance(obj, Config):
                for config in obj.config:
                    self._config[config[".name"]] = config

        result = []

        for name in self._function_names:
            result.append((name, self._function_commands[name], self._config[name]))

        return ListParseObject(result), ""
