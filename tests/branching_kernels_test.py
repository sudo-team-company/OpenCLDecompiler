import pytest

from .conftest import template


class TestBranchingKernels:
    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_first(self, mcpu):
        template('branching_kernels', 'if_1', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_second(self, mcpu):
        template('branching_kernels', 'if_2', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_and_if(self, mcpu):
        template('branching_kernels', 'if_and_if', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_0_labels(self, mcpu):
        template('branching_kernels', 'if_else_0_labels', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_1_labels(self, mcpu):
        template('branching_kernels', 'if_else_1_label', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_2_labels(self, mcpu):
        template('branching_kernels', 'if_else_2_labels', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_in_if(self, mcpu):
        template('branching_kernels', 'if_in_if', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_in_if(self, mcpu):
        template('branching_kernels', 'if_else_in_if', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_and_if_else(self, mcpu):
        template('branching_kernels', 'if_else_and_if_else', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_and_if_else_0_labels(self, mcpu):
        template('branching_kernels', 'if_else_and_if_else_0_labels', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_in_if_of_if_else(self, mcpu):
        template('branching_kernels', 'if_else_in_if_of_if_else', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_in_else_of_if_else(self, mcpu):
        template('branching_kernels', 'if_else_in_else_of_if_else', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_else_in_if_and_else_of_if_else(self, mcpu):
        template('branching_kernels', 'if_else_in_if_and_else_of_if_else', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_if_in_if_in_if(self, mcpu):
        template('branching_kernels', 'if_in_if_in_if', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["gfx1010", "gfx1030"])
    def test_if_with_long_expr(self, mcpu):
        template('branching_kernels', 'if_with_long_expr', mcpu=mcpu)
