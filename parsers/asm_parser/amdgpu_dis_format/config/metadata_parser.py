from typing import Optional

from pyparsing import Literal, Regex, line_end, White

from parsers.base import BaseParser, LineParser, IgnoreParser, ParserElementParser, AnyParser, OneOrMoreParser, \
    ZeroOrMoreParser
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.lines_parse_object import ListParseObject


class ListValueParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = LineParser(
            IgnoreParser(ParserElementParser(Literal("-"))) +
            AnyParser()
        )

        parse_result = parser.parse(text)

        if parse_result is None:
            return None

        value, rest = parse_result

        return ListParseObject([value.obj]), rest


class ListValuesParser(BaseParser):

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        return OneOrMoreParser(
            ListValueParser()
        ).parse(text)


class KeyValueParser(BaseParser):

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = (
                ParserElementParser(Regex("\.[^:]+")) +
                IgnoreParser(ParserElementParser(Literal(":")))
        )

        parse_result = parser.parse(text)

        if parse_result is None:
            return None

        key, rest = parse_result

        parser = (
                (
                        IgnoreParser(ParserElementParser(line_end)) +
                        ListValuesParser()
                ) |
                LineParser(AnyParser())
        )

        parse_result = parser.parse(rest)

        if parse_result is None:
            return None

        value, rest = parse_result

        return ListParseObject([(key.obj, value.obj)]), rest


class MetadataParser(BaseParser):

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        return ZeroOrMoreParser(
            IgnoreParser(ParserElementParser(White(" \t"))) +
            KeyValueParser()
        ).parse(text)
