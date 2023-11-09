from typing import Optional

from pyparsing import Literal, Regex, White

from parsers.base import BaseParser, IgnoreParser, ParserElementParser, LineParser, AnyParser, OneOrMoreParser
from parsers.parse_objects.base.lines_parse_object import ListParseObject
from parsers.parse_objects.base import ParseObject


class ArgInfoParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = (
                IgnoreParser(ParserElementParser(Literal("."))) +
                ParserElementParser(Regex("[^:\s]+")) +
                IgnoreParser(ParserElementParser(Literal(":")))
        )

        parser_result = parser.parse(text)

        if parser_result is None:
            return None

        key, rest = parser_result

        parser = LineParser(AnyParser())

        parser_result = parser.parse(rest)

        if parser_result is None:
            return None

        value, rest = parser_result

        return ListParseObject([(key.obj, value.obj)]), rest


class ArgParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = (
                IgnoreParser(ParserElementParser(Literal("-"))) +
                OneOrMoreParser(ArgInfoParser())
        )

        parse_result = parser.parse(text)

        if parse_result is None:
            return None

        arg, rest = parse_result

        return ListParseObject([arg]), rest


class ArgsParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        return (
                IgnoreParser(LineParser(ParserElementParser(Literal("- .args:")))) +
                OneOrMoreParser(ArgParser())
        ).parse(text)
