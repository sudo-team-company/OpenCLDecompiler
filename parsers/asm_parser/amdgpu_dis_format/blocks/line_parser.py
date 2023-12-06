from typing import Optional

from parsers.base.any_parser import AnyParser
from parsers.base.base_parser import BaseParser
from parsers.base.line_parser import LineParser
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.list_parse_object import ListParseObject


class AmdGpuDisLineParser(BaseParser):

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parse_result = LineParser(AnyParser()).parse(text)
        if parse_result is None:
            return None

        line, rest = parse_result

        return ListParseObject([line]), rest
