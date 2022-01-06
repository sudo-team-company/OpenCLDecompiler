import platform
import subprocess
from pathlib import Path


def template(path_to_dir, dir_name, flag=None):
    path_to_exec_file = str(Path("..") / "src" / "parser_for_instructions.py")
    path_to_clrxdisasm = str(Path('./clrxdisasm.exe' if platform.system() == 'Windows' else './clrxdisasm').absolute())
    test_root = Path(".") / path_to_dir / dir_name
    in_file = str(test_root / f"{dir_name}.asm")
    out_file = str(test_root / f"{dir_name}_dcmpl.cl")

    flag_option = ["-f", flag] if flag else []

    with open(in_file, "w", encoding="utf-8") as stdout:
        subprocess.run([path_to_clrxdisasm, str(test_root / f"{dir_name}.bin"), "-dCfs"], stdout=stdout, check=True)

    subprocess.run(["python", path_to_exec_file, "-i", in_file, "-o", out_file] + flag_option, check=True)

    with open(test_root / f"{dir_name}_hands.cl", encoding="utf-8") as hands_decompilation:
        with open(out_file, encoding="utf-8") as decompiled:
            assert hands_decompilation.read() == decompiled.read()


class TestGlobalData:
    def test_int_array(self):
        template('global_data_usage', 'int_kernels')

    def test_long_array(self):
        template('global_data_usage', 'long_kernels')

    def test_mixed_array(self):
        template('global_data_usage', 'mixed_kernels')

    def test_float_array(self):
        template('global_data_usage', 'float_kernels')

    def test_double_array(self):
        template('global_data_usage', 'double_kernels')

    def test_cvt_i32_f32(self):
        template('global_data_usage', 'cvt_i32_f32')

    def test_cvt_f32_i32(self):
        template('global_data_usage', 'cvt_f32_i32')

    def test_cvt_i32_f64(self):
        template('global_data_usage', 'cvt_i32_f64')

    def test_cvt_f64_i32(self):
        template('global_data_usage', 'cvt_f64_i32')

    def test_cvt_f64_i64(self):
        template('global_data_usage', 'cvt_f64_i64')

    def test_int4(self):
        template('global_data_usage', 'int4')

    def test_int8(self):
        template('global_data_usage', 'int8')

    def test_mix_vectors(self):
        template('global_data_usage', 'mix_vectors')

    def test_int_matrix(self):
        template('global_data_usage', 'int_matrix')

    def test_long_matrix(self):
        template('global_data_usage', 'long_matrix')

    def test_int2_array(self):
        template('global_data_usage', 'int2_array')

    def test_int2_to_int2(self):
        template('global_data_usage', 'int2_to_int2')

    def test_int4_to_int4(self):
        template('global_data_usage', 'int4_to_int4')

    # def test_int8_to_int8(self):
    #     template('global_data_usage', 'int8_to_int8')


class TestBranchingKernels:
    def test_if_first(self):
        template('branching_kernels', 'if_1')

    def test_if_second(self):
        template('branching_kernels', 'if_2')

    def test_if_and_if(self):
        template('branching_kernels', 'if_and_if')

    def test_if_else_0_labels(self):
        template('branching_kernels', 'if_else_0_labels')

    def test_if_else_1_labels(self):
        template('branching_kernels', 'if_else_1_label')

    def test_if_else_2_labels(self):
        template('branching_kernels', 'if_else_2_labels')

    def test_if_in_if(self):
        template('branching_kernels', 'if_in_if')

    def test_if_else_in_if(self):
        template('branching_kernels', 'if_else_in_if')

    def test_if_else_and_if_else(self):
        template('branching_kernels', 'if_else_and_if_else')

    def test_if_else_and_if_else_0_labels(self):
        template('branching_kernels', 'if_else_and_if_else_0_labels')

    def test_if_else_in_if_of_if_else(self):
        template('branching_kernels', 'if_else_in_if_of_if_else')

    def test_if_else_in_else_of_if_else(self):
        template('branching_kernels', 'if_else_in_else_of_if_else')

    def test_if_else_in_if_and_else_of_if_else(self):
        template('branching_kernels', 'if_else_in_if_and_else_of_if_else')

    def test_if_in_if_in_if(self):
        template('branching_kernels', 'if_in_if_in_if')


class TestLinearKernels:
    def test_addition(self):
        template('linear_kernels', 'addition')

    def test_subtraction(self):
        template('linear_kernels', 'subtraction')

    def test_multiplication(self):
        template('linear_kernels', 'multiplication')

    def test_many_linears(self):
        template('linear_kernels', 'many_linears')

    def test_copy_x(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_x')

    def test_copy_get_global_offset(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_offset')

    def test_copy_get_local_id(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_local_id')

    def test_copy_get_group_id(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_group_id')

    def test_copy_get_local_size(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_local_size')

    def test_copy_get_global_id(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_id')

    def test_copy_get_global_size(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_size')

    def test_copy_get_num_groups(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_num_groups')

    def test_copy_get_work_dim(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_work_dim')


class TestLocalMemoryKernels:
    def test_barrier_1(self):
        template('local_memory_kernels', 'barrier_1')


class TestUnusedParams:
    def test_one_unused_param(self):
        template('unused_params', 'one_unused_param')

    def test_two_unused_params(self):
        template('unused_params', 'two_unused_params')

    def test_three_unused_params(self):
        template('unused_params', 'three_unused_params')

    def test_four_unused_params(self):
        template('unused_params', 'four_unused_params')


class TestRealKernels:
    def test_mask_kernel(self):
        template('real_kernels', 'mask_kernel')

    def test_weighted_sum_kernel(self):
        template('real_kernels', 'weighted_sum_kernel')


class TestDifferentTypes:
    def test_uint8_type_test(self):
        template('different_types', 'uint8_type_test')

    def test_big_type_test(self):
        template('different_types', 'big_type_test')


class TestDifferentFlags:
    def test_flag_auto_decompilation(self):
        template('different_flags', 'flag_auto_decompilation')

    def test_flag_only_clrx(self):
        template('different_flags', 'flag_only_clrx', 'ONLY_CLRX')

    def test_flag_only_opencl(self):
        template('different_flags', 'flag_only_opencl', 'ONLY_OPENCL')


class TestLoopsKernels:
    def test_simple_loop_kernels(self):
        template('loops_kernels', 'simple_loop_kernels')

    def test_loop_with_break_kernels(self):
        template('loops_kernels', 'loop_with_break_kernels')
