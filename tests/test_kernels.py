import pytest

from tests.conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "flag", "mcpu", "disasm"),
    [
        pytest.param(
            "branching_kernels",
            "if_1",
            None,
            "amd_gcn",
            "clrxdisasm",
            id="branching_kernels-if_first-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "branching_kernels",
            "if_1",
            None,
            "gfx1010",
            "clrxdisasm",
            id="branching_kernels-if_first-gfx1010-clrxdisasm",
        ),
        pytest.param(
            "branching_kernels",
            "if_1",
            None,
            "gfx1030",
            "clrxdisasm",
            id="branching_kernels-if_first-gfx1030-clrxdisasm",
        ),
        pytest.param(
            "branching_kernels",
            "if_2",
            None,
            "amd_gcn",
            "clrxdisasm",
            id="branching_kernels-if_second-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "branching_kernels",
            "if_2",
            None,
            "gfx1010",
            "clrxdisasm",
            id="branching_kernels-if_second-gfx1010-clrxdisasm",
        ),
        pytest.param(
            "branching_kernels",
            "if_2",
            None,
            "gfx1030",
            "clrxdisasm",
            id="branching_kernels-if_second-gfx1030-clrxdisasm",
        ),
        pytest.param("branching_kernels", "if_and_if", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_and_if", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_and_if", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_0_labels", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_0_labels", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_0_labels", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_1_label", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_1_label", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_1_label", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_2_labels", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_2_labels", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_2_labels", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_gfx", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_gfx", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_0_labels", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_0_labels", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_0_labels", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_of_if_else", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_of_if_else_gfx", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_of_if_else_gfx", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_else_of_if_else", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_else_of_if_else_gfx", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_else_of_if_else_gfx", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_and_else_of_if_else", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_and_else_of_if_else_gfx", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_and_else_of_if_else_gfx", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if_in_if", None, "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if_in_if", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if_in_if", None, "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_with_long_expr", None, "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_with_long_expr", None, "gfx1030", "clrxdisasm"),
        pytest.param("different_flags", "flag_auto_decompilation", None, "amd_gcn", "clrxdisasm"),
        pytest.param("different_flags", "flag_only_clrx", "ONLY_CLRX", "amd_gcn", "clrxdisasm"),
        pytest.param("different_flags", "flag_only_opencl", "ONLY_OPENCL", "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "uint8_type_test", None, "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "big_type_test", None, "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "char_short_test", None, "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "short_char_test", None, "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "char_char_short_test", None, "amd_gcn", "clrxdisasm"),
        pytest.param(
            "global_data_usage",
            "int_kernels",
            None,
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-int_array-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "global_data_usage",
            "long_kernels",
            None,
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-long_array-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "global_data_usage",
            "mixed_kernels",
            None,
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-mixed_array-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "global_data_usage",
            "float_kernels",
            None,
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-float_array-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "global_data_usage",
            "double_kernels",
            None,
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-double_array-amd_gcn-clrxdisasm",
        ),
        pytest.param("global_data_usage", "cvt_i32_f32", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "cvt_f32_i32", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "cvt_i32_f64", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "cvt_f64_i32", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "int4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "int8", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "mix_vectors", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "int_matrix", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "long_matrix", None, "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "int2_array", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels", "addition", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels", "addition", None, "gfx1010", "clrxdisasm"),
        pytest.param("linear_kernels", "addition", None, "gfx1030", "clrxdisasm"),
        pytest.param("linear_kernels", "addition", None, "gfx1103", "amdgpu-dis"),
        pytest.param("linear_kernels", "subtraction", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels", "subtraction", None, "gfx1010", "clrxdisasm"),
        pytest.param("linear_kernels", "subtraction", None, "gfx1030", "clrxdisasm"),
        pytest.param("linear_kernels", "subtraction", None, "gfx1103", "amdgpu-dis"),
        pytest.param("linear_kernels", "multiplication", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels", "multiplication", None, "gfx1010", "clrxdisasm"),
        pytest.param("linear_kernels", "multiplication", None, "gfx1030", "clrxdisasm"),
        pytest.param("linear_kernels", "multiplication", None, "gfx1103", "amdgpu-dis"),
        pytest.param("linear_kernels", "many_linears", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels", "many_linears", None, "gfx1010", "clrxdisasm"),
        pytest.param("linear_kernels", "many_linears", None, "gfx1030", "clrxdisasm"),
        pytest.param("linear_kernels", "many_linears", None, "gfx1103", "amdgpu-dis"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_x", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_x", None, "gfx1010", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_x", None, "gfx1030", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_x", None, "gfx1103", "amdgpu-dis"),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_offset", None, "amd_gcn", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_offset", None, "gfx1010", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_offset", None, "gfx1030", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_offset", None, "gfx1103", "amdgpu-dis"
        ),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_local_id", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_local_id", None, "gfx1010", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_local_id", None, "gfx1030", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_local_id", None, "gfx1103", "amdgpu-dis"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_group_id", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_group_id", None, "gfx1010", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_group_id", None, "gfx1030", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_group_id", None, "gfx1103", "amdgpu-dis"),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_local_size", None, "amd_gcn", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_local_size", None, "gfx1010", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_local_size", None, "gfx1030", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_local_size", None, "gfx1103", "amdgpu-dis"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_id", None, "amd_gcn", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_id", None, "gfx1010", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_id", None, "gfx1030", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_id", None, "gfx1103", "amdgpu-dis"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_size", None, "amd_gcn", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_size", None, "gfx1010", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_size", None, "gfx1030", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_global_size", None, "gfx1103", "amdgpu-dis"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_num_groups", None, "amd_gcn", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_num_groups", None, "gfx1010", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_num_groups", None, "gfx1030", "clrxdisasm"
        ),
        pytest.param(
            "linear_kernels/work_item_built_in_functions", "copy_get_num_groups", None, "gfx1103", "amdgpu-dis"
        ),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_work_dim", None, "amd_gcn", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_work_dim", None, "gfx1010", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_work_dim", None, "gfx1030", "clrxdisasm"),
        pytest.param("linear_kernels/work_item_built_in_functions", "copy_get_work_dim", None, "gfx1103", "amdgpu-dis"),
        pytest.param("local_memory_kernels", "barrier_1", None, "amd_gcn", "clrxdisasm"),
        pytest.param("loops_kernels", "simple_loop_kernels", None, "amd_gcn", "clrxdisasm"),
        pytest.param("loops_kernels", "simple_loop_kernels", None, "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "simple_loop_kernels", None, "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_with_break_kernels", None, "amd_gcn", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_general", None, "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_general", None, "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_general_dec", None, "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_general_dec", None, "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_with_unrolling_breaker", None, "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_with_unrolling_breaker", None, "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_block", None, "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_block", None, "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_unrolled", None, "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_unrolled", None, "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_unrolled_2", None, "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_unrolled_2", None, "gfx1030", "clrxdisasm"),
        pytest.param("real_kernels", "mask_kernel", None, "amd_gcn", "clrxdisasm"),
        pytest.param("real_kernels", "weighted_sum_kernel", None, "amd_gcn", "clrxdisasm"),
        pytest.param("real_kernels", "bellmanFordInit_ver1", None, "amd_gcn", "clrxdisasm"),
        pytest.param("unused_params", "one_unused_param", None, "amd_gcn", "clrxdisasm"),
        pytest.param("unused_params", "two_unused_params", None, "amd_gcn", "clrxdisasm"),
        pytest.param("unused_params", "three_unused_params", None, "amd_gcn", "clrxdisasm"),
        pytest.param("unused_params", "four_unused_params", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "char2_second_third_element_char4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "char2_reverse_char2", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "char2_first_and_first_char4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_uint", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_uint2", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_reverse_uint2", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_reverse_first_half_uint4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_second_third_element_uint4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_third_fourth_element_uint4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_third_second_element_uint4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_first_fourth_element_uint4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_first_and_first_uint4", None, "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint4_float4", None, "amd_gcn", "clrxdisasm"),
    ],
)
def test(path_to_dir, dir_name, flag, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        flag=flag,
        mcpu=mcpu,
        disasm=disasm,
    )
