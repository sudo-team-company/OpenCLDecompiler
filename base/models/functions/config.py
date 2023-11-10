from base.models.model import Model


class Config(Model):
    def __init__(
            self,
            config: any,
    ):
        self._config = config

    @property
    def config(self) -> any:
        return self._config
