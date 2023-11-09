from typing import Optional

from pyparsing import Regex, Literal, OneOrMore

from parsers.base.any_parser import AnyParser
from parsers.base.base_parser import BaseParser
from parsers.base.ignore_parser import IgnoreParser
from parsers.base.line_parser import LineParser
from parsers.base.one_or_zero_parser import OneOrZeroParser
from parsers.base.parser_element_parser import ParserElementParser
from parsers.parse_objects.base.lines_parse_object import ListParseObject
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.parse_object import EmptyParseObject


class AmdGpuDisLineParser(BaseParser):

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parse_result = ParserElementParser(OneOrMore(Regex("[^\s]"))).parse(text)

        if parse_result is None:
            return None

        command_name, rest = parse_result

        parse_result = OneOrZeroParser(
            LineParser(
                ParserElementParser(Regex("[^/\n]*")) +
                IgnoreParser(OneOrZeroParser(ParserElementParser(Literal("//")) + AnyParser()))
            )
        ).parse(rest)

        if parse_result is None:
            return None

        args, rest = parse_result
        if isinstance(args, EmptyParseObject):
            args = []
        else:
            args = [arg.strip() for arg in args.obj.split(",")]

        return ListParseObject([(command_name.obj, args)]), rest
