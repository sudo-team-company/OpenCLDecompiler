import os
import subprocess
from pathlib import Path
from typing import Optional

import pytest

from tests.disasm import DISASMS


@pytest.fixture(autouse=True, scope="session")
def check_and_set_pythonpath():
    src_root = str(Path('..').absolute())
    if 'PYTHONPATH' not in os.environ:
        os.environ['PYTHONPATH'] = src_root
    elif src_root not in os.environ['PYTHONPATH']:
        os.environ['PYTHONPATH'] += os.pathsep + src_root


def template(
        path_to_dir: str,
        dir_name: str,
        flag: Optional[str] = None,
        mcpu: str = '',
        disasm: str = "clrxdisasm",
        is_new_parser: bool = False,
):
    if mcpu:
        mcpu = f'-{mcpu}'
    path_to_exec_file = str(Path("..") / "src" / "parser_for_instructions.py")
    test_root = Path(".") / path_to_dir / dir_name
    path_to_bin = str(test_root / f"{dir_name}{mcpu}.bin")
    path_to_asm = str(test_root / f"{dir_name}{mcpu}.asm")
    path_to_cl = str(test_root / f"{dir_name}_dcmpl{mcpu}.cl")

    flag_option = ["-f", flag] if flag else []
    new_parser_option = ["--new-parser"] if is_new_parser else []

    DISASMS.get(disasm)(**{
        "path_to_bin": path_to_bin,
        "path_to_asm": path_to_asm,
    }).invoke()

    subprocess.run(
        [
            "python",
            path_to_exec_file,
            "-i",
            path_to_asm,
            "-o",
            path_to_cl
        ] + flag_option + new_parser_option,
        check=True
    )

    hands = test_root / f"{dir_name}_hands.cl"
    if "gfx" in mcpu and (test_root / f"{dir_name}_hands{mcpu}.cl").exists():
        hands = test_root / f"{dir_name}_hands{mcpu}.cl"
    elif "gfx" in mcpu and (test_root / f"{dir_name}_hands-gfx.cl").exists():
        hands = test_root / f"{dir_name}_hands-gfx.cl"
    with open(hands, encoding="utf-8") as hands_decompilation:
        with open(path_to_cl, encoding="utf-8") as decompiled:
            assert decompiled.read() == hands_decompilation.read()
