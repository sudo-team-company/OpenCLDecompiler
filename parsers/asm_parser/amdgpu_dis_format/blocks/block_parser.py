from typing import Optional

from pyparsing import line_start, Regex, Literal

from base.models.functions.block import Block
from parsers.base.base_parser import BaseParser
from parsers.base.ignore_parser import IgnoreParser
from parsers.base.line_parser import LineParser
from parsers.base.parser_element_parser import ParserElementParser
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.list_parse_object import ListParseObject


class AmdGpuDisBlockParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parse_result = LineParser(
            IgnoreParser(ParserElementParser(line_start)) +
            ParserElementParser(
                Regex(r"[^:\s]+")
            ) +
            IgnoreParser(ParserElementParser(Literal(":")))
        ).parse(text)

        if parse_result is None:
            return None

        function_name, rest = parse_result

        commands = []
        for line in rest.splitlines():
            if line == line.strip():
                break

            commands.append(line)

        return ListParseObject([Block(function_name.obj, *commands)]), ""
