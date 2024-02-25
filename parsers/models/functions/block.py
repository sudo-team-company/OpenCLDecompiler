from ..model import Model


class Block(Model):
    def __init__(
            self,
            name: str,
            *args: tuple[str, list[str]]
    ):
        self._name = name
        self._args: list[tuple[str, list[str]]] = list(args)

    @property
    def name(self) -> str:
        return self._name

    @property
    def args(self) -> list[tuple[str, list[str]]]:
        return self._args
