import subprocess
import unittest
from src import parser_for_instructions


class BranchingKernelsTest(unittest.TestCase):
    def test_if_first(self):
        subprocess.call(r'tests.bat branching_kernels\if_1\if_1.bin ' +
                        r'branching_kernels\if_1\if_1.asm')
        parser_for_instructions.main(r"branching_kernels\if_1\if_1.asm",
                                     r"branching_kernels\if_1\if_1_dcmpl.cl")
        with open(
                r"branching_kernels\if_1\if_1_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_1\if_1_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_second(self):
        subprocess.call(r'tests.bat branching_kernels\if_2\if_2.bin ' +
                        r'branching_kernels\if_2\if_2.asm')
        parser_for_instructions.main(r"branching_kernels\if_2\if_2.asm",
                                     r"branching_kernels\if_2\if_2_dcmpl.cl")
        with open(
                r"branching_kernels\if_2\if_2_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_2\if_2_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_and_if(self):
        subprocess.call(r'tests.bat branching_kernels\if_and_if\if_and_if.bin ' +
                        r'branching_kernels\if_and_if\if_and_if.asm')
        parser_for_instructions.main(r"branching_kernels\if_and_if\if_and_if.asm",
                                     r"branching_kernels\if_and_if\if_and_if_dcmpl.cl")
        with open(
                r"branching_kernels\if_and_if\if_and_if_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_and_if\if_and_if_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_0_labels(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_0_labels\if_else_0_labels.bin ' +
                        r'branching_kernels\if_else_0_labels\if_else_0_labels.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_0_labels\if_else_0_labels.asm",
                                     r"branching_kernels\if_else_0_labels\if_else_0_labels_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_0_labels\if_else_0_labels_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_0_labels\if_else_0_labels_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_1_labels(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_1_label\if_else_1_label.bin ' +
                        r'branching_kernels\if_else_1_label\if_else_1_label.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_1_label\if_else_1_label.asm",
                                     r"branching_kernels\if_else_1_label\if_else_1_label_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_1_label\if_else_1_label_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_1_label\if_else_1_label_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_2_labels(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_2_labels\if_else_2_labels.bin ' +
                        r'branching_kernels\if_else_2_labels\if_else_2_labels.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_2_labels\if_else_2_labels.asm",
                                     r"branching_kernels\if_else_2_labels\if_else_2_labels_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_2_labels\if_else_2_labels_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_2_labels\if_else_2_labels_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_in_if(self):
        subprocess.call(r'tests.bat branching_kernels\if_in_if\if_in_if.bin ' +
                        r'branching_kernels\if_in_if\if_in_if.asm')
        parser_for_instructions.main(r"branching_kernels\if_in_if\if_in_if.asm",
                                     r"branching_kernels\if_in_if\if_in_if_dcmpl.cl")
        with open(
                r"branching_kernels\if_in_if\if_in_if_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_in_if\if_in_if_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_in_if(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_in_if\if_else_in_if.bin ' +
                        r'branching_kernels\if_else_in_if\if_else_in_if.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_in_if\if_else_in_if.asm",
                                     r"branching_kernels\if_else_in_if\if_else_in_if_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_in_if\if_else_in_if_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_in_if\if_else_in_if_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_and_if_else(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_and_if_else\if_else_and_if_else.bin ' +
                        r'branching_kernels\if_else_and_if_else\if_else_and_if_else.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_and_if_else\if_else_and_if_else.asm",
                                     r"branching_kernels\if_else_and_if_else\if_else_and_if_else_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_and_if_else\if_else_and_if_else_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_and_if_else\if_else_and_if_else_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_and_if_else_0_labels(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_and_if_else_0_labels\if_else_and_if_else_0_labels.bin ' +
                        r'branching_kernels\if_else_and_if_else_0_labels\if_else_and_if_else_0_labels.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_and_if_else_0_labels\if_else_and_if_else_0_labels.asm",
                                     r"branching_kernels\if_else_and_if_else_0_labels\if_else_and_if_else_0_labels_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_and_if_else_0_labels\if_else_and_if_else_0_labels_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_and_if_else_0_labels\if_else_and_if_else_0_labels_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_in_if_of_if_else(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_in_if_of_if_else\if_else_in_if_of_if_else.bin ' +
                        r'branching_kernels\if_else_in_if_of_if_else\if_else_in_if_of_if_else.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_in_if_of_if_else\if_else_in_if_of_if_else.asm",
                                     r"branching_kernels\if_else_in_if_of_if_else\if_else_in_if_of_if_else_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_in_if_of_if_else\if_else_in_if_of_if_else_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_in_if_of_if_else\if_else_in_if_of_if_else_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_in_else_of_if_else(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_in_else_of_if_else\if_else_in_else_of_if_else.bin ' +
                        r'branching_kernels\if_else_in_else_of_if_else\if_else_in_else_of_if_else.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_in_else_of_if_else\if_else_in_else_of_if_else.asm",
                                     r"branching_kernels\if_else_in_else_of_if_else\if_else_in_else_of_if_else_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_in_else_of_if_else\if_else_in_else_of_if_else_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_in_else_of_if_else\if_else_in_else_of_if_else_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_in_if_and_else_of_if_else(self):
        subprocess.call(r'tests.bat branching_kernels\if_else_in_if_and_else_of_if_else\if_else_in_if_and_else_of_if_else.bin ' +
                        r'branching_kernels\if_else_in_if_and_else_of_if_else\if_else_in_if_and_else_of_if_else.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_in_if_and_else_of_if_else\if_else_in_if_and_else_of_if_else.asm",
                                     r"branching_kernels\if_else_in_if_and_else_of_if_else\if_else_in_if_and_else_of_if_else_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_in_if_and_else_of_if_else\if_else_in_if_and_else_of_if_else_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_in_if_and_else_of_if_else\if_else_in_if_and_else_of_if_else_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


class LinearKernelsTest(unittest.TestCase):
    def test_addition(self):
        subprocess.call(r'tests.bat linear_kernels\addition\addition.bin ' +
                        r'linear_kernels\addition\addition.asm')
        parser_for_instructions.main(r"linear_kernels\addition\addition.asm",
                                     r"linear_kernels\addition\addition_dcmpl.cl")
        with open(
                r"linear_kernels\addition\addition_hands.cl") as hands_decompilation:
            with open(r"linear_kernels\addition\addition_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_subtraction(self):
        subprocess.call(r'tests.bat linear_kernels\subtraction\subtraction.bin ' +
                        r'linear_kernels\subtraction\subtraction.asm')
        parser_for_instructions.main(r"linear_kernels\subtraction\subtraction.asm",
                                     r"linear_kernels\subtraction\subtraction_dcmpl.cl")
        with open(
                r"linear_kernels\subtraction\subtraction_hands.cl") as hands_decompilation:
            with open(r"linear_kernels\subtraction\subtraction_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_multiplication(self):
        subprocess.call(r'tests.bat linear_kernels\multiplication\multiplication.bin ' +
                        r'linear_kernels\multiplication\multiplication.asm')
        parser_for_instructions.main(r"linear_kernels\multiplication\multiplication.asm",
                                     r"linear_kernels\multiplication\multiplication_dcmpl.cl")
        with open(
                r"linear_kernels\multiplication\multiplication_hands.cl") as hands_decompilation:
            with open(r"linear_kernels\multiplication\multiplication_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_many_linears(self):
        subprocess.call(r'tests.bat linear_kernels\many_linears\many_linears.bin ' +
                        r'linear_kernels\many_linears\many_linears.asm')
        parser_for_instructions.main(r"linear_kernels\many_linears\many_linears.asm",
                                     r"linear_kernels\many_linears\many_linears_dcmpl.cl")
        with open(
                r"linear_kernels\many_linears\many_linears_hands.cl") as hands_decompilation:
            with open(r"linear_kernels\many_linears\many_linears_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_work_item_built_in_functions(self):
        subprocess.call(r'tests.bat linear_kernels\work_item_built_in_functions\work_item_built_in_functions.bin ' +
                        r'linear_kernels\work_item_built_in_functions\work_item_built_in_functions.asm')
        parser_for_instructions.main(r"linear_kernels\work_item_built_in_functions\work_item_built_in_functions.asm",
                                     r"linear_kernels\work_item_built_in_functions\work_item_built_in_functions_dcmpl.cl")
        with open(
                r"linear_kernels\work_item_built_in_functions\work_item_built_in_functions_hands.cl") as hands_decompilation:
            with open(r"linear_kernels\work_item_built_in_functions\work_item_built_in_functions_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


class LocalMemoryKernelsTest(unittest.TestCase):
    def test_barrier_1(self):
        subprocess.call(r'tests.bat local_memory_kernels\barrier_1\barrier_1.bin ' +
                        r'local_memory_kernels\barrier_1\barrier_1.asm')
        parser_for_instructions.main(r"local_memory_kernels\barrier_1\barrier_1.asm",
                                     r"local_memory_kernels\barrier_1\barrier_1_dcmpl.cl")
        with open(
                r"local_memory_kernels\barrier_1\barrier_1_hands.cl") as hands_decompilation:
            with open(r"local_memory_kernels\barrier_1\barrier_1_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


class UnusedParams(unittest.TestCase):
    def test_one_unused_param(self):
        subprocess.call(r'tests.bat unused_params\one_unused_param\one_unused_param.bin ' +
                        r'unused_params\one_unused_param\one_unused_param.asm')
        parser_for_instructions.main(r"unused_params\one_unused_param\one_unused_param.asm",
                                     r"unused_params\one_unused_param\one_unused_param_dcmpl.cl")
        with open(
                r"unused_params\one_unused_param\one_unused_param_hands.cl") as hands_decompilation:
            with open(r"unused_params\one_unused_param\one_unused_param_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_two_unused_params(self):
        subprocess.call(r'tests.bat unused_params\two_unused_params\two_unused_params.bin ' +
                        r'unused_params\two_unused_params\two_unused_params.asm')
        parser_for_instructions.main(r"unused_params\two_unused_params\two_unused_params.asm",
                                     r"unused_params\two_unused_params\two_unused_params_dcmpl.cl")
        with open(
                r"unused_params\two_unused_params\two_unused_params_hands.cl") as hands_decompilation:
            with open(r"unused_params\two_unused_params\two_unused_params_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_three_unused_params(self):
        subprocess.call(r'tests.bat unused_params\three_unused_params\three_unused_params.bin ' +
                        r'unused_params\three_unused_params\three_unused_params.asm')
        parser_for_instructions.main(r"unused_params\three_unused_params\three_unused_params.asm",
                                     r"unused_params\three_unused_params\three_unused_params_dcmpl.cl")
        with open(
                r"unused_params\three_unused_params\three_unused_params_hands.cl") as hands_decompilation:
            with open(r"unused_params\three_unused_params\three_unused_params_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_four_unused_params(self):
        subprocess.call(r'tests.bat unused_params\four_unused_params\four_unused_params.bin ' +
                        r'unused_params\four_unused_params\four_unused_params.asm')
        parser_for_instructions.main(r"unused_params\four_unused_params\four_unused_params.asm",
                                     r"unused_params\four_unused_params\four_unused_params_dcmpl.cl")
        with open(
                r"unused_params\four_unused_params\four_unused_params_hands.cl") as hands_decompilation:
            with open(r"unused_params\four_unused_params\four_unused_params_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


class RealKernels(unittest.TestCase):
    def test_mask_kernel(self):
        subprocess.call(r'tests.bat real_kernels\mask_kernel\mask_kernel.bin ' +
                        r'real_kernels\mask_kernel\mask_kernel.asm')
        parser_for_instructions.main(r"real_kernels\mask_kernel\mask_kernel.asm",
                                     r"real_kernels\mask_kernel\mask_kernel_dcmpl.cl")
        with open(
                r"real_kernels\mask_kernel\mask_kernel_hands.cl") as hands_decompilation:
            with open(r"real_kernels\mask_kernel\mask_kernel_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_weighted_sum_kernel(self):
        subprocess.call(r'tests.bat real_kernels\weighted_sum_kernel\weighted_sum_kernel.bin ' +
                        r'real_kernels\weighted_sum_kernel\weighted_sum_kernel.asm')
        parser_for_instructions.main(r"real_kernels\weighted_sum_kernel\weighted_sum_kernel.asm",
                                     r"real_kernels\weighted_sum_kernel\weighted_sum_kernel_dcmpl.cl")
        with open(
                r"real_kernels\weighted_sum_kernel\weighted_sum_kernel_hands.cl") as hands_decompilation:
            with open(r"real_kernels\weighted_sum_kernel\weighted_sum_kernel_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


class DifferentTypes(unittest.TestCase):
    def test_uint8_type_test(self):
        subprocess.call(r'tests.bat different_types\uint8_type_test\uint8_type_test.bin ' +
                        r'different_types\uint8_type_test\uint8_type_test.asm')
        parser_for_instructions.main(r"different_types\uint8_type_test\uint8_type_test.asm",
                                     r"different_types\uint8_type_test\uint8_type_test_dcmpl.cl")
        with open(
                r"different_types\uint8_type_test\uint8_type_test_hands.cl") as hands_decompilation:
            with open(r"different_types\uint8_type_test\uint8_type_test_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_big_type_test(self):
        subprocess.call(r'tests.bat different_types\big_type_test\big_type_test.bin ' +
                        r'different_types\big_type_test\big_type_test.asm')
        parser_for_instructions.main(r"different_types\big_type_test\big_type_test.asm",
                                     r"different_types\big_type_test\big_type_test_dcmpl.cl")
        with open(
                r"different_types\big_type_test\big_type_test_hands.cl") as hands_decompilation:
            with open(r"different_types\big_type_test\big_type_test_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


if __name__ == '__main__':
    unittest.main()
