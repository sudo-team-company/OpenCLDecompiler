import platform
import subprocess
from pathlib import Path

import pytest

from src.parser_for_instructions import main

TEST_CASES = {
    "branching_kernels": {
        "if_1": [("amd_gcn", "clrxdisasm", None), ("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "if_2": [("amd_gcn", "clrxdisasm", None), ("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "if_and_if": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
        ],
        "if_else_0_labels": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
        ],
        "if_else_1_label": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
        ],
        "if_else_2_labels": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
        ],
        "if_in_if": [("amd_gcn", "clrxdisasm", None), ("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "if_else_in_if": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
        ],
        "if_else_and_if_else": [("amd_gcn", "clrxdisasm", None)],
        "if_else_and_if_else_gfx": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "if_else_and_if_else_0_labels": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
        ],
        "if_else_in_if_of_if_else": [("amd_gcn", "clrxdisasm", None)],
        "if_else_in_if_of_if_else_gfx": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "if_else_in_else_of_if_else": [("amd_gcn", "clrxdisasm", None)],
        "if_else_in_else_of_if_else_gfx": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "if_else_in_if_and_else_of_if_else": [("amd_gcn", "clrxdisasm", None)],
        "if_else_in_if_and_else_of_if_else_gfx": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "if_in_if_in_if": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
        ],
        "if_with_long_expr": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
    },
    "different_flags": {
        "flag_auto_decompilation": [("amd_gcn", "clrxdisasm", None)],
        "flag_only_clrx": [("amd_gcn", "clrxdisasm", "ONLY_CLRX")],
        "flag_only_opencl": [("amd_gcn", "clrxdisasm", "ONLY_OPENCL")],
    },
    "different_types": {
        "uint8_type_test": [("amd_gcn", "clrxdisasm", None)],
        "big_type_test": [("amd_gcn", "clrxdisasm", None)],
        "char_short_test": [("amd_gcn", "clrxdisasm", None)],
        "short_char_test": [("amd_gcn", "clrxdisasm", None)],
        "char_char_short_test": [("amd_gcn", "clrxdisasm", None)],
    },
    "global_data_usage": {
        "int_kernels": [("amd_gcn", "clrxdisasm", None)],
        "long_kernels": [("amd_gcn", "clrxdisasm", None)],
        "mixed_kernels": [("amd_gcn", "clrxdisasm", None)],
        "float_kernels": [("amd_gcn", "clrxdisasm", None)],
        "double_kernels": [("amd_gcn", "clrxdisasm", None)],
        "cvt_i32_f32": [("amd_gcn", "clrxdisasm", None)],
        "cvt_f32_i32": [("amd_gcn", "clrxdisasm", None)],
        "cvt_i32_f64": [("amd_gcn", "clrxdisasm", None)],
        "cvt_f64_i32": [("amd_gcn", "clrxdisasm", None)],
        "int4": [("amd_gcn", "clrxdisasm", None)],
        "int8": [("amd_gcn", "clrxdisasm", None)],
        "mix_vectors": [("amd_gcn", "clrxdisasm", None)],
        "int_matrix": [("amd_gcn", "clrxdisasm", None)],
        "long_matrix": [("amd_gcn", "clrxdisasm", None)],
        "int2_array": [("amd_gcn", "clrxdisasm", None)],
    },
    "linear_kernels": {
        "addition": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "subtraction": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "multiplication": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "many_linears": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
    },
    "linear_kernels/work_item_built_in_functions": {
        "copy_x": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "copy_get_global_offset": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "copy_get_local_id": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "copy_get_group_id": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "copy_get_local_size": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "copy_get_global_id": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "copy_get_global_size": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "copy_get_num_groups": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
        "copy_get_work_dim": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
            ("gfx1103", "amdgpu-dis", None),
        ],
    },
    "local_memory_kernels": {"barrier_1": [("amd_gcn", "clrxdisasm", None)]},
    "loops_kernels": {
        "simple_loop_kernels": [
            ("amd_gcn", "clrxdisasm", None),
            ("gfx1010", "clrxdisasm", None),
            ("gfx1030", "clrxdisasm", None),
        ],
        "loop_with_break_kernels": [("amd_gcn", "clrxdisasm", None)],
        "loop_general": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "loop_general_dec": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "loop_with_unrolling_breaker": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "loop_block": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "loop_unrolled": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
        "loop_unrolled_2": [("gfx1010", "clrxdisasm", None), ("gfx1030", "clrxdisasm", None)],
    },
    "real_kernels": {
        "mask_kernel": [("amd_gcn", "clrxdisasm", None)],
        "weighted_sum_kernel": [("amd_gcn", "clrxdisasm", None)],
        "bellmanFordInit_ver1": [("amd_gcn", "clrxdisasm", None)],
    },
    "unused_params": {
        "one_unused_param": [("amd_gcn", "clrxdisasm", None)],
        "two_unused_params": [("amd_gcn", "clrxdisasm", None)],
        "three_unused_params": [("amd_gcn", "clrxdisasm", None)],
        "four_unused_params": [("amd_gcn", "clrxdisasm", None)],
    },
    "vector_type_params": {
        "char2_second_third_element_char4": [("amd_gcn", "clrxdisasm", None)],
        "char2_reverse_char2": [("amd_gcn", "clrxdisasm", None)],
        "char2_first_and_first_char4": [("amd_gcn", "clrxdisasm", None)],
        "uint2_uint": [("amd_gcn", "clrxdisasm", None)],
        "uint2_uint2": [("amd_gcn", "clrxdisasm", None)],
        "uint2_reverse_uint2": [("amd_gcn", "clrxdisasm", None)],
        "uint2_reverse_first_half_uint4": [("amd_gcn", "clrxdisasm", None)],
        "uint2_second_third_element_uint4": [("amd_gcn", "clrxdisasm", None)],
        "uint2_third_fourth_element_uint4": [("amd_gcn", "clrxdisasm", None)],
        "uint2_third_second_element_uint4": [("amd_gcn", "clrxdisasm", None)],
        "uint2_first_fourth_element_uint4": [("amd_gcn", "clrxdisasm", None)],
        "uint2_first_and_first_uint4": [("amd_gcn", "clrxdisasm", None)],
        "uint4_float4": [("amd_gcn", "clrxdisasm", None)],
    },
}


def get_test_params():
    for suit, cases in TEST_CASES.items():
        for name, variants in cases.items():
            for mcpu, disasm, flag in variants:
                yield pytest.param(suit, name, mcpu, disasm, flag)


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "mcpu", "disasm", "flag"),
    get_test_params(),
)
def test(path_to_dir: str, dir_name: str, mcpu: str, disasm: str, flag: str | None, tests_path: Path):  # noqa: PLR0913
    if mcpu == "amd_gcn":
        mcpu = ""
    if mcpu:
        mcpu = f"-{mcpu}"
    test_root: Path = tests_path / path_to_dir / dir_name
    path_to_bin: Path = test_root / f"{dir_name}{mcpu}.bin"
    path_to_asm: Path = test_root / f"{dir_name}{mcpu}.asm"
    path_to_cl: Path = test_root / f"{dir_name}_dcmpl{mcpu}.cl"

    path_to_asm.unlink(missing_ok=True)
    path_to_cl.unlink(missing_ok=True)

    ext = ".exe" if platform.system() == "Windows" else ""
    disasm_path: Path = tests_path / "bin" / f"{disasm}" / f"{disasm}{ext}"
    if disasm == "clrxdisasm":
        result = subprocess.run([disasm_path, path_to_bin, "-dCfs"], capture_output=True, text=True, check=True)  # noqa: S603
        with path_to_asm.open("w", encoding="utf-8") as file:
            file.writelines(result.stdout.splitlines(keepends=True)[1:])
    elif disasm == "amdgpu-dis":
        subprocess.run([disasm_path, path_to_bin, "-o", path_to_asm], check=True)  # noqa: S603
    else:
        raise NotImplementedError(f"Disassembler {disasm} is not supported.")

    main(path_to_asm, path_to_cl, flag or "AUTO_DECOMPILATION", None)

    hands = test_root / f"{dir_name}_hands.cl"
    if "gfx" in mcpu and (test_root / f"{dir_name}_hands{mcpu}.cl").exists():
        hands = test_root / f"{dir_name}_hands{mcpu}.cl"
    elif "gfx" in mcpu and (test_root / f"{dir_name}_hands-gfx.cl").exists():
        hands = test_root / f"{dir_name}_hands-gfx.cl"
    assert path_to_cl.read_text(encoding="utf-8") == hands.read_text(encoding="utf-8")
