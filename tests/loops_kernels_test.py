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
    def test_loop_general(self, mcpu):
        template('loops_kernels', 'loop_general', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["gfx1010", "gfx1030"])
    def test_loop_general_dec(self, mcpu):
        template('loops_kernels', 'loop_general_dec', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["gfx1010", "gfx1030"])
    def test_loop_with_unrolling_breaker(self, mcpu):
        template('loops_kernels', 'loop_with_unrolling_breaker', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["gfx1010", "gfx1030"])
    def test_loop_block(self, mcpu):
        template('loops_kernels', 'loop_block', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["gfx1010", "gfx1030"])
    def test_loop_unrolled(self, mcpu):
        template('loops_kernels', 'loop_unrolled', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["gfx1010", "gfx1030"])
    def test_loop_unrolled_2(self, mcpu):
        template('loops_kernels', 'loop_unrolled_2', mcpu=mcpu)
