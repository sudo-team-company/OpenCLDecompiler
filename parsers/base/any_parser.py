from typing import Optional

from pyparsing import Regex, OneOrMore

from parsers.base.base_parser import BaseParser
from parsers.base.parser_element_parser import ParserElementParser
from parsers.parse_objects.base import ParseObject


class AnyParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        return ParserElementParser(OneOrMore(Regex("."))).parse(text)
