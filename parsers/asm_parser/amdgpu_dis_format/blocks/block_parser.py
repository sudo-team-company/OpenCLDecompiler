from typing import Optional

from pyparsing import line_start, Regex, Literal, White

from base.models.functions.block import Block
from parsers.asm_parser.amdgpu_dis_format.blocks.line_parser import AmdGpuDisLineParser
from parsers.base.any_parser import AnyParser
from parsers.base.base_parser import BaseParser
from parsers.base.ignore_parser import IgnoreParser
from parsers.base.line_parser import LineParser
from parsers.base.one_or_more_parser import OneOrMoreParser
from parsers.base.parser_element_parser import ParserElementParser
from parsers.parse_objects.base.list_parse_object import ListParseObject
from parsers.parse_objects.base import ParseObject


class AmdGpuDisBlockParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parse_result = LineParser(
            IgnoreParser(ParserElementParser(line_start)) +
            ParserElementParser(
                Regex("[^:\s]+")
            ) +
            IgnoreParser(ParserElementParser(Literal(":"))) +
            IgnoreParser(AnyParser())
        ).parse(text)

        if parse_result is None:
            return None

        function_name, rest = parse_result

        parse_result = OneOrMoreParser(
            IgnoreParser(ParserElementParser(White(" \t"))) +
            AmdGpuDisLineParser()
        ).parse(rest)

        if parse_result is None:
            return None

        commands, rest = parse_result

        return ListParseObject([Block(function_name.obj, *commands.obj)]), rest
