from typing import Optional

from pyparsing import ParserElement, ParseException, Combine

from parsers.base.base_parser import BaseParser
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.string_parse_object import StringParseObject


class ParserElementParser(BaseParser):
    def __init__(
            self,
            parser_element: ParserElement,
    ):
        self._raw_parser_element = parser_element
        self._parser_element = Combine(parser_element)

        self._parser_element.set_parse_action(
            lambda s, loc, tokens: (
                tokens[0],
                s[(loc + len(tokens[0])):],
            )
        )

    @property
    def parser_element(self) -> ParserElement:
        return self._raw_parser_element

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        try:
            result, rest = self._parser_element.parse_string(text)[0]
            return StringParseObject(result), rest
        except ParseException:
            return None
