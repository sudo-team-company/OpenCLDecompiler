import pytest

from .conftest import template


class TestBranchingKernels:
    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_first(self, mcpu):
        template('branching_kernels', 'if_1', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_second(self, mcpu):
        template('branching_kernels', 'if_2', mcpu=mcpu)

    def test_if_and_if(self):
        template('branching_kernels', 'if_and_if')

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_0_labels(self, mcpu):
        template('branching_kernels', 'if_else_0_labels', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_1_labels(self, mcpu):
        template('branching_kernels', 'if_else_1_label', mcpu=mcpu)

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
