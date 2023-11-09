import functools
from typing import Optional

from parsers.base.base_parser import BaseParser
from parsers.parse_objects.base import ParseObject


class AndParser(BaseParser):
    def __init__(
            self,
            *parsers: BaseParser,
    ):
        self._parsers = parsers

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        results = []
        rest = text

        for parser in self._parsers:
            parse_result = parser.parse(rest)

            if parse_result is None:
                return None

            result, rest = parse_result
            results.append(result)

        return functools.reduce(lambda x, y: x + y, results), rest
