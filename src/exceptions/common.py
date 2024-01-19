from typing import Optional


class OpenCLDecompilerError(Exception):
    def __init__(
            self,
            message: str,
            prefix: Optional[str] = "OPENCL_DECOMPILER_COMMON_ERROR"
    ):
        """
        Common OpenCLDecompiler error.
        In case of prefix is not None, the output message is formatted as [%prefix%]: %message%.
        Otherwise, output message if formatted as %message%.
        """

        if prefix:
            message = f"[{prefix}]: {message}"
        super().__init__(message)


class LogicalError(OpenCLDecompilerError):
    """
    Common OpenCLDecompiler logical error.
    """

    def __init__(self, message: str):
        super().__init__(
            message=message,
            prefix="LOGICAL_ERROR"
        )
