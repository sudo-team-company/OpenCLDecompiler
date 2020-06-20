import subprocess
import unittest
import parser_for_instructions


class MyTestCase(unittest.TestCase):
    def test_binary_activate_array_kernel(self):
        subprocess.call(r'test.bat real_kernels\binary_activate_array_kernel\binary_activate_array_kernel.bin ' +
                        r'real_kernels\binary_activate_array_kernel\binary_activate_array_kernel.asm')
        parser_for_instructions.main(r"real_kernels\binary_activate_array_kernel\binary_activate_array_kernel.asm",
                                     r"real_kernels\binary_activate_array_kernel\binary_activate_array_kernel_dcmpl.cl")
        with open(
                r"real_kernels\binary_activate_array_kernel\binary_activate_array_kernel_hands.cl") as hands_decompilation:
            with open(r"real_kernels\binary_activate_array_kernel\binary_activate_array_kernel_dcmpl.cl") as decompiled:
                self.assertEqual(hands_decompilation.read(), decompiled.read())

    def test_binary_gradient_array_kernel(self):
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
