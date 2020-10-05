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


if __name__ == '__main__':
    unittest.main()
