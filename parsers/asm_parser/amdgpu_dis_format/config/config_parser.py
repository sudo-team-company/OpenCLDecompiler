from typing import Optional

from pyparsing import Literal, line_start, White, Regex

from parsers.base import BaseParser, IgnoreParser, ParserElementParser, OneOrMoreParser
from parsers.models import Config
from parsers.parse_objects.base import ParseObject
from parsers.parse_objects.base.dict_parse_object import DictParseObject
from parsers.parse_objects.base.list_parse_object import ListParseObject


class ListElementValuesParser(BaseParser):
    def __init__(
            self,
            white_prefix: str,
            check_spaces: bool,
    ):
        self._white_prefix = white_prefix
        self._check_spaces = check_spaces

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        if self._check_spaces:
            parser = ParserElementParser(White())
            parse_result = parser.parse(text)
            if parse_result is None:
                return None
            tmp_white_prefix, rest = parse_result
            tmp_white_prefix = tmp_white_prefix.obj
            if not tmp_white_prefix.startswith(self._white_prefix):
                return None
        else:
            rest = text

        parser = ParserElementParser(Regex(r"[^:\s-]+"))
        parse_result = parser.parse(rest)
        if parse_result is None:
            return None
        key, rest = parse_result
        key = key.obj

        if not rest.startswith(":"):
            return ListParseObject([key]), rest

        parser = (
                IgnoreParser(ParserElementParser(Literal(":"))) +
                (
                        ListParser(self._white_prefix) |
                        ParserElementParser(Regex("[^\n]+"))
                )
        )
        parse_result = parser.parse(rest)
        if parse_result is None:
            return None
        value, rest = parse_result
        value = value.obj

        return DictParseObject({key: value}), rest


class ListElementParser(BaseParser):
    def __init__(self, white_prefix: str):
        self._white_prefix = white_prefix

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = (
                IgnoreParser(ParserElementParser(Literal("-"))) +
                ListElementValuesParser(self._white_prefix, False)
        )
        parse_result = parser.parse(text)
        if parse_result is None:
            return None
        first_value, rest = parse_result
        first_value = first_value.obj

        parser = OneOrMoreParser(
            ListElementValuesParser(self._white_prefix, True)
        )
        parse_result = parser.parse(rest)
        if parse_result is None:
            return ListParseObject(first_value), rest
        values, rest = parse_result
        values = values.obj
        new_values = first_value
        new_values.update(values)

        return ListParseObject([new_values]), rest


class ListParser(BaseParser):
    def __init__(self, white_prefix: str):
        self._white_prefix = white_prefix

    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = ParserElementParser(White())
        parse_result = parser.parse(text)
        if parse_result is None:
            return None
        new_white_prefix, rest = parse_result
        new_white_prefix = new_white_prefix.obj
        if not new_white_prefix.startswith(self._white_prefix):
            return None

        return OneOrMoreParser(
            ListElementParser(new_white_prefix)
        ).parse(rest)


class AmdGpuDisConfigsParser(BaseParser):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        parser = (
                IgnoreParser(ParserElementParser(line_start + Literal("amdhsa.kernels:"))) +
                ListParser("\n")
        )
        parse_result = parser.parse(text)
        if parse_result is None:
            return None
        config, rest = parse_result
        return ListParseObject([Config(config.obj)]), rest
