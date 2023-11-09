from typing import Optional

from parsers.base.base_parser import BaseParser
from parsers.parse_objects.base import ParseObject


class OrParser(BaseParser):
    def __init__(
            self,
            *parsers: BaseParser
    ):
        self._parsers = parsers

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        for parser in self._parsers:
            parse_result = parser.parse(text)

            if parse_result is not None:
                return parse_result

        return None
