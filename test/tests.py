import subprocess
import unittest
import parser_for_instructions


class BranchingKernelsTest(unittest.TestCase):
    def test_if_first(self):
        subprocess.call(r'test.bat branching_kernels\if_1\if_1.bin ' +
                        r'branching_kernels\if_1\if_1.asm')
        parser_for_instructions.main(r"branching_kernels\if_1\if_1.asm",
                                     r"branching_kernels\if_1\if_1_dcmpl.cl")
        with open(
                r"branching_kernels\if_1\if_1_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_1\if_1_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_second(self):
        subprocess.call(r'test.bat branching_kernels\if_2\if_2.bin ' +
                        r'branching_kernels\if_2\if_2.asm')
        parser_for_instructions.main(r"branching_kernels\if_2\if_2.asm",
                                     r"branching_kernels\if_2\if_2_dcmpl.cl")
        with open(
                r"branching_kernels\if_2\if_2_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_2\if_2_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_and_if(self):
        subprocess.call(r'test.bat branching_kernels\if_and_if\if_and_if.bin ' +
                        r'branching_kernels\if_and_if\if_and_if.asm')
        parser_for_instructions.main(r"branching_kernels\if_and_if\if_and_if.asm",
                                     r"branching_kernels\if_and_if\if_and_if_dcmpl.cl")
        with open(
                r"branching_kernels\if_and_if\if_and_if_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_and_if\if_and_if_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_0_labels(self):
        subprocess.call(r'test.bat branching_kernels\if_else_0_labels\if_else_0_labels.bin ' +
                        r'branching_kernels\if_else_0_labels\if_else_0_labels.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_0_labels\if_else_0_labels.asm",
                                     r"branching_kernels\if_else_0_labels\if_else_0_labels_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_0_labels\if_else_0_labels_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_0_labels\if_else_0_labels_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_2_labels(self):
        subprocess.call(r'test.bat branching_kernels\if_else_2_labels\if_else_2_labels.bin ' +
                        r'branching_kernels\if_else_2_labels\if_else_2_labels.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_2_labels\if_else_2_labels.asm",
                                     r"branching_kernels\if_else_2_labels\if_else_2_labels_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_2_labels\if_else_2_labels_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_2_labels\if_else_2_labels_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_in_if(self):
        subprocess.call(r'test.bat branching_kernels\if_in_if\if_in_if.bin ' +
                        r'branching_kernels\if_in_if\if_in_if.asm')
        parser_for_instructions.main(r"branching_kernels\if_in_if\if_in_if.asm",
                                     r"branching_kernels\if_in_if\if_in_if_dcmpl.cl")
        with open(
                r"branching_kernels\if_in_if\if_in_if_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_in_if\if_in_if_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_if_else_in_if(self):
        subprocess.call(r'test.bat branching_kernels\if_else_in_if\if_else_in_if.bin ' +
                        r'branching_kernels\if_else_in_if\if_else_in_if.asm')
        parser_for_instructions.main(r"branching_kernels\if_else_in_if\if_else_in_if.asm",
                                     r"branching_kernels\if_else_in_if\if_else_in_if_dcmpl.cl")
        with open(
                r"branching_kernels\if_else_in_if\if_else_in_if_hands.cl") as hands_decompilation:
            with open(r"branching_kernels\if_else_in_if\if_else_in_if_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


class LinearKernelsTest(unittest.TestCase):
    def test_many_linears(self):
        subprocess.call(r'test.bat linear_kernels\many_linears\many_linears.bin ' +
                        r'linear_kernels\many_linears\many_linears.asm')
        parser_for_instructions.main(r"linear_kernels\many_linears\many_linears.asm",
                                     r"linear_kernels\many_linears\many_linears_dcmpl.cl")
        with open(
                r"linear_kernels\many_linears\many_linears_hands.cl") as hands_decompilation:
            with open(r"linear_kernels\many_linears\many_linears_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


class LocalMemoryKernelsTest(unittest.TestCase):
    def test_barrier_1(self):
        subprocess.call(r'test.bat local_memory_kernels\barrier_1\barrier_1.bin ' +
                        r'local_memory_kernels\barrier_1\barrier_1.asm')
        parser_for_instructions.main(r"local_memory_kernels\barrier_1\barrier_1.asm",
                                     r"local_memory_kernels\barrier_1\barrier_1_dcmpl.cl")
        with open(
                r"local_memory_kernels\barrier_1\barrier_1_hands.cl") as hands_decompilation:
            with open(r"local_memory_kernels\barrier_1\barrier_1_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


class RealKernelsTest(unittest.TestCase):
    def test_binary_activate_array_kernel(self):
        subprocess.call(r'test.bat real_kernels\binary_activate_array_kernel\binary_activate_array_kernel.bin ' +
                        r'real_kernels\binary_activate_array_kernel\binary_activate_array_kernel.asm')
        parser_for_instructions.main(r"real_kernels\binary_activate_array_kernel\binary_activate_array_kernel.asm",
                                     r"real_kernels\binary_activate_array_kernel\binary_activate_array_kernel_dcmpl.cl")
        with open(
                r"real_kernels\binary_activate_array_kernel\binary_activate_array_kernel_hands.cl") as hands_decompilation:
            with open(r"real_kernels\binary_activate_array_kernel\binary_activate_array_kernel_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_two(self):
        subprocess.call(r'test.bat real_kernels\binary_gradient_array_kernel\binary_gradient_array_kernel.bin ' +
                        r'real_kernels\binary_gradient_array_kernel\binary_gradient_array_kernel.asm')
        parser_for_instructions.main(r"real_kernels\binary_gradient_array_kernel\binary_gradient_array_kernel.asm",
                                     r"real_kernels\binary_gradient_array_kernel\binary_gradient_array_kernel_dcmpl.cl")
        with open(
                r"real_kernels\binary_gradient_array_kernel\binary_gradient_array_kernel_hands.cl") as hands_decompilation:
            with open(r"real_kernels\binary_gradient_array_kernel\binary_gradient_array_kernel_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_mask_kernel(self):
        subprocess.call(r'test.bat real_kernels\mask_kernel\mask_kernel.bin real_kernels\mask_kernel\mask_kernel.asm')
        parser_for_instructions.main(r"real_kernels\mask_kernel\mask_kernel.asm",
                                     r"real_kernels\mask_kernel\mask_kernel_dcmpl.cl")
        with open(r"real_kernels\mask_kernel\mask_kernel_hands.cl") as hands_decompilation:
            with open(r"real_kernels\mask_kernel\mask_kernel_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_weighted_sum_kernel(self):
        subprocess.call(
            r'test.bat real_kernels\weighted_sum_kernel\weighted_sum_kernel.bin ' +
            r'real_kernels\weighted_sum_kernel\weighted_sum_kernel.asm')
        parser_for_instructions.main(r"real_kernels\weighted_sum_kernel\weighted_sum_kernel.asm",
                                     r"real_kernels\weighted_sum_kernel\weighted_sum_kernel_dcmpl.cl")
        with open(r"real_kernels\weighted_sum_kernel\weighted_sum_kernel_hands.cl") as hands_decompilation:
            with open(r"real_kernels\weighted_sum_kernel\weighted_sum_kernel_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())


if __name__ == '__main__':
    unittest.main()
