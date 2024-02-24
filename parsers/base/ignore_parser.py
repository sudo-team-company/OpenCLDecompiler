from typing import Optional

from parsers.base.base_parser import BaseParser
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.parse_object import EmptyParseObject


class IgnoreParser(BaseParser):
    def __init__(self, parser: BaseParser):
        self._parser = parser

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parse_result = self._parser.parse(text)

        if parse_result is not None:
            _, rest = parse_result

            return EmptyParseObject(), rest
        else:
            return None
