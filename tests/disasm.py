import abc
import platform
import subprocess
from pathlib import Path


class Disasm(abc.ABC):
    NAME: str

    def __init__(self, path_to_bin: str, path_to_asm: str):
        self.path_to_bin = path_to_bin
        self.path_to_asm = path_to_asm

    @abc.abstractmethod
    def invoke(self):
        pass

    def _get_windown_disasm_path(self) -> str:
        return str(
            Path(
                f"./bin/{self.NAME}/{self.NAME}.exe"
            ).absolute()
        )

    def _get_unix_disasm_path(self) -> str:
        return str(
            Path(
                f"./bin/{self.NAME}/{self.NAME}"
            ).absolute()
        )

    def get_disasm_path(self) -> str:
        return str(
            Path(
                self._get_windown_disasm_path()
                if platform.system() == "Windows"
                else self._get_unix_disasm_path()
            ).absolute()
        )


class ClrxDisasm(Disasm):
    NAME = "clrxdisasm"

    def invoke(self):
        output = subprocess.run(
            [
                self.get_disasm_path(),
                self.path_to_bin,
                "-dCfs"
            ],
            capture_output=True,
            check=True
        ).stdout.decode().splitlines(keepends=True)

        # Fix path separator in first line (comment) to avoid unnecessary diff across different OS
        if len(output) > 0 and output[0].startswith("/*"):
            first_line = output[0].split("'")
            first_line[1] = first_line[1].replace("/", "\\")
            output[0] = "'".join(first_line)

        with open(self.path_to_asm, "w", encoding="utf-8") as file:
            file.writelines(output)


class AmdGpuDisasm(Disasm):
    NAME = "amdgpu-dis"

    def invoke(self):
        subprocess.run(
            [
                self.get_disasm_path(),
                self.path_to_bin,
                "-o",
                self.path_to_asm
            ],
            check=True
        )


DISASMS = {
    "clrxdisasm": ClrxDisasm,
    "amdgpu-dis": AmdGpuDisasm,
}
