import functools
from typing import Optional

from parsers.base.base_parser import BaseParser
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.parse_object import EmptyParseObject


class ParseUntilParser(BaseParser):
    def __init__(self, parser: BaseParser, until_parser: BaseParser):
        self._parser = parser
        self._until_parser = until_parser

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        results = []
        rest = text

        while True:
            parse_result = self._until_parser.parse(rest)

            if parse_result is not None:
                break

            parse_result = self._parser.parse(rest)

            if parse_result is None:
                return None

            result, rest = parse_result
            results.append(result)

        if len(results) == 0:
            return EmptyParseObject(), rest

        return functools.reduce(lambda x, y: x + y, results), rest
