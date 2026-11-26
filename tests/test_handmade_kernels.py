"""Kernels whose assembly was edited by hand to cover cases the compiler did not produce for our sources.

They have no binary, so ``test_kernels.py`` (which disassembles the binary first) cannot run them.
"""

from pathlib import Path

import pytest

from src.parser_for_instructions import main

TESTS_PATH = Path(__file__).parent

HANDMADE_KERNELS = [
    # loop_unrolled_2 with ``tmp = acc * x; acc = tmp + i``, the temporary alternating between v3 and v4
    "loops_kernels/unrolled_renamed_temporaries",
]


@pytest.mark.parametrize("kernel_dir", HANDMADE_KERNELS)
def test_handmade_kernel(kernel_dir: str, tmp_path: Path):
    root = TESTS_PATH / kernel_dir
    name = root.name
    output = tmp_path / f"{name}_dcmpl.cl"

    main(root / f"{name}.asm", output, "AUTO_DECOMPILATION", None)

    expected = (root / f"{name}_hands.cl").read_text(encoding="utf-8")
    assert output.read_text(encoding="utf-8") == expected
