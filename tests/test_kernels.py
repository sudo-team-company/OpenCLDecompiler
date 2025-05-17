import platform
import subprocess
from pathlib import Path

import pytest

from src.parser_for_instructions import main

TEST_CASES = [
    ("branching_kernels", "if_1", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_1", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_1", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_2", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_2", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_2", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_and_if", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_and_if", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_and_if", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_0_labels", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_0_labels", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_0_labels", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_1_label", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_1_label", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_1_label", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_2_labels", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_2_labels", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_2_labels", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_in_if", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_in_if", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_in_if", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_and_if_else", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_and_if_else_gfx", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_and_if_else_gfx", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_and_if_else_0_labels", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_and_if_else_0_labels", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_and_if_else_0_labels", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if_of_if_else", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if_of_if_else_gfx", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if_of_if_else_gfx", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_in_else_of_if_else", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_in_else_of_if_else_gfx", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_in_else_of_if_else_gfx", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if_and_else_of_if_else", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if_and_else_of_if_else_gfx", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_else_in_if_and_else_of_if_else_gfx", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_in_if_in_if", None, "amd_gcn", "clrxdisasm"),
    ("branching_kernels", "if_in_if_in_if", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_in_if_in_if", None, "gfx1030", "clrxdisasm"),
    ("branching_kernels", "if_with_long_expr", None, "gfx1010", "clrxdisasm"),
    ("branching_kernels", "if_with_long_expr", None, "gfx1030", "clrxdisasm"),
    ("different_flags", "flag_auto_decompilation", None, "amd_gcn", "clrxdisasm"),
    ("different_flags", "flag_only_clrx", "ONLY_CLRX", "amd_gcn", "clrxdisasm"),
    ("different_flags", "flag_only_opencl", "ONLY_OPENCL", "amd_gcn", "clrxdisasm"),
    ("different_types", "uint8_type_test", None, "amd_gcn", "clrxdisasm"),
    ("different_types", "big_type_test", None, "amd_gcn", "clrxdisasm"),
    ("different_types", "char_short_test", None, "amd_gcn", "clrxdisasm"),
    ("different_types", "short_char_test", None, "amd_gcn", "clrxdisasm"),
    ("different_types", "char_char_short_test", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "int_kernels", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "long_kernels", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "mixed_kernels", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "float_kernels", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "double_kernels", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "cvt_i32_f32", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "cvt_f32_i32", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "cvt_i32_f64", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "cvt_f64_i32", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "int4", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "int8", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "mix_vectors", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "int_matrix", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "long_matrix", None, "amd_gcn", "clrxdisasm"),
    ("global_data_usage", "int2_array", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels", "addition", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels", "addition", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels", "addition", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels", "addition", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels", "subtraction", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels", "subtraction", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels", "subtraction", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels", "subtraction", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels", "multiplication", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels", "multiplication", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels", "multiplication", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels", "multiplication", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels", "many_linears", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels", "many_linears", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels", "many_linears", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels", "many_linears", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_x", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_x", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_x", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_x", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_offset", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_offset", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_offset", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_offset", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_local_id", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_local_id", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_local_id", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_local_id", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_group_id", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_group_id", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_group_id", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_group_id", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_local_size", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_local_size", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_local_size", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_local_size", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_id", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_id", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_id", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_id", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_size", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_size", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_size", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_global_size", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_num_groups", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_num_groups", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_num_groups", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_num_groups", None, "gfx1103", "amdgpu-dis"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_work_dim", None, "amd_gcn", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_work_dim", None, "gfx1010", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_work_dim", None, "gfx1030", "clrxdisasm"),
    ("linear_kernels/work_item_built_in_functions", "copy_get_work_dim", None, "gfx1103", "amdgpu-dis"),
    ("local_memory_kernels", "barrier_1", None, "amd_gcn", "clrxdisasm"),
    ("loops_kernels", "simple_loop_kernels", None, "amd_gcn", "clrxdisasm"),
    ("loops_kernels", "simple_loop_kernels", None, "gfx1010", "clrxdisasm"),
    ("loops_kernels", "simple_loop_kernels", None, "gfx1030", "clrxdisasm"),
    ("loops_kernels", "loop_with_break_kernels", None, "amd_gcn", "clrxdisasm"),
    ("loops_kernels", "loop_general", None, "gfx1010", "clrxdisasm"),
    ("loops_kernels", "loop_general", None, "gfx1030", "clrxdisasm"),
    ("loops_kernels", "loop_general_dec", None, "gfx1010", "clrxdisasm"),
    ("loops_kernels", "loop_general_dec", None, "gfx1030", "clrxdisasm"),
    ("loops_kernels", "loop_with_unrolling_breaker", None, "gfx1010", "clrxdisasm"),
    ("loops_kernels", "loop_with_unrolling_breaker", None, "gfx1030", "clrxdisasm"),
    ("loops_kernels", "loop_block", None, "gfx1010", "clrxdisasm"),
    ("loops_kernels", "loop_block", None, "gfx1030", "clrxdisasm"),
    ("loops_kernels", "loop_unrolled", None, "gfx1010", "clrxdisasm"),
    ("loops_kernels", "loop_unrolled", None, "gfx1030", "clrxdisasm"),
    ("loops_kernels", "loop_unrolled_2", None, "gfx1010", "clrxdisasm"),
    ("loops_kernels", "loop_unrolled_2", None, "gfx1030", "clrxdisasm"),
    ("real_kernels", "mask_kernel", None, "amd_gcn", "clrxdisasm"),
    ("real_kernels", "weighted_sum_kernel", None, "amd_gcn", "clrxdisasm"),
    ("real_kernels", "bellmanFordInit_ver1", None, "amd_gcn", "clrxdisasm"),
    ("unused_params", "one_unused_param", None, "amd_gcn", "clrxdisasm"),
    ("unused_params", "two_unused_params", None, "amd_gcn", "clrxdisasm"),
    ("unused_params", "three_unused_params", None, "amd_gcn", "clrxdisasm"),
    ("unused_params", "four_unused_params", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "char2_second_third_element_char4", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "char2_reverse_char2", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "char2_first_and_first_char4", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_uint", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_uint2", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_reverse_uint2", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_reverse_first_half_uint4", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_second_third_element_uint4", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_third_fourth_element_uint4", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_third_second_element_uint4", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_first_fourth_element_uint4", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint2_first_and_first_uint4", None, "amd_gcn", "clrxdisasm"),
    ("vector_type_params", "uint4_float4", None, "amd_gcn", "clrxdisasm"),
]


def get_disasm_path(name: str) -> str:
    ext = ".exe" if platform.system() == "Windows" else ""
    path = Path() / "bin" / f"{name}" / f"{name}{ext}"
    return str(path.absolute())


def invoke_clrxdisasm(path_to_bin: str, path_to_asm: str):
    with Path(path_to_asm).open("w", encoding="utf-8") as file:
        subprocess.run([get_disasm_path("clrxdisasm"), path_to_bin, "-dCfs"], stdout=file, check=True)  # noqa: S603
    with Path(path_to_asm).open(encoding="utf-8") as file:
        text: list[str] = file.readlines()
    parts = text[0].split("'")
    parts[1] = parts[1].replace("/", "\\")
    text[0] = "'".join(parts)
    with Path(path_to_asm).open("w", encoding="utf-8") as file:
        file.writelines(text)


def invoke_amdgpu_dis(path_to_bin: str, path_to_asm: str):
    subprocess.run([get_disasm_path("amdgpu-dis"), path_to_bin, "-o", path_to_asm], check=True)  # noqa: S603


DISASMS = {
    "clrxdisasm": invoke_clrxdisasm,
    "amdgpu-dis": invoke_amdgpu_dis,
}


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "flag", "mcpu", "disasm"),
    [pytest.param(*case) for case in TEST_CASES],
)
def test(path_to_dir: str, dir_name: str, flag: str | None, mcpu: str, disasm: str):
    if mcpu == "amd_gcn":
        mcpu = ""
    if mcpu:
        mcpu = f"-{mcpu}"
    test_root = Path() / path_to_dir / dir_name
    path_to_bin = str(test_root / f"{dir_name}{mcpu}.bin")
    path_to_asm = str(test_root / f"{dir_name}{mcpu}.asm")
    path_to_cl = str(test_root / f"{dir_name}_dcmpl{mcpu}.cl")

    DISASMS.get(disasm)(path_to_bin=path_to_bin, path_to_asm=path_to_asm)

    main(path_to_asm, path_to_cl, flag or "AUTO_DECOMPILATION", None)

    hands = test_root / f"{dir_name}_hands.cl"
    if "gfx" in mcpu and (test_root / f"{dir_name}_hands{mcpu}.cl").exists():
        hands = test_root / f"{dir_name}_hands{mcpu}.cl"
    elif "gfx" in mcpu and (test_root / f"{dir_name}_hands-gfx.cl").exists():
        hands = test_root / f"{dir_name}_hands-gfx.cl"
    assert Path(path_to_cl).read_text(encoding="utf-8") == Path(hands).read_text(encoding="utf-8")
