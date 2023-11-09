from typing import Optional

from pyparsing import Literal, line_start

from base.models.functions.config import Config
from parsers.asm_parser.amdgpu_dis_format.config.args_parser import ArgsParser
from parsers.asm_parser.amdgpu_dis_format.config.metadata_parser import MetadataParser
from parsers.base import BaseParser, IgnoreParser, ParserElementParser, LineParser, OneOrMoreParser
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.lines_parse_object import ListParseObject


class ConfigParser(BaseParser):

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = ArgsParser()

        parse_result = parser.parse(text)

        if parse_result is None:
            return None

        args, rest = parse_result

        parser = MetadataParser()

        parse_result = parser.parse(rest)

        if parse_result is None:
            return None

        metadata, rest = parse_result

        return ListParseObject([Config(args.obj, metadata.obj)]), rest


class AmdGpuDisConfigsParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        return (
                IgnoreParser(LineParser(ParserElementParser(line_start + Literal("amdhsa.kernels:")))) +
                OneOrMoreParser(ConfigParser())
        ).parse(text)
