import pytest

from .conftest import template


class TestLoopsKernels:
    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_simple_loop_kernels(self, mcpu):
        template('loops_kernels', 'simple_loop_kernels', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", [""])
    def test_loop_with_break_kernels(self, mcpu):
        template('loops_kernels', 'loop_with_break_kernels', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["gfx1010", "gfx1030"])
    def test_simple_loop_1_kernels(self, mcpu):
        template('loops_kernels', 'simple_loop_1_kernels', mcpu=mcpu)
