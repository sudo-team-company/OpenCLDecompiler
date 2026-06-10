from typing import TextIO

from src.ir.kernel import Kernel
from src.ir.passes.base import PassContext


class EmitTextIRPass:
    name = "emit-text-ir"

    def run(self, kernel: Kernel, context: PassContext) -> None:
        output_file = self._get_output_file(context)
        output_file.write(kernel.to_text())
        output_file.flush()

    @staticmethod
    def _get_output_file(context: PassContext) -> TextIO:
        output_file = context.metadata.get("output_file")
        if output_file is None:
            raise MissingTextIrOutputError

        return output_file


class MissingTextIrOutputError(ValueError):
    def __init__(self) -> None:
        super().__init__("Text IR output file is not configured")
