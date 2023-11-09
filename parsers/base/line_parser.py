from typing import Optional

from pyparsing import line_end

from parsers.base.base_parser import BaseParser
from parsers.base.parser_element_parser import ParserElementParser
from parsers.base.ignore_parser import IgnoreParser
from parsers.parse_objects.base import ParseObject


class LineParser(BaseParser):
    def __init__(self, parser: BaseParser):
        self._parser = parser

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        return (
                self._parser +
                IgnoreParser(ParserElementParser(line_end))
        ).parse(text)
