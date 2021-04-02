import subprocess
import unittest
from src import parser_for_instructions


def test_template(self, path_to_dir, dir_name, flag=None):
    path_to_exec_file = r'..\src\parser_for_instructions.py'
    flag_option = ''
    if flag:
        flag_option = f' -f {flag}'
    subprocess.check_call(fr'tests.bat {path_to_dir}\{dir_name}\{dir_name}.bin {path_to_dir}\{dir_name}\{dir_name}.asm')
    print(fr"python {path_to_exec_file} -i {path_to_dir}\{dir_name}\{dir_name}.asm" +
          fr"-o {path_to_dir}\{dir_name}\{dir_name}_dcmpl.cl" + flag_option)
    subprocess.check_call(fr"python {path_to_exec_file} -i {path_to_dir}\{dir_name}\{dir_name}.asm" +
                          fr" -o {path_to_dir}\{dir_name}\{dir_name}_dcmpl.cl" + flag_option)

    with open(
            fr"{path_to_dir}\{dir_name}\{dir_name}_hands.cl") as hands_decompilation:
        with open(fr"{path_to_dir}\{dir_name}\{dir_name}_dcmpl.cl") as decompiled:
            unittest.TestCase.assertEqual(self, first=hands_decompilation.read(), second=decompiled.read())


class BranchingKernelsTest(unittest.TestCase):
    def test_if_first(self):
        test_template(self, 'branching_kernels', 'if_1')

    def test_if_second(self):
        test_template(self, 'branching_kernels', 'if_2')

    def test_if_and_if(self):
        test_template(self, 'branching_kernels', 'if_and_if')

    def test_if_else_0_labels(self):
        test_template(self, 'branching_kernels', 'if_else_0_labels')

    def test_if_else_1_labels(self):
        test_template(self, 'branching_kernels', 'if_else_1_label')

    def test_if_else_2_labels(self):
        test_template(self, 'branching_kernels', 'if_else_2_labels')

    def test_if_in_if(self):
        test_template(self, 'branching_kernels', 'if_in_if')

    def test_if_else_in_if(self):
        test_template(self, 'branching_kernels', 'if_else_in_if')

    def test_if_else_and_if_else(self):
        test_template(self, 'branching_kernels', 'if_else_and_if_else')

    def test_if_else_and_if_else_0_labels(self):
        test_template(self, 'branching_kernels', 'if_else_and_if_else_0_labels')

    def test_if_else_in_if_of_if_else(self):
        test_template(self, 'branching_kernels', 'if_else_in_if_of_if_else')

    def test_if_else_in_else_of_if_else(self):
        test_template(self, 'branching_kernels', 'if_else_in_else_of_if_else')

    def test_if_else_in_if_and_else_of_if_else(self):
        test_template(self, 'branching_kernels', 'if_else_in_if_and_else_of_if_else')


class LinearKernelsTest(unittest.TestCase):
    def test_addition(self):
        test_template(self, 'linear_kernels', 'addition')

    def test_subtraction(self):
        test_template(self, 'linear_kernels', 'subtraction')

    def test_multiplication(self):
        test_template(self, 'linear_kernels', 'multiplication')

    def test_many_linears(self):
        test_template(self, 'linear_kernels', 'many_linears')

    def test_work_item_built_in_functions(self):
        test_template(self, 'linear_kernels', 'work_item_built_in_functions')


class LocalMemoryKernelsTest(unittest.TestCase):
    def test_barrier_1(self):
        test_template(self, 'local_memory_kernels', 'barrier_1')


class UnusedParams(unittest.TestCase):
    def test_one_unused_param(self):
        test_template(self, 'unused_params', 'one_unused_param')

    def test_two_unused_params(self):
        test_template(self, 'unused_params', 'two_unused_params')

    def test_three_unused_params(self):
        test_template(self, 'unused_params', 'three_unused_params')

    def test_four_unused_params(self):
        test_template(self, 'unused_params', 'four_unused_params')


class RealKernels(unittest.TestCase):
    def test_mask_kernel(self):
        test_template(self, 'real_kernels', 'mask_kernel')

    def test_weighted_sum_kernel(self):
        test_template(self, 'real_kernels', 'weighted_sum_kernel')


class DifferentTypes(unittest.TestCase):
    def test_uint8_type_test(self):
        test_template(self, 'different_types', 'uint8_type_test')

    def test_big_type_test(self):
        test_template(self, 'different_types', 'big_type_test')


class DifferentFlags(unittest.TestCase):
    def test_flag_auto_parse(self):
        test_template(self, 'different_flags', 'flag_auto_parse')

    def test_flag_only_clrx(self):
        test_template(self, 'different_flags', 'flag_only_clrx', 'only_clrx')

    def test_flag_only_opencl(self):
        test_template(self, 'different_flags', 'flag_only_opencl', 'only_opencl')


if __name__ == '__main__':
    unittest.main()
