import abc
from typing import Optional

from parsers.parse_objects.base import ParseObject


class BaseParser(abc.ABC):
    def parse(self, text: str) -> Optional[tuple[ParseObject, str]]:
        pass

    def __add__(self, other_parser: "BaseParser") -> "BaseParser":
        from .and_parser import AndParser

        return AndParser(self, other_parser)

    def __or__(self, other_parser: "BaseParser") -> "BaseParser":
        from .or_parser import OrParser

        return OrParser(self, other_parser)
