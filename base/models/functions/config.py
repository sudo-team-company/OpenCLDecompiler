from base.models.model import Model


class Config(Model):
    def __init__(
            self,
            args: list[list[(str, str)]],
            metadata: list[tuple[str, str | list[str]]],
    ):
        self._args: list[list[(str, str)]] = args
        self._metadata: list[tuple[str, str | list[str]]] = metadata

    @property
    def args(self) -> list[list[(str, str)]]:
        return self._args

    @property
    def metadata(self) -> list[tuple[str, str | list[str]]]:
        return self._metadata
