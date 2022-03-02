import os
import platform
import subprocess
from pathlib import Path

import pytest


@pytest.fixture(autouse=True, scope="session")
def check_and_set_pythonpath():
    src_root = str(Path('..').absolute())
    if 'PYTHONPATH' not in os.environ:
        os.environ['PYTHONPATH'] = src_root
    elif src_root not in os.environ['PYTHONPATH']:
        os.environ['PYTHONPATH'] += os.pathsep + src_root


def template(path_to_dir, dir_name, flag=None, mcpu=''):
    if mcpu:
        mcpu = f'-{mcpu}'
    path_to_exec_file = str(Path("..") / "src" / "parser_for_instructions.py")
    path_to_clrxdisasm = str(Path('./clrxdisasm.exe' if platform.system() == 'Windows' else './clrxdisasm').absolute())
    test_root = Path(".") / path_to_dir / dir_name
    in_file = str(test_root / f"{dir_name}{mcpu}.asm")
    out_file = str(test_root / f"{dir_name}_dcmpl{mcpu}.cl")

    flag_option = ["-f", flag] if flag else []

    with open(in_file, "w", encoding="utf-8") as stdout:
        subprocess.run([path_to_clrxdisasm, str(test_root / f"{dir_name}{mcpu}.bin"), "-dCfs"],
                       stdout=stdout, check=True)

    subprocess.run(["python", path_to_exec_file, "-i", in_file, "-o", out_file] + flag_option, check=True)

    with open(test_root / f"{dir_name}_hands.cl", encoding="utf-8") as hands_decompilation:
        with open(out_file, encoding="utf-8") as decompiled:
            assert hands_decompilation.read() == decompiled.read()
